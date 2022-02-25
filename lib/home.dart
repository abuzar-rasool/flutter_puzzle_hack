import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:puzzle_hack/tiles.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Tiles(),
    );
  }
}