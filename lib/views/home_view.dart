import 'package:flutter/material.dart';
import 'package:puzzle_hack/views/board_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "HammersmithOne"),
      home: Container(
        decoration: const BoxDecoration(gradient: RadialGradient(colors: [Color(0xff535362), Color(0xff1a1a22)], radius: 1, focalRadius: 1)),
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: BoardView(),
        ),
      ),
    );
  }
}
