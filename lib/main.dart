// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Offset? center;
  Offset? init;
  double? vertical_offset;
  double? horizontal_offset;
  Offset? image_dimensions;
  Offset? _scale;
  Offset? offset;

  @override
  void initState() {
    super.initState();
    center = Offset(250, 250);
    init = Offset(center!.dx - 75.0, center!.dy - 42.5);
    image_dimensions = Offset(150, 95);
    offset = Offset(image_dimensions!.dx - 2, image_dimensions!.dy - 9);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> blocks = [
      // first row
      Block(x: init!.dx, y: init!.dy - offset!.dy),
      Block(x: init!.dx + offset!.dx / 2, y: init!.dy - offset!.dy / 2),
      Block(x: init!.dx + offset!.dx, y: init!.dy),
      //second row
      Block(x: init!.dx - offset!.dx / 2, y: init!.dy - offset!.dy / 2),
      Block(x: init!.dx, y: init!.dy),
      Block(x: init!.dx + offset!.dx / 2, y: init!.dy + offset!.dy / 2),
      //thrid row
      Block(x: init!.dx - offset!.dx, y: init!.dy),
      Block(x: init!.dx - offset!.dx / 2, y: init!.dy + offset!.dy / 2),
      Block(x: init!.dx, y: init!.dy + offset!.dy, empty: true),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 500,
                height: 500,
                color: Colors.blue.withOpacity(0.2),
                child: Stack(
                  children: blocks,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Block extends StatelessWidget {
  double? x;
  double? y;
  bool empty;

  Block({
    Key? key,
    @required this.x,
    @required this.y,
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
          width: 150,
          height: 95,
          alignment: Alignment.center,
          child: empty ? Container() : Image.asset('assets/block.png', fit: BoxFit.contain)),
    );
  }
}
