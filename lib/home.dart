import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:puzzle_hack/board_view.dart';
import 'package:puzzle_hack/test_flame.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GameWidget(game: TestFlame()),
      ),
    );
  }
}
