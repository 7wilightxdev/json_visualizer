import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Color palette for JSON visualizer syntax highlighting.
class JsonVisualizerColors {
  const JsonVisualizerColors({
    this.key = const Color(0xFFA31515),
    this.string = const Color(0xFF0752A5),
    this.number = const Color(0xFF0B8658),
    this.boolean = const Color(0xFF0752A5),
    this.nullValue = const Color(0xFF0752A5),
    this.bracket = const Color(0xFF181818),
    this.icon = const Color(0xFF9A9FA5),
  });

  final Color key;
  final Color string;
  final Color number;
  final Color boolean;
  final Color nullValue;
  final Color bracket;
  final Color icon;
}

/// A visualizer widget for displaying JSON Maps with expand/collapse,
/// syntax highlighting, and per-node copy.
class JsonVisualizerView extends StatelessWidget {
  const JsonVisualizerView({
    super.key,
    required this.data,
    this.colors = const JsonVisualizerColors(),
    this.expandDepth = 1,
    this.fontSize = 16.0,
    this.indentWidth = 24.0,
    this.onCopied,
  });

  final dynamic data;
  final JsonVisualizerColors colors;
  final int expandDepth;
  final double fontSize;
  final double indentWidth;

  /// Called after a node's JSON is copied to clipboard.
  /// If null, copy buttons are hidden.
  final VoidCallback? onCopied;

