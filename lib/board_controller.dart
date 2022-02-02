// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:puzzle_hack/constants.dart';

class BoardController extends ChangeNotifier {
  late Size boardSize;
  late Offset center;
  late Offset init;
  late double verticalOffset;
  late double horizontalOffset;
  late Offset offset;
  late List<Block> blocks = [];
  Map<int, List<int>> blocksToCheck = {
    0: [1, 3],
    1: [0, 2, 4],
    2: [1, 5],
    3: [0, 4, 6],
    4: [1, 3, 5, 7],
    5: [2, 4, 8],
    6: [3, 7],
    7: [4, 6, 8],
    8: [5, 7],
  };
  Color get _randomColor => Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255), Random().nextInt(255)).withOpacity(0);

  BoardController() {
    setValues();
  }

  pointPosition(Offset point) {
    for (int i = 0; i < blocks.length; i++) {
      if (blocks[i].containsPoint(point)) {
        print(i);
        if (!blocks[i].empty) {
          move(i, blocksToCheck[i]!.firstWhere((index) => blocks[index].empty, orElse: () => -1));
        }
        break;
      }
    }
  }

  move(int? i1, int? i2) {
    // swap block in i1 with i2
    if (i1 != null && i2 != null && i1 != i2 && i1 >= 0 && i2 >= 0) {
      final blocki1 = blocks[i1].copy();
      final blocki2 = blocks[i2].copy();
      final b1pos = blocks[i1].position;
      final b2pos = blocks[i2].position;
      blocks.removeAt(i1);
      blocks.insert(i1, blocki2);
      blocks.removeAt(i2);
      blocks.insert(i2, blocki1);
      blocki1.position = b2pos;
      blocki2.position = b1pos;
      blocks[i1].position = blocki2.position;
      blocks[i2].position = blocki1.position;

      notifyListeners();
    }
  }

  setValues() {
    boardSize = const Size(500, 500);
    center = const Offset(250, 250);
    init = Offset(center.dx - imageSize.width / 2, center.dy - imageSize.height / 2);
    offset = Offset(imageSize.width - 2, imageSize.height - 9);
    blocks = [
      // first row
      Block(position: Offset(init.dx, init.dy - offset.dy), orignalIndex: 0, color: _randomColor),
      Block(position: Offset(init.dx + offset.dx / 2, init.dy - offset.dy / 2), orignalIndex: 1, color: _randomColor),
      Block(position: Offset(init.dx + offset.dx, init.dy), orignalIndex: 2, color: _randomColor),
      //second row
      Block(position: Offset(init.dx - offset.dx / 2, init.dy - offset.dy / 2), orignalIndex: 3, color: _randomColor),
      Block(position: Offset(init.dx, init.dy), orignalIndex: 4, color: _randomColor),
      Block(position: Offset(init.dx + offset.dx / 2, init.dy + offset.dy / 2), orignalIndex: 5, color: _randomColor),
      //thrid row
      Block(position: Offset(init.dx - offset.dx, init.dy), orignalIndex: 6, color: _randomColor),
      Block(position: Offset(init.dx - offset.dx / 2, init.dy + offset.dy / 2), orignalIndex: 7, color: _randomColor),
      Block(position: Offset(init.dx, init.dy + offset.dy), empty: true, orignalIndex: 8, color: _randomColor),
    ];
  }
}

class Block {
  int orignalIndex;
  Offset position;
  Color color;
  bool empty;
  Block({this.position = Offset.zero, required this.orignalIndex, required this.color, this.empty = false});
  bool containsPoint(Offset point) {
    List<Offset> polygon = [
      Offset(position.dx + imageSize.width / 2, position.dy),
      Offset(position.dx + imageSize.width, position.dy + imageSize.height / 2),
      Offset(position.dx + imageSize.width / 2, position.dy + imageSize.height),
      Offset(position.dx, position.dy + imageSize.height / 2),
    ];
    int i, j = polygon.length - 1;
    bool oddNodes = false;
    for (i = 0; i < polygon.length; i++) {
      if (polygon[i].dy < point.dy && polygon[j].dy >= point.dy || polygon[j].dy < point.dy && polygon[i].dy >= point.dy) {
        if (polygon[i].dx + (point.dy - polygon[i].dy) / (polygon[j].dy - polygon[i].dy) * (polygon[j].dx - polygon[i].dx) < point.dx) {
          oddNodes = !oddNodes;
        }
      }
      j = i;
    }
    return oddNodes;
  }

  copy() {
    return Block(position: position, orignalIndex: orignalIndex, color: color, empty: empty);
  }
}
