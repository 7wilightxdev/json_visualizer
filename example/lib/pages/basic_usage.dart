import 'package:flutter/material.dart';
import 'package:json_visualizer/json_visualizer.dart';

Widget buildPage() {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      const Text('Map (Object)', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      JsonVisualizer(
        data: {
          'name': 'John Doe',
          'age': 30,
          'active': true,
          'address': {
            'street': '123 Main St',
            'city': 'Springfield',
          },
        },
      ),
      const SizedBox(height: 32),
      const Text('List (Array)', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      JsonVisualizer(
        data: [
          'apple',
          'banana',
          'cherry',
          {'name': 'durian', 'tropical': true},
        ],
      ),
    ],
  );
}
