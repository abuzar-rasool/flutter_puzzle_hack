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
    final blockController = context.watch<BoardController>().blocks[index];
    return Positioned(
      top: blockController.globalPosition.dy,
      left: blockController.globalPosition.dx,
      child: AbsorbPointer(
        absorbing: !context.watch<BoardController>().enabled,
        child: Container(
          color: blockController.color,
          width: kImageSize.width,
          height: kImageSize.height,
          child: Stack(
            fit: StackFit.loose,
            clipBehavior: Clip.hardEdge,
            children: [
              AnimatedPositioned(
                top: blockController.localPosition.dy,
                left: blockController.localPosition.dx,
                duration: blockController.animate ? const Duration(milliseconds: 300) : Duration.zero,
                child: Image.asset(
                  blockController.imageName ?? 'assets/empty.png',
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
