import 'package:flutter/material.dart';
import 'package:json_visualizer/json_visualizer.dart';

Widget buildPage() {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: const [
      Text('JSON string (auto-decoded to Map)', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      JsonVisualizer(
        data: '{"name":"Alice","age":25,"scores":[95,87,92]}',
      ),
      SizedBox(height: 32),
      Text('JSON string (auto-decoded to List)', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      JsonVisualizer(
        data: '[1, "two", true, null, {"nested": true}]',
      ),
      SizedBox(height: 32),
      Text('Invalid JSON string (rendered as plain string)',
          style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      JsonVisualizer(
        data: 'This is not valid JSON {{{',
      ),
      SizedBox(height: 32),
      Text('JSON primitive string ("42" decodes to number)',
          style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      JsonVisualizer(data: '42'),
    ],
  );
}
