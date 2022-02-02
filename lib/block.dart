import 'dart:math';

import 'package:flutter/material.dart';
import 'package:puzzle_hack/constants.dart';

class Block extends StatelessWidget {
  late Offset position;
  final bool empty;

  Block({
    Key? key,
    this.position = Offset.zero,
    this.empty = false,
  }) : super(key: key);

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

  Color randomColor() {
    return Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255), Random().nextInt(255)).withOpacity(0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 500),
      top: position.dy,
      left: position.dx,
      child: Container(
          color: randomColor(),
          width: imageSize.width,
          height: imageSize.height,
          alignment: Alignment.center,
          child: empty ? Container() : Image.asset('assets/block.png', fit: BoxFit.contain)),
    );
  }
}
