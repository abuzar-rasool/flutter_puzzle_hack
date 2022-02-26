import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:puzzle_hack/block_controller.dart';
import 'package:puzzle_hack/constants.dart';

class BoardController extends ChangeNotifier {
  bool enabled = true;
  late List<BlockController> blocks = [];
  BoardController() {
    setValues();
  }
  List<List<int>> blockPositions = [];

  Future<void> detectAndMove(Offset point) async {
    if (enabled) {
      for (int i = 0; i < blocks.length; i++) {
        if (blocks[i].containsPoint(point)) {
          if (!blocks[i].empty) {
            for (int j = 0; j < blocks.length; j++) {
              if (blocks[j].empty) {
                Direction? direction = directionOfAdjacentBlock(j, i);
                if (direction != null) {
                  await move(i, j, direction);
                }
                break;
              }
            }
          }
          break;
        }
      }
    }
  }

  directionOfAdjacentBlock(int source, int target) {
    int sourceX = source ~/ 3;
    int sourceY = source % 3;
    int targetX = target ~/ 3;
    int targetY = target % 3;
    if (sourceX == targetX) {
      if (sourceY == targetY - 1) {
        return Direction.left;
      } else if (sourceY == targetY + 1) {
        return Direction.right;
      }
    } else if (sourceY == targetY) {
      if (sourceX == targetX - 1) {
        return Direction.up;
      } else if (sourceX == targetX + 1) {
        return Direction.down;
      }
    }
  }

  move(int? fullBlockIndex, int? emptyBlockIndex, Direction direction) async {
    enabled = false;
    Offset entryOffset = Offset.zero;
    Offset exitOffset = Offset.zero;
    if (direction == Direction.down) {
      entryOffset = const Offset(-6, -81);
      exitOffset = const Offset(6, 81);
    } else if (direction == Direction.up) {
      entryOffset = const Offset(6, 81);
      exitOffset = const Offset(-6, -81);
    } else if (direction == Direction.left) {
      entryOffset = const Offset(81, 6);
      exitOffset = const Offset(-81, -6);
    } else if (direction == Direction.right) {
      entryOffset = const Offset(-81, -6);
      exitOffset = const Offset(81, 6);
    }
    final fullBlock = blocks[fullBlockIndex!];
    final emptyBlock = blocks[emptyBlockIndex!];
    emptyBlock.animate = false;
    emptyBlock.localPosition = cartesianToIsometric(entryOffset);
    emptyBlock.imageName = fullBlock.imageName;
    notifyListeners();
    await Future.delayed(const Duration(microseconds: 1));
    //move
    emptyBlock.animate = true;
    emptyBlock.localPosition = cartesianToIsometric(Offset.zero);
    fullBlock.localPosition = cartesianToIsometric(exitOffset);
    enabled = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 1200));
    fullBlock.imageName = null;
    fullBlock.localPosition = cartesianToIsometric(Offset.zero);
  }

  setValues() {
    Offset center = const Offset(250, 250);
    Offset init = Offset(center.dx - kImageSize.width / 2, center.dy - kImageSize.height / 2);
    Offset offset = Offset(kImageSize.width - 2, kImageSize.height - 9);
    blocks = [
      // first row
      BlockController(globalPosition: Offset(init.dx, init.dy - offset.dy), imageName: 'block-1.png'),
      BlockController(globalPosition: Offset(init.dx + offset.dx / 2, init.dy - offset.dy / 2), imageName: 'block-2.png'),
      BlockController(globalPosition: Offset(init.dx + offset.dx, init.dy), imageName: 'block-3.png'),
      //second row
      BlockController(globalPosition: Offset(init.dx - offset.dx / 2, init.dy - offset.dy / 2), imageName: 'block-4.png'),
      BlockController(globalPosition: Offset(init.dx, init.dy), imageName: 'block-5.png'),
      BlockController(globalPosition: Offset(init.dx + offset.dx / 2, init.dy + offset.dy / 2), imageName: 'block-6.png'),
      //thrid row
      BlockController(globalPosition: Offset(init.dx - offset.dx, init.dy), imageName: 'block-7.png'),
      BlockController(globalPosition: Offset(init.dx - offset.dx / 2, init.dy + offset.dy / 2), imageName: 'block-8.png'),
      BlockController(globalPosition: Offset(init.dx, init.dy + offset.dy)),
    ];
  }

  Offset cartesianToIsometric(Offset point) {
    return Offset(point.dx - point.dy, (point.dx + point.dy) / 2);
  }

  Offset isometricToCartesian(Offset point) {
    return Offset(point.dx + point.dy, (point.dx - point.dy) / 2);
  }
}
