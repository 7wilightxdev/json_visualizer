import 'package:flutter/material.dart';
import 'package:json_visualizer/json_visualizer.dart';

const _sampleData = {
  'server': {
    'host': 'api.example.com',
    'port': 443,
    'ssl': true,
    'routes': [
      {'path': '/users', 'method': 'GET'},
      {'path': '/posts', 'method': 'POST'},
    ],
  },
  'debug': false,
};

Widget buildPage() {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: const [
      Text('expandDepth: 0 (all collapsed)', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      JsonVisualizer(data: _sampleData, expandDepth: 0),
      SizedBox(height: 32),
      Text('expandDepth: 1 (default)', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      JsonVisualizer(data: _sampleData, expandDepth: 1),
      SizedBox(height: 32),
      Text('expandDepth: 99 (all expanded)', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      JsonVisualizer(data: _sampleData, expandDepth: 99),
      SizedBox(height: 32),
      Text('Small font (12px) + narrow indent (16px)',
          style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      JsonVisualizer(
        data: _sampleData,
        expandDepth: 99,
        fontSize: 12,
        indentWidth: 16,
      ),
      SizedBox(height: 32),
      Text('Large font (20px) + wide indent (40px)', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      JsonVisualizer(
        data: _sampleData,
        expandDepth: 99,
        fontSize: 20,
        indentWidth: 40,
      ),
    ],
  );
}
