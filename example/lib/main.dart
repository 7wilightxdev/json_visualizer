import 'package:flutter/material.dart';

import 'pages/basic_usage.dart' as basic_usage;
import 'pages/all_value_types.dart' as all_value_types;
import 'pages/primitive_root.dart' as primitive_root;
import 'pages/string_input.dart' as string_input;
import 'pages/special_characters.dart' as special_characters;
import 'pages/empty_collections.dart' as empty_collections;
import 'pages/deep_nesting.dart' as deep_nesting;
import 'pages/large_collection.dart' as large_collection;
import 'pages/custom_theme.dart' as custom_theme;
import 'pages/custom_layout.dart' as custom_layout;
import 'pages/copy_feature.dart' as copy_feature;

void main() => runApp(const GalleryApp());

class GalleryApp extends StatelessWidget {
  const GalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JsonVisualizer Examples',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const _GalleryHome(),
    );
  }
}

class _GalleryHome extends StatelessWidget {
  const _GalleryHome();

  static const _examples = <(String, String, Widget Function())>[
    ('Basic Usage', 'Map & List data', basic_usage.buildPage),
    ('All Value Types', 'string, number, bool, null, nested', all_value_types.buildPage),
    ('Primitive Root', 'Root is string / number / bool / null', primitive_root.buildPage),
    ('String Input', 'Pass raw JSON string, auto-decoded', string_input.buildPage),
    ('Special Characters', 'Quotes, newlines, unicode in values', special_characters.buildPage),
    ('Empty Collections', 'Empty {} and []', empty_collections.buildPage),
    ('Deep Nesting', '10+ levels of nesting', deep_nesting.buildPage),
    ('Large Collection', '500 items with pagination', large_collection.buildPage),
    ('Custom Theme', 'Dark theme with custom colors', custom_theme.buildPage),
    ('Custom Layout', 'fontSize, indentWidth, expandDepth', custom_layout.buildPage),
    ('Copy Feature', 'Copy node JSON to clipboard', copy_feature.buildPage),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('JsonVisualizer Examples')),
      body: ListView.separated(
        itemCount: _examples.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, i) {
          final (title, subtitle, builder) = _examples[i];
          return ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Scaffold(
                  appBar: AppBar(title: Text(title)),
                  body: builder(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
