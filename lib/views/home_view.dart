import 'package:flutter/material.dart';
import 'package:puzzle_hack/views/board_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: BoardView(),
      ),
    );
  }
}
