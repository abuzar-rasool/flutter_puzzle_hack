import 'package:flutter/widgets.dart';
import 'package:puzzle_hack/model/block.dart';
import 'package:puzzle_hack/constants.dart';
import 'package:puzzle_hack/direction.dart';

class BoardController extends ChangeNotifier {
  // allows to control the touch on the board
  bool enabled = true;
  //position of the center block on the board
  late Offset _init;
  //the overlaps of the blocks on the board
  late Offset _offset;
  //list of blocks on the board
  late List<Block> blocks = [];

  BoardController() {
    _init = Offset(kBoardSize.width / 2 - kImageSize.width / 2, kBoardSize.height / 2 - kImageSize.height / 2);
    _offset = Offset(kImageSize.width - 2, kImageSize.height - 9);
    blocks = [
      // first row
      Block(globalPosition: Offset(_init.dx, _init.dy - _offset.dy), imageName: 'block-1.png'),
      Block(globalPosition: Offset(_init.dx + _offset.dx / 2, _init.dy - _offset.dy / 2), imageName: 'block-2.png'),
      Block(globalPosition: Offset(_init.dx + _offset.dx, _init.dy), imageName: 'block-3.png'),
      //second row
      Block(globalPosition: Offset(_init.dx - _offset.dx / 2, _init.dy - _offset.dy / 2), imageName: 'block-4.png'),
      Block(globalPosition: Offset(_init.dx, _init.dy), imageName: 'block-5.png'),
      Block(globalPosition: Offset(_init.dx + _offset.dx / 2, _init.dy + _offset.dy / 2), imageName: 'block-6.png'),
      //thrid row
      Block(globalPosition: Offset(_init.dx - _offset.dx, _init.dy), imageName: 'block-7.png'),
      Block(globalPosition: Offset(_init.dx - _offset.dx / 2, _init.dy + _offset.dy / 2), imageName: 'block-8.png'),
      Block(globalPosition: Offset(_init.dx, _init.dy + _offset.dy)),
    ];
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
    enabled = true;
    notifyListeners();
  }

  Offset _cartesianToIsometric(Offset point) {
    return Offset(point.dx - point.dy, (point.dx + point.dy) / 2);
  }
}
