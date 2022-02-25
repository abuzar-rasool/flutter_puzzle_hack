import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' hide Animation, Image;
import 'package:provider/provider.dart';
import 'package:puzzle_hack/home.dart';
import 'package:puzzle_hack/state_provider.dart';
import 'package:puzzle_hack/tilemap.dart';

void main() {
  runApp(
    MultiProvider(
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      
    ),
    providers: [
      ChangeNotifierProvider(create: (_) => PuzzleState()),
    ],
  )
  );
}
