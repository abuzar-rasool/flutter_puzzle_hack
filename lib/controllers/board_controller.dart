// ignore_for_file: avoid_print

import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:puzzle_hack/model/block.dart';
import 'package:puzzle_hack/constants.dart';
import 'package:puzzle_hack/direction.dart';

class BoardController extends ChangeNotifier {
  // allows to control the touch on the board
  bool enabled = true;
  bool winState = false;
  //position of the center block on the board
  late Offset _init;
  //the overlaps of the blocks on the board
  late Offset _offset;
  //list of blocks on the board
  late List<Block> blocks = [];

  BoardController() {
    _init = Offset(kBoardSize.width / 2 - kImageSize.width / 2, kBoardSize.height / 2 - kImageSize.height / 2);
    _offset = Offset(kImageSize.width - 2, kImageSize.height - 9);
    List<int> shuffled = shuffleBlocks();
    blocks = [
      // first row
      Block(globalPosition: Offset(_init.dx, _init.dy - _offset.dy), currentPlace: shuffled[0], truePlace: 1),
      Block(globalPosition: Offset(_init.dx + _offset.dx / 2, _init.dy - _offset.dy / 2), currentPlace: shuffled[1], truePlace: 2),
      Block(globalPosition: Offset(_init.dx + _offset.dx, _init.dy), currentPlace: shuffled[2], truePlace: 3),
      //second row
      Block(globalPosition: Offset(_init.dx - _offset.dx / 2, _init.dy - _offset.dy / 2), currentPlace: shuffled[3], truePlace: 4),
      Block(globalPosition: Offset(_init.dx, _init.dy), currentPlace: shuffled[4], truePlace: 5),
      Block(globalPosition: Offset(_init.dx + _offset.dx / 2, _init.dy + _offset.dy / 2), currentPlace: shuffled[5], truePlace: 6),
      //thrid row
      Block(globalPosition: Offset(_init.dx - _offset.dx, _init.dy), currentPlace: shuffled[6], truePlace: 7),
      Block(globalPosition: Offset(_init.dx - _offset.dx / 2, _init.dy + _offset.dy / 2), currentPlace: shuffled[7], truePlace: 8),
      Block(globalPosition: Offset(_init.dx, _init.dy + _offset.dy), currentPlace: shuffled[8], truePlace: 9),
    ];
  }

  bool isSolvable(List<int> list) {
    int count = 0;
    int emptyVal = 8;
    for (int i = 0; i < list.length; i++) {
      for (int j = i + 1; j < list.length; j++) {
        if (list[i] > list[j] && list[j] != emptyVal && list[i] != emptyVal) {
          count++;
        }
      }
    }
    return count % 2 == 0;
  }

  void resetBoardController() {
    enabled = true;
    winState = false;
    blocks = [];
    BoardController();
    notifyListeners();
  }

  List<int> shuffleBlocks() {
    List<int> shuffled = [];
    bool shuffling = true;
    while (shuffling) {
      int i = Random().nextInt(9) + 1;
      if (!shuffled.contains(i)) {
        shuffled.add(i);
      }
      if (shuffled.length == 9) {
        bool solvable = isSolvable(shuffled);
        if (solvable) {
          shuffling = false;
        } else {
          shuffled = [];
        }
      }
    }
    return shuffled;
  }

  // detect and find the source(containing the point) and target(empty) blocks
  // if both are adjecaent to each other makes the move
  Future<void> detectAndMove(Offset point) async {
    if (enabled) {
      int? sourceBlockIndex = _getBlockIndex(point);
      int? targetBlockIndex = _getEmptyBlockIndex();
      if (sourceBlockIndex != null && targetBlockIndex != null) {
        Direction? direction = _directionOfAdjacentBlock(sourceBlockIndex, targetBlockIndex);
        if (direction != null) {
          await _move(sourceBlockIndex, targetBlockIndex, direction);
        }
      }
    }
  }

  //returns the index of the non empty block in blocks at given point
  int? _getBlockIndex(Offset point) {
    for (int i = 0; i < blocks.length; i++) {
      if (!blocks[i].empty && blocks[i].containsPoint(point)) {
        return i;
      }
    }
    return null;
  }

  //returns the index of the empty block in blocks
  int? _getEmptyBlockIndex() {
    for (int i = 0; i < blocks.length; i++) {
      if (blocks[i].empty) {
        return i;
      }
    }
    return null;
  }

  // returns the direction of the adjacent block of the source block
  // if the source and target blocks are not adjacent, returns null
  Direction? _directionOfAdjacentBlock(int target, int source) {
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
    return null;
  }

  bool checkForWin() {
    bool won = true;
    for (var element in blocks) {
      if (element.currentPlace != element.truePlace) {
        won = false;
      }
    }
    return won;
  }

  //used for the animating the block to their new position in the defined direction
  _move(int? fullBlockIndex, int? emptyBlockIndex, Direction direction) async {
    final fullBlock = blocks[fullBlockIndex!];
    final emptyBlock = blocks[emptyBlockIndex!];
    Offset movementOffset = Offset(
      direction == Direction.left || direction == Direction.right ? 80 : 6.5,
      direction == Direction.left || direction == Direction.right ? 6.5 : 80,
    );
    if (direction == Direction.right || direction == Direction.down) {
      movementOffset = -movementOffset;
    }
    print('------------------');
    print("Moving $fullBlockIndex to $emptyBlockIndex in direction $direction");
    //taking the empty block to the current full block.
    enabled = false;
    emptyBlock.animate = false;
    emptyBlock.localPosition = _cartesianToIsometric(movementOffset);
    emptyBlock.imageName = fullBlock.imageName;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 50));
    //move the empty block to the target block position.
    emptyBlock.animate = true;
    emptyBlock.localPosition = _cartesianToIsometric(Offset.zero);
    fullBlock.localPosition = _cartesianToIsometric(-movementOffset);
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 300));
    fullBlock.animate = false;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 50));
    fullBlock.imageName = null;
    fullBlock.localPosition = _cartesianToIsometric(Offset.zero);
    emptyBlock.animate = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 50));
    emptyBlock.currentPlace = fullBlock.currentPlace;
    fullBlock.currentPlace = 9;
    enabled = true;
    winState = checkForWin();
    notifyListeners();
  }

  Offset _cartesianToIsometric(Offset point) {
    return Offset(point.dx - point.dy, (point.dx + point.dy) / 2);
  }
}