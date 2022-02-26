// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle_hack/board_controller.dart';
import 'package:puzzle_hack/block_view.dart';
import 'package:responsive_framework/responsive_framework.dart';

class BoardView extends StatefulWidget {
  const BoardView({
    Key? key,
  }) : super(key: key);

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  @override
  void initState() {
    super.initState();
  }

  List<BlockView> generateBlockViews() {
    List<BlockView> blockViews = [];
    for (int i = 0; i < 9; i++) {
      blockViews.add(BlockView(index: i));
    }
    return blockViews;
  }

  @override
  Widget build(BuildContext _) {
    return ChangeNotifierProvider(
        create: (_) => BoardController(),
        builder: (context, child) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ResponsiveWrapper(
                  backgroundColor: Colors.blue.shade100,
                  maxWidth: 1200,
                  minWidth: 480,
                  defaultScale: true,
                  breakpoints: const [
                    ResponsiveBreakpoint.resize(480, name: MOBILE),
                    ResponsiveBreakpoint.resize(800, name: TABLET),
                    ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                    ResponsiveBreakpoint.resize(2460, name: '4K'),
                  ],
                  child: AbsorbPointer(
                    absorbing: !context.watch<BoardController>().enabled,
                    child: Container(
                      color: Colors.blue.withOpacity(0.2),
                      width: 500,
                      height: MediaQuery.of(context).size.height,
                      child: GestureDetector(
                        onTapDown: (TapDownDetails details) async {
                          await context.read<BoardController>().detectAndMove(details.localPosition);
                        },
                        child: Stack(
                          children: generateBlockViews(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

// class AnimatedTransitionedImage extends StatelessWidget {
//   final String image;

//   final AnimationType;


//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
