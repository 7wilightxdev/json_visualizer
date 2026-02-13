import 'package:flutter/material.dart';
import 'package:json_visualizer/json_visualizer.dart';

Widget buildPage() {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: const [
      Text('Root: String', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      JsonVisualizer(data: 'Hello, World!'),
      SizedBox(height: 24),
      Text('Root: Integer', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      JsonVisualizer(data: 42),
      SizedBox(height: 24),
      Text('Root: Double', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      JsonVisualizer(data: 3.14),
      SizedBox(height: 24),
      Text('Root: Boolean true', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      JsonVisualizer(data: true),
      SizedBox(height: 24),
      Text('Root: Boolean false', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      JsonVisualizer(data: false),
      SizedBox(height: 24),
      Text('Root: Null', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      JsonVisualizer(data: null),
    ],
  );
}
