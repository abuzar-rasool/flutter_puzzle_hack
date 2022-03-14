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
      top: block.globalPosition.dy + (block.hover ? 0 : 5),
      left: block.globalPosition.dx,
      child: AbsorbPointer(
        absorbing: !context.watch<BoardController>().enabled,
        child: Container(
          decoration: BoxDecoration(
            color: block.color,
          ),
          width: kImageSize.width + 5,
          height: kImageSize.height + 5,
          child: Stack(
            fit: StackFit.loose,
            clipBehavior: Clip.hardEdge,
            children: [
              AnimatedPositioned(
                top: block.localPosition.dy,
                left: block.localPosition.dx,
                duration: block.animate ? const Duration(milliseconds: 300) : Duration.zero,
                curve: Curves.easeInExpo,
                child: Image.network(
                  // block.imageName ?? 'assets/empty.png',
                  'https://ae01.alicdn.com/kf/HTB16usCe3mH3KVjSZKzq6z2OXXam/Hot-New-Women-s-Men-s-Finished-Myopia-Glasses-Short-Sight-Eyewear-Black-100-150-200.jpg',
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
