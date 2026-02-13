import 'package:flutter/material.dart';
import 'package:json_visualizer/json_visualizer.dart';

Widget buildPage() {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: JsonVisualizer(
      expandDepth: 2,
      data: {
        'string': 'Hello, World!',
        'integer': 42,
        'double': 3.14159,
        'negative': -100,
        'zero': 0,
        'boolTrue': true,
        'boolFalse': false,
        'nullValue': null,
        'nestedObject': {
          'key1': 'value1',
          'key2': 2,
        },
        'nestedArray': [1, 'two', true, null],
        'arrayOfObjects': [
          {'id': 1, 'name': 'Alice'},
          {'id': 2, 'name': 'Bob'},
        ],
        'mixedArray': [
          'text',
          123,
          false,
          null,
          {'nested': true},
          [1, 2, 3],
        ],
      },
    ),
  );
}
