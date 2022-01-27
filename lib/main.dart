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
  Offset? image_dimensions;
  Offset? _scale;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    center = Offset(250, 250);
    init = Offset(center!.dx - 75.0, center!.dy - 42.5);
    vertical_offset = 10;
    image_dimensions = Offset(150, 95);
    _scale = Offset(180, 105);
  }

  // double func_f(double x) {
  //   return (_scale!.dy / _scale!.dx) * x;
  // }

  @override
  Widget build(BuildContext context) {
    List<Widget> blocks = [
      //1st row

      // center top
      Block(x: init!.dx, y: init!.dy - image_dimensions!.dy + vertical_offset!),

      // left center
      Block(
          x: init!.dx + (image_dimensions!.dx * (_scale!.dy / _scale!.dx)),
          y: init!.dy -
              (image_dimensions!.dy * (_scale!.dy / _scale!.dx)) +
              vertical_offset!),

      // center
      Block(x: init!.dx, y: init!.dy),
      // center bottom
      Block(x: init!.dx, y: init!.dy + image_dimensions!.dy - vertical_offset!),

      // Positioned(top: 100, right: 0, child: Block()),
      //2nd row
      // Positioned(top: 65, right: 181, child: Block()),
      // Positioned(top: 125 - 10, right: 175, child: Block()),
      // Positioned(top: 135, right: 61, child: Block()),
      //3rd row
      // Positioned(top: 100, right: 242, child: Block()),
      // Positioned(top: 135, right: 182, child: Block()),
      // Positioned(top: 210 - 10, right: 175, child: Block()),
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

  Block({
    Key? key,
    @required this.x,
    @required this.y,
  }) : super(key: key);

  Color randomColor() {
    return Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255),
            Random().nextInt(255))
        .withOpacity(0.2);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: this.y,
      left: this.x,
      child: Container(
          color: randomColor(),
          width: 150,
          height: 95,
          alignment: Alignment.center,
          child: Image.asset('assets/block.png', fit: BoxFit.contain)),
    );
  }
}
