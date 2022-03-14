import 'package:flutter/material.dart';
import 'package:puzzle_hack/constants.dart';
import 'package:puzzle_hack/helper_functions.dart';

class Block {
  bool hover = false;
  bool animate = true;
  final Offset globalPosition;
  String? imageName;
  Offset localPosition;
  int? currentPlace;
  int? truePlace;
  Color color;
  bool get empty => imageName == null;

  Block({this.globalPosition = Offset.zero, this.truePlace, this.currentPlace})
      : localPosition = Offset.zero,
        color = HelperFunctions.randomColor().withOpacity(kBlockOpacity),
        imageName = currentPlace == 9 ? null : kImages["block_$currentPlace"];

  bool containsPoint(Offset point) {
    List<Offset> polygon = [
      Offset(globalPosition.dx + kImageSize.width / 2, globalPosition.dy),
      Offset(globalPosition.dx + kImageSize.width, globalPosition.dy + kImageSize.height / 2),
      Offset(globalPosition.dx + kImageSize.width / 2, globalPosition.dy + kImageSize.height),
      Offset(globalPosition.dx, globalPosition.dy + kImageSize.height / 2),
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
}
