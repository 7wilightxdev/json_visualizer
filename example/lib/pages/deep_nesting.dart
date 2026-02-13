import 'package:flutter/material.dart';
import 'package:json_visualizer/json_visualizer.dart';

Widget buildPage() {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: JsonVisualizer(
        expandDepth: 12,
        data: {
          'level1': {
            'level2': {
              'level3': {
                'level4': {
                  'level5': {
                    'level6': {
                      'level7': {
                        'level8': {
                          'level9': {
                            'level10': {
                              'value': 'deeply nested!',
                              'number': 42,
                            },
                          },
                        },
                      },
                    },
                  },
                },
              },
            },
          },
          'deepArray': [
            [
              [
                [
                  [
                    ['bottom', true, 99],
                  ],
                ],
              ],
            ],
          ],
          'mixed': {
            'users': [
              {
                'profile': {
                  'settings': {
                    'theme': {
                      'colors': {
                        'primary': '#FF0000',
                        'secondary': '#00FF00',
                      },
                    },
                  },
                },
              },
            ],
          },
        },
      ),
    ),
  );
}