  @override
  Widget build(BuildContext context) {
    return _ConfigScope(
      colors: colors,
      fontSize: fontSize,
      indentWidth: indentWidth,
      expandDepth: expandDepth,
      onCopied: onCopied,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: _CollapsibleNode(
          nodeKey: null,
          value: data,
          depth: 0,
          isLast: true,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// InheritedWidget to pass config down the tree
// ---------------------------------------------------------------------------

class _ConfigScope extends InheritedWidget {
  const _ConfigScope({
    required this.colors,
    required this.fontSize,
    required this.indentWidth,
    required this.expandDepth,
    required this.onCopied,
    required super.child,
  });

  final JsonVisualizerColors colors;
  final double fontSize;
  final double indentWidth;
  final int expandDepth;
  final VoidCallback? onCopied;

  static _ConfigScope of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_ConfigScope>()!;
  }

  TextStyle get _baseStyle => TextStyle(
        fontFamily: 'monospace',
        fontSize: fontSize,
        height: 1.5,
      );

  @override
  bool updateShouldNotify(_ConfigScope oldWidget) {
    return colors != oldWidget.colors ||
        fontSize != oldWidget.fontSize ||
        indentWidth != oldWidget.indentWidth ||
        expandDepth != oldWidget.expandDepth ||
        onCopied != oldWidget.onCopied;
  }
}

// ---------------------------------------------------------------------------
// _CollapsibleNode – handles Map and List values with expand/collapse
// ---------------------------------------------------------------------------

class _CollapsibleNode extends StatefulWidget {
  const _CollapsibleNode({
    required this.nodeKey,
    required this.value,
    required this.depth,
    required this.isLast,
  });

  /// The key label (null for root node).
  final String? nodeKey;

  /// Must be a Map or List.
  final dynamic value;

  final int depth;
  final bool isLast;

  @override
  State<_CollapsibleNode> createState() => _CollapsibleNodeState();
}

class _CollapsibleNodeState extends State<_CollapsibleNode> {
  bool? _expanded;

  bool get _isMap => widget.value is Map;
  String get _openBracket => _isMap ? '{' : '[';
  String get _closeBracket => _isMap ? '}' : ']';
  int get _childCount => _isMap ? (widget.value as Map).length : (widget.value as List).length;
  String get _comma => widget.isLast ? '' : ',';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _expanded ??= widget.depth < _ConfigScope.of(context).expandDepth;
  }

  List<MapEntry<String, dynamic>> get _entries {
    if (_isMap) {
      return (widget.value as Map<String, dynamic>).entries.toList();
    }
    final list = widget.value as List;
    return List.generate(list.length, (i) => MapEntry(i.toString(), list[i]));
  }

  void _copyNode() {
    final json = const JsonEncoder.withIndent('  ').convert(widget.value);
    Clipboard.setData(ClipboardData(text: json));
    _ConfigScope.of(context).onCopied?.call();
  }

  @override
  Widget build(BuildContext context) {
    final config = _ConfigScope.of(context);

    // Empty collection → render as leaf
    if (_childCount == 0) {
      return _LeafNode(
        nodeKey: widget.nodeKey,
        value: widget.value,
        depth: widget.depth,
        isLast: widget.isLast,
      );
    }

    if (!_expanded!) {
      return _buildCollapsedRow(config);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildExpandedHeader(config),
        ..._buildChildren(config),
        _buildClosingBracket(config),
      ],
    );
  }

  Widget _buildCollapsedRow(_ConfigScope config) {
    final summary = _isMap ? '$_childCount fields' : '$_childCount items';

    final content = Padding(
      padding: EdgeInsets.only(left: widget.depth * config.indentWidth),
      child: GestureDetector(
        onTap: () => setState(() => _expanded = true),
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ArrowIcon(expanded: false, color: config.colors.icon),
            const SizedBox(width: 2),
            Text.rich(
              TextSpan(
                children: [
                  if (widget.nodeKey != null) ...[
                    TextSpan(
                      text: '"${widget.nodeKey}"',
                      style: config._baseStyle.copyWith(color: config.colors.key),
                    ),
                    TextSpan(
                      text: ': ',
                      style: config._baseStyle.copyWith(color: config.colors.bracket),
                    ),
                  ],
                  TextSpan(
                    text: '$_openBracket $summary $_closeBracket$_comma',
                    style: config._baseStyle.copyWith(color: config.colors.bracket),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return _withGuides(widget.depth, config, content);
  }

  Widget _buildExpandedHeader(_ConfigScope config) {
    final content = Padding(
      padding: EdgeInsets.only(left: widget.depth * config.indentWidth),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => setState(() => _expanded = false),
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ArrowIcon(expanded: true, color: config.colors.icon),
                const SizedBox(width: 2),
                Text.rich(
                  TextSpan(
                    children: [
                      if (widget.nodeKey != null) ...[
                        TextSpan(
                          text: '"${widget.nodeKey}"',
                          style: config._baseStyle.copyWith(color: config.colors.key),
                        ),
                        TextSpan(
                          text: ': ',
                          style: config._baseStyle.copyWith(color: config.colors.bracket),
                        ),
                      ],
                      TextSpan(
                        text: _openBracket,
                        style: config._baseStyle.copyWith(color: config.colors.bracket),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (config.onCopied != null) ...[
            const SizedBox(width: 6),
            GestureDetector(
              onTap: _copyNode,
              child: Icon(
                Icons.copy_rounded,
                size: config.fontSize,
                color: config.colors.icon,
              ),
            ),
          ],
        ],
      ),
    );

    return _withGuides(widget.depth, config, content);
  }

  List<Widget> _buildChildren(_ConfigScope config) {
    final entries = _entries;
    return List.generate(entries.length, (i) {
      final entry = entries[i];
      final isLast = i == entries.length - 1;
      final childValue = entry.value;
      final childKey = _isMap ? entry.key : null;

      if ((childValue is Map && childValue.isNotEmpty) ||
          (childValue is List && childValue.isNotEmpty)) {
        return _CollapsibleNode(
          nodeKey: childKey,
          value: childValue is Map ? Map<String, dynamic>.from(childValue) : childValue,
          depth: widget.depth + 1,
          isLast: isLast,
        );
      }

      return _LeafNode(
        nodeKey: childKey,
        value: childValue,
        depth: widget.depth + 1,
        isLast: isLast,
      );
    });
  }

  Widget _buildClosingBracket(_ConfigScope config) {
    final content = Padding(
      padding: EdgeInsets.only(
        left: widget.depth * config.indentWidth + 18,
      ),
      child: Text(
        '$_closeBracket$_comma',
        style: config._baseStyle.copyWith(color: config.colors.bracket),
      ),
    );

    return _withGuides(widget.depth, config, content);
  }
}

// ---------------------------------------------------------------------------
// _LeafNode – handles primitives, empty collections
// ---------------------------------------------------------------------------

class _LeafNode extends StatelessWidget {
  const _LeafNode({
    required this.nodeKey,
    required this.value,
    required this.depth,
    required this.isLast,
  });

  final String? nodeKey;
  final dynamic value;
  final int depth;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final config = _ConfigScope.of(context);
    final comma = isLast ? '' : ',';

    final content = Padding(
      padding: EdgeInsets.only(left: depth * config.indentWidth + 18),
      child: Text.rich(
        TextSpan(
          children: [
            if (nodeKey != null) ...[
              TextSpan(
                text: '"$nodeKey"',
                style: config._baseStyle.copyWith(color: config.colors.key),
              ),
              TextSpan(
                text: ': ',
                style: config._baseStyle.copyWith(color: config.colors.bracket),
              ),
            ],
            _valueSpan(config, comma),
          ],
        ),
      ),
    );

    return _withGuides(depth, config, content);
  }

  TextSpan _valueSpan(_ConfigScope config, String comma) {
    // Empty collections
    if (value is Map) {
      return TextSpan(
        text: '{ }$comma',
        style: config._baseStyle.copyWith(color: config.colors.bracket),
      );
    }
    if (value is List) {
      return TextSpan(
        text: '[ ]$comma',
        style: config._baseStyle.copyWith(color: config.colors.bracket),
      );
    }

    // Null
    if (value == null) {
      return TextSpan(
        text: 'null$comma',
        style: config._baseStyle.copyWith(
          color: config.colors.nullValue,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    // Boolean
    if (value is bool) {
      return TextSpan(
        text: '$value$comma',
        style: config._baseStyle.copyWith(
          color: config.colors.boolean,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    // Number
    if (value is num) {
      return TextSpan(
        text: '$value$comma',
        style: config._baseStyle.copyWith(color: config.colors.number),
      );
    }

    // String
    return TextSpan(
      text: '"$value"$comma',
      style: config._baseStyle.copyWith(color: config.colors.string),
    );
  }
}

// ---------------------------------------------------------------------------
// _ArrowIcon – consistent arrow sizing
// ---------------------------------------------------------------------------

class _ArrowIcon extends StatelessWidget {
  const _ArrowIcon({required this.expanded, required this.color});

  final bool expanded;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      expanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
      size: 16,
      color: color,
    );
  }
}

// ---------------------------------------------------------------------------
// Indent guides – vertical ruler lines for each nesting level
// ---------------------------------------------------------------------------

Widget _withGuides(int depth, _ConfigScope config, Widget child) {
  if (depth <= 0) return child;
  return CustomPaint(
    painter: _IndentGuidesPainter(
      depth: depth,
      indentWidth: config.indentWidth,
      color: config.colors.icon.withValues(alpha: 0.2),
    ),
    child: child,
  );
}

class _IndentGuidesPainter extends CustomPainter {
  const _IndentGuidesPainter({
    required this.depth,
    required this.indentWidth,
    required this.color,
  });

  final int depth;
  final double indentWidth;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    for (int i = 1; i <= depth; i++) {
      // Position guide in the gap between previous level's content and this level's arrow
      final x = i * indentWidth - indentWidth / 4;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _IndentGuidesPainter old) {
    return depth != old.depth || indentWidth != old.indentWidth || color != old.color;
  }
}
