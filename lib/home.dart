// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(Home());
}

const Size imageSize = Size(150, 95);

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Board(),
      ),
    );
  }
}

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
      Block(x: init.dx, y: init.dy - offset.dy, key: ValueKey('1')),
      Block(x: init.dx + offset.dx / 2, y: init.dy - offset.dy / 2, key: ValueKey('2')),
      Block(x: init.dx + offset.dx, y: init.dy, key: ValueKey('3')),
      //second row
      Block(x: init.dx - offset.dx / 2, y: init.dy - offset.dy / 2, key: ValueKey('4')),
      Block(x: init.dx, y: init.dy, key: ValueKey('5')),
      Block(
        x: init.dx + offset.dx / 2,
        y: init.dy + offset.dy / 2,
        key: ValueKey('6'),
      ),
      //thrid row
      Block(x: init.dx - offset.dx, y: init.dy, key: ValueKey('7')),
      Block(x: init.dx - offset.dx / 2, y: init.dy + offset.dy / 2, key: ValueKey('8')),
      Block(x: init.dx, y: init.dy + offset.dy, empty: true, key: ValueKey('9')),
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

class Block extends StatelessWidget {
  late double x;
  late double y;
  final bool empty;

  bool containsPoint(Offset point) {
    List<Offset> polygon = [
      Offset(x + imageSize.width / 2, y),
      Offset(x + imageSize.width, y + imageSize.height / 2),
      Offset(x + imageSize.width / 2, y + imageSize.height),
      Offset(x, y + imageSize.height / 2),
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

  Block({
    Key? key,
    this.x = 0,
    this.y = 0,
    this.empty = false,
  }) : super(key: key);

  Color randomColor() {
    return Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255), Random().nextInt(255)).withOpacity(0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 500),
      top: y,
      left: x,
      child: Container(
          color: randomColor(),
          width: imageSize.width,
          height: imageSize.height,
          alignment: Alignment.center,
          child: empty ? Container() : Image.asset('assets/block.png', fit: BoxFit.contain)),
    );
  }
}
