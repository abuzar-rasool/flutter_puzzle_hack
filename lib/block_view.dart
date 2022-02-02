import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:puzzle_hack/board_controller.dart';
import 'package:puzzle_hack/constants.dart';

class BlockView extends StatelessWidget {
  final int index;
  final bool empty;

  const BlockView({
    Key? key,
    this.empty = false,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final block = context.watch<BoardController>().blocks[index];
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      top: block.position.dy,
      left: block.position.dx,
      child: Container(
          color: block.color,
          width: imageSize.width,
          height: imageSize.height,
          alignment: Alignment.center,
          child: block.empty ? Container() : Image.asset('assets/block.png', fit: BoxFit.contain)),
    );
  }
}
