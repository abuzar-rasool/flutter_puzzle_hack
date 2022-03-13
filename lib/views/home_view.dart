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
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xff252532), Color(0xff191920)])),
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: BoardView(),
        ),
      ),
    );
  }
}
