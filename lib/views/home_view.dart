import 'package:flutter/material.dart';
import 'package:puzzle_hack/views/board_view.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "HammersmithOne"),
      home: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color.fromARGB(255, 31, 31, 43), Color(0xff191920)], stops: [0, 10])),
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: BoardView(),
        ),
      ),
    );
  }
}
