import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List<Widget> blocks = const [
    //1st row
    Positioned(top: 65, right: 60, child: Block()),
    Positioned(top: 100, right: 0, child: Block()),
    //2nd row
    Positioned(top: 65, right: 181, child: Block()),
    Positioned(top: 100, right: 121, child: Block()),
    Positioned(top: 135, right: 61, child: Block()),
    //2nd row
    Positioned(top: 100, right: 242, child: Block()),
    Positioned(top: 135, right: 182, child: Block()),
    Positioned(top: 170, right: 122, child: Block()),

    // //1st row
    // Positioned(bottom: 30, left: 30, child: Block()),
    // Positioned(bottom: 85, left: 90, child: Block()),
    // Positioned(bottom: 50, left: 150, child: Block()),
    // //2nd row
    // Positioned(bottom: 85, left: -31, child: Block()),
    // Positioned(bottom: 50, left: 29, child: Block()),
    // Positioned(bottom: 15, left: 89, child: Block()),
    // //2nd row
    // Positioned(bottom: 50, left: -92, child: Block()),
    // Positioned(bottom: 15, left: -32, child: Block()),
    // Positioned(bottom: -20, left: 28, child: Block()),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 500,
              height: 500,
              color: Colors.blue,
              child: Stack(
                children: blocks,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Block extends StatelessWidget {
  const Block({
    Key? key,
  }) : super(key: key);

  Color randomColor() {
    return Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255), Random().nextInt(255)).withOpacity(0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: randomColor(), width: 150, height: 150, child: Image.asset('assets/block.png', fit: BoxFit.contain));
  }
}
