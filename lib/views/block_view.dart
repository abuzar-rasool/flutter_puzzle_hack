import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:puzzle_hack/controllers/board_controller.dart';
import 'package:puzzle_hack/constants.dart';

class BlockView extends StatelessWidget {
  final int index;

  BlockView({
    Key? key,
    required this.index,
  }) : super(key: ValueKey(index.toString()));

  @override
  Widget build(BuildContext context) {
    final boardController = context.watch<BoardController>();
    final block = boardController.blocks[index];
    return Positioned(
      top: block.globalPosition.dy,
      left: block.globalPosition.dx,
      child: AbsorbPointer(
        absorbing: !context.watch<BoardController>().enabled,
        child: Container(
          decoration: BoxDecoration(
            color: block.color,
          ),
          width: kImageSize.width,
          height: kImageSize.height,
          child: Stack(
            fit: StackFit.loose,
            clipBehavior: Clip.hardEdge,
            children: [
              AnimatedPositioned(
                top: block.localPosition.dy,
                left: block.localPosition.dx,
                duration: block.animate ? const Duration(milliseconds: 300) : Duration.zero,
                curve: Curves.easeInCubic,
                child: Image.asset(
                  block.imageName ?? 'assets/empty.png',
                  fit: BoxFit.contain,
                  width: kImageSize.width,
                  height: kImageSize.height,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
