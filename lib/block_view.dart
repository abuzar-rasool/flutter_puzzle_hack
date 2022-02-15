import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:puzzle_hack/board_controller.dart';
// ignore: implementation_imports
import 'package:puzzle_hack/constants.dart';

class BlockView extends StatelessWidget {
  Offset position;
  Color color;
  bool empty;

  BlockView({
    Key? key,
    required this.position,
    required this.color,
    this.empty = false,
  }) : super();
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

  @override
  Widget build(BuildContext context) {
    print('block view build');
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      top: position.dy,
      left: position.dx,
      child: Container(
          color: color,
          width: imageSize.width,
          height: imageSize.height,
          alignment: Alignment.center,
          child: Visibility(visible: !empty, child: Image.asset('assets/block.png', fit: BoxFit.contain))),
    );
  }
}
