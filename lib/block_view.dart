import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:puzzle_hack/board_controller.dart';
import 'package:puzzle_hack/constants.dart';

class BlockView extends StatelessWidget {
  final int index;

  BlockView({
    Key? key,
    required this.index,
  }) : super(key: ValueKey(index.toString()));

  @override
  Widget build(BuildContext context) {
    final blockController = context.watch<BoardController>().blocks[index];
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      top: blockController.position.dy,
      left: blockController.position.dx,
      child: Container(
          color: blockController.color,
          width: imageSize.width,
          height: imageSize.height,
          alignment: Alignment.center,
          child: blockController.empty ? Container() : Image.asset('assets/block.png', fit: BoxFit.contain)),
    );
  }
}
