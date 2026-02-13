import 'package:flutter/material.dart';
import 'package:json_visualizer/json_visualizer.dart';

Widget buildPage() {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: JsonVisualizer(
      expandDepth: 2,
      data: {
        'quotes': 'He said "hello"',
        'backslash': 'C:\\Users\\path',
        'newline': 'Line1\nLine2',
        'tab': 'col1\tcol2',
        'unicode': 'Emoji: \u{1F600} \u{1F680}',
        'vietnamese': 'Xin ch\u00e0o th\u1ebf gi\u1edbi',
        'japanese': '\u3053\u3093\u306b\u3061\u306f',
        'key with "quotes"': 'value',
        'key/with/slashes': 'value',
        'empty string': '',
        'long string': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
            'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      },
    ),
  );
}
