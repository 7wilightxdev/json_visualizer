import 'package:flutter/material.dart';
import 'package:json_visualizer/json_visualizer.dart';

Widget buildPage() {
  return Builder(builder: (context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('With copy button (tap copy icon on expanded nodes)',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        JsonVisualizer(
          expandDepth: 2,
          data: {
            'user': {
              'id': 1,
              'name': 'Alice',
              'email': 'alice@example.com',
            },
            'permissions': ['read', 'write', 'admin'],
            'active': true,
          },
          onCopied: () {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('JSON copied to clipboard!'),
                  duration: Duration(seconds: 1),
                ),
              );
          },
        ),
        const SizedBox(height: 32),
        const Text('Without copy button (onCopied = null)',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        JsonVisualizer(
          expandDepth: 2,
          data: {
            'info': {'message': 'No copy icon here'},
            'list': [1, 2, 3],
          },
        ),
      ],
    );
  });
}
