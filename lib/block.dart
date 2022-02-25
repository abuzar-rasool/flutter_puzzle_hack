import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle_hack/constants.dart';
import 'package:puzzle_hack/state_provider.dart';

class Block extends StatefulWidget {
  late int index;
  bool isEmpty;

  Block({
    Key? key,
    @required int this.index = -1,
    bool this.isEmpty = false,
  }) : super(key: key);

  @override
  _BlockState createState() => _BlockState();
}

class _BlockState extends State<Block> {
  double leftOffset = 0;
  double  topOffset = 0;

  void moveBlock(Direction direction) {
    if (direction == Direction.topLeft) {
      setState(() {
        leftOffset = -60;
        topOffset = -60;  
      });
      
    } else if (direction == Direction.topRight) {
      setState(() {
        leftOffset = 60;
        topOffset = -60;  
      });
      
    } else if (direction == Direction.bottomLeft) {
      setState(() {
        leftOffset = -60;
        topOffset = 60;  
      });
    } else if (direction == Direction.bottomRight) {
      setState(() {
        leftOffset = 60;
        topOffset = 60;  
      });
    } else if (direction == Direction.idle) {
      setState(() {
        leftOffset = 0;
        topOffset = 0;  
      });
    }

  }

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onPanUpdate: (details) {
          // Swiping in top right direction.
          if (details.delta.dx > 0 && details.delta.dy < 0) {
            print("Swiping in top right direction");
            moveBlock(Direction.topRight);
          }
          // Swiping in top left direction.
          else if (details.delta.dx < 0 && details.delta.dy < 0) {
            print("Swiping in top left direction");
            moveBlock(Direction.topLeft);
          }
          // Swiping in bottom right direction.
          else if (details.delta.dx > 0 && details.delta.dy > 0) {
            print("Swiping in bottom right direction");
            moveBlock(Direction.bottomRight);
          }
          // Swiping in bottom left direction.
          else if (details.delta.dx < 0 && details.delta.dy > 0) {
            print("Swiping in bottom left direction");
            moveBlock(Direction.bottomLeft);
          }
      
        },
      onTap: () {
        moveBlock(Direction.idle);
      },
      child: Container(
          height: imageSize.height,
          width: imageSize.width,
          // color: Colors.red,
        child: Stack(
          children: [
            AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            height: imageSize.height,
            width: imageSize.width,
            left: leftOffset,
            top: topOffset,
            child: Image.asset('assets/block.png'))
            ],
        ),
      ),
    );
  }
}


enum Direction {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  idle,
}