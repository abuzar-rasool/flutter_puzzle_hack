// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle_hack/controllers/board_controller.dart';
import 'package:puzzle_hack/views/block_view.dart';
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
          if (context.watch<BoardController>().winState) {
            return AlertDialog(
              title: Text("You Won!"),  
              content: Text("This is an alert message."),
            );
          }
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ResponsiveWrapper(
                  backgroundColor: Color.fromARGB(255, 36, 36, 36).withOpacity(1),
                  maxWidth: 2460,
                  minWidth: 400,
                  defaultScale: true,
                  breakpoints: const [
                    ResponsiveBreakpoint.resize(400, name: MOBILE),
                    ResponsiveBreakpoint.resize(800, name: TABLET),
                    ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                    ResponsiveBreakpoint.resize(2460, name: '4K'),
                  ],
                  child: AbsorbPointer(
                    absorbing: !context.watch<BoardController>().enabled,
                    child: Container(
                      color: Color.fromARGB(255, 36, 36, 36).withOpacity(1),
                      width: 500,
                      height: 500,
                      child: GestureDetector(
                        onTapDown: (TapDownDetails details) async {
                          if (context.read<BoardController>().enabled) {
                            await context.read<BoardController>().detectAndMove(details.localPosition);
                          }
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
