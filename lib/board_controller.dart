// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:puzzle_hack/block_controller.dart';
import 'package:puzzle_hack/block_view.dart';
import 'package:puzzle_hack/constants.dart';

class BoardController extends ChangeNotifier {
  late Size boardSize;
  late Offset center;
  late Offset init;
  late double verticalOffset;
  late double horizontalOffset;
  late Offset offset;
  late List<bool> visiblities = [];
  late List<BlockView> blocks = [];
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
  Color get _randomColor => Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255), Random().nextInt(255)).withOpacity(1);

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
    // for (int i = 0; i < blocks.length; i++) {
    //   if (blocks[i].containsPoint(point)) {
    //     print(i);

    //     if (!visiblities[i]) {
    //       move(i, blocksToCheck[i]!.firstWhere((index) => visiblities[index], orElse: () => -1));
    //     }
    //     break;
    //   }
    // }
  }

  move(int? i1, int? i2) {
    // swap block in i1 with i2
    if (i1 != null && i2 != null && i1 != i2 && i1 >= 0 && i2 >= 0) {
      // final blocki1 = blocks[i1].copy();
      // final blocki2 = blocks[i2].copy();
      // final b1pos = blocks[i1].position;
      // final b2pos = blocks[i2].position;
      // blocks.removeAt(i1);
      // blocks.insert(i1, blocki2);
      // blocks.removeAt(i2);
      // blocks.insert(i2, blocki1);
      // blocki1.position = b2pos;
      // blocki2.position = b1pos;
      // blocks[i1].position = blocki2.position;
      // blocks[i2].position = blocki1.position;
      //swap blocks
      // final temp = blocks[i1].copy();
      // blocks[i1] = blocks[i2].copy();
      // blocks[i2] = temp.copy();
      // Offset temp = blocks[i1].position;
      // blocks[i1].moveTo(blocks[i2].position);
      // blocks[i2].moveTo(temp);
      // //swap visiblities
      // visiblities[i1] = false;
      // visiblities[i2] = true;
      // replace blocks by popping and pushing
      final tempBlock1 = BlockView(position: blocks[i2].position, color: blocks[i1].color, empty: blocks[i1].empty);
      final tempBlock2 = BlockView(position: blocks[i1].position, color: blocks[i2].color, empty: blocks[i2].empty);
      blocks[i1] = tempBlock1;
      blocks[i2] = tempBlock2;
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
      BlockView(position: Offset(init.dx, init.dy - offset.dy), color: _randomColor),
      BlockView(position: Offset(init.dx + offset.dx / 2, init.dy - offset.dy / 2), color: _randomColor),
      BlockView(position: Offset(init.dx + offset.dx, init.dy), color: _randomColor),
      //second row
      BlockView(position: Offset(init.dx - offset.dx / 2, init.dy - offset.dy / 2), color: _randomColor),
      BlockView(position: Offset(init.dx, init.dy), color: _randomColor),
      BlockView(position: Offset(init.dx + offset.dx / 2, init.dy + offset.dy / 2), color: _randomColor),
      //thrid row
      BlockView(position: Offset(init.dx - offset.dx, init.dy), color: _randomColor),
      BlockView(position: Offset(init.dx - offset.dx / 2, init.dy + offset.dy / 2), color: _randomColor),
      BlockView(position: Offset(init.dx, init.dy + offset.dy), empty: true, color: _randomColor),
    ];
  }
}
