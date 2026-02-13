import 'package:flutter/material.dart';
import 'package:json_visualizer/json_visualizer.dart';

Widget buildPage() {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      const Text('Empty root Map', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      JsonVisualizer(data: <String, dynamic>{}),
      const SizedBox(height: 24),
      const Text('Empty root List', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      const JsonVisualizer(data: []),
      const SizedBox(height: 24),
      const Text('Nested empty collections', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      JsonVisualizer(
        expandDepth: 2,
        data: {
          'emptyObject': <String, dynamic>{},
          'emptyArray': [],
          'objectWithEmpty': {
            'data': <String, dynamic>{},
            'items': [],
            'name': 'test',
          },
          'arrayWithEmpty': [
            <String, dynamic>{},
            [],
            'between empties',
            <String, dynamic>{},
          ],
        },
      ),
    ],
  );
}
