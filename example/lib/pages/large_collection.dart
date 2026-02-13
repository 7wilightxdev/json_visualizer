import 'package:flutter/material.dart';
import 'package:json_visualizer/json_visualizer.dart';

Widget buildPage() {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Large List (500 items) - paginated at 100',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        JsonVisualizer(
          data: {
            'total': 500,
            'items': List.generate(
              500,
              (i) => {
                'id': i,
                'name': 'Item #$i',
                'active': i % 2 == 0,
              },
            ),
          },
        ),
        const SizedBox(height: 32),
        const Text('Large flat Map (300 fields)', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        JsonVisualizer(
          data: Map.fromEntries(
            List.generate(300, (i) => MapEntry('field_$i', 'value_$i')),
          ),
        ),
      ],
    ),
  );
}
