// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:puzzle_hack/block.dart';
import 'package:puzzle_hack/constants.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Board extends StatefulWidget {
  const Board({
    Key? key,
  }) : super(key: key);

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  late Size boardSize;
  late Offset center;
  late Offset init;
  late double verticalOffset;
  late double horizontalOffset;
  late Offset offset;
  late List<Block> blocks = [];
  bool isDragging = true;

  pointPosition(Offset point) {
    for (final block in blocks) {
      if (block.containsPoint(point)) {
        print('${block.key}');
        break;
      }
    }
  }

  setValues() {
    boardSize = Size(500, 500);
    center = Offset(250, 250);
    init = Offset(center.dx - imageSize.width / 2, center.dy - imageSize.height / 2);
    offset = Offset(imageSize.width - 2, imageSize.height - 9);
    blocks = [
      // first row
      Block(position: Offset(init.dx, init.dy - offset.dy), key: ValueKey('1')),
      Block(position: Offset(init.dx + offset.dx / 2, init.dy - offset.dy / 2), key: ValueKey('2')),
      Block(position: Offset(init.dx + offset.dx, init.dy), key: ValueKey('3')),
      //second row
      Block(position: Offset(init.dx - offset.dx / 2, init.dy - offset.dy / 2), key: ValueKey('4')),
      Block(position: Offset(init.dx, init.dy), key: ValueKey('5')),
      Block(
        position: Offset(init.dx + offset.dx / 2, init.dy + offset.dy / 2),
        key: ValueKey('6'),
      ),
      //thrid row
      Block(position: Offset(init.dx - offset.dx, init.dy), key: ValueKey('7')),
      Block(position: Offset(init.dx - offset.dx / 2, init.dy + offset.dy / 2), key: ValueKey('8')),
      Block(position: Offset(init.dx, init.dy + offset.dy), empty: true, key: ValueKey('9')),
    ];
  }

  @override
  void initState() {
    super.initState();
    setValues();
  }

  @override
  Widget build(BuildContext context) {
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
            child: Container(
              color: Colors.blue.withOpacity(0.2),
              width: 500,
              height: MediaQuery.of(context).size.height,
              child: GestureDetector(
                onTapDown: (TapDownDetails details) {
                  pointPosition(details.localPosition);
                },
                child: Stack(
                  children: blocks,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
