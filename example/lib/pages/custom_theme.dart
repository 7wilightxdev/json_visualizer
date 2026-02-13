import 'package:flutter/material.dart';
import 'package:json_visualizer/json_visualizer.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(body: buildPage()),
    ));

const _sampleData = {
  'user': {
    'name': 'Jane Doe',
    'age': 28,
    'verified': true,
    'bio': null,
  },
  'tags': ['flutter', 'dart', 'json'],
  'score': 99.5,
};

Widget buildPage() {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      const Text('Dark theme colors',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const JsonVisualizer(
          expandDepth: 3,
          data: _sampleData,
          colors: JsonVisualizerColors(
            key: Color(0xFF9CDCFE),
            string: Color(0xFFCE9178),
            number: Color(0xFFB5CEA8),
            boolean: Color(0xFF569CD6),
            nullValue: Color(0xFF569CD6),
            bracket: Color(0xFFD4D4D4),
            icon: Color(0xFF6A737D),
          ),
        ),
      ),
      const SizedBox(height: 32),
      const Text('Monokai-inspired colors',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF272822),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const JsonVisualizer(
          expandDepth: 3,
          data: _sampleData,
          colors: JsonVisualizerColors(
            key: Color(0xFFF92672),
            string: Color(0xFFE6DB74),
            number: Color(0xFFAE81FF),
            boolean: Color(0xFFAE81FF),
            nullValue: Color(0xFFAE81FF),
            bracket: Color(0xFFF8F8F2),
            icon: Color(0xFF75715E),
          ),
        ),
      ),
    ],
  );
}
