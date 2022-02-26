import 'package:flutter/material.dart';

const Size kImageSize = Size(150, 95);
const Size kBoardSize = Size(500, 500);
enum Direction {
  up,
  down,
  left,
  right,
}
const Map<int, List<Map<int, Direction>>> kBlocksToCheck = {
  0: [
    {1: Direction.right},
    {3: Direction.down}
  ],
  1: [
    {0: Direction.left},
    {2: Direction.right},
    {4: Direction.down}
  ],
  2: [
    {1: Direction.left},
    {5: Direction.down}
  ],
  3: [
    {0: Direction.up},
    {4: Direction.right},
    {6: Direction.down}
  ],
  4: [
    {1: Direction.up},
    {3: Direction.left},
    {5: Direction.right},
    {7: Direction.down}
  ],
  5: [
    {2: Direction.up},
    {4: Direction.left},
    {8: Direction.down}
  ],
  6: [
    {3: Direction.up},
    {7: Direction.right}
  ],
  7: [
    {4: Direction.up},
    {6: Direction.left},
    {8: Direction.right}
  ],
  8: [
    {5: Direction.up},
    {7: Direction.left}
  ]
};
