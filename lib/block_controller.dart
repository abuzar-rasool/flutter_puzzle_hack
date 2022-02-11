import 'package:flutter/material.dart';
import 'package:puzzle_hack/constants.dart';

class BlockController extends ChangeNotifier {
  int orignalIndex;
  Offset position;
  Color color;
  bool empty;
  BlockController({this.position = Offset.zero, required this.orignalIndex, required this.color, this.empty = false});

  void moveTo(Offset newPosition) {
    position = newPosition;
    notifyListeners();
  }

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
    return BlockController(position: position, orignalIndex: orignalIndex, color: color, empty: empty);
  }
}
