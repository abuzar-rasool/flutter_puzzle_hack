import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';

class IsometricTileMapExample extends FlameGame with MouseMovementDetector, MultiTouchTapDetector {
  static const String description = '''
    Shows an example of how to use the `IsometricTileMapComponent`.\n\n
    Move the mouse over the board to see a selector appearing on the tiles.
  ''';

  final topLeft = Vector2.all(500);

  static const scale = 2.0;
  static const srcTileSize = 32.0;
  static const destTileSize = scale * srcTileSize;

  static const halfSize = true;
  static const tileHeight = scale * (halfSize ? 8.0 : 16.0);
  static const suffix = halfSize ? '-short' : '';

  final originColor = Paint()..color = const Color(0xFFFF00FF);
  final originColor2 = Paint()..color = const Color(0xFFAA55FF);

  late Block selectedBlock;

  late IsometricTileMapComponent base;
  late Selector selector;

  IsometricTileMapExample();


  var matrix = [
      [3, 1, 1, 1, 0, 0],
      [1, 1, 2, 1, 0, 0],
      [1, 0, 1, 1, 0, 0],
      [-1, 1, 1, 1, 0, 0],
      [1, 1, 1, 1, 0, 2],
      [1, 3, 3, 3, 0, 2],
    ];


  @override
  Future<void> onLoad() async {
    final tilesetImage = await images.load('tiles$suffix.png');
    final tileset = SpriteSheet(
      image: tilesetImage,
      srcSize: Vector2.all(srcTileSize),
    );
    // var matrix = [
    //   [3, 1, 1, 1, 0, 0],
    //   [-1, 1, 2, 1, 0, 0],
    //   [-1, 0, 1, 1, 0, 0],
    //   [-1, 1, 1, 1, 0, 0],
    //   [1, 1, 1, 1, 0, 2],
    //   [1, 3, 3, 3, 0, 2],
    // ];
    add(
      base = IsometricTileMapComponent(
        tileset,
        matrix,
        destTileSize: Vector2.all(destTileSize),
        tileHeight: tileHeight,
        position: topLeft,
      ),
    );

    final selectorImage = await images.load('selector$suffix.png');
    add(selector = Selector(destTileSize, selectorImage));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.renderPoint(topLeft, size: 5, paint: originColor);
    canvas.renderPoint(
      topLeft.clone()..y -= tileHeight,
      size: 5,
      paint: originColor2,
    );
  }

  Block findEmptyPos() {
    Block pos = Block(0, 0);
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        if (matrix[j][i] == -1) {
          return Block(i, j);
        }
      }
    }
    return pos;
  }

  bool isAdjacent(Block pos1, Block pos2) {
    return ((pos1.x - pos2.x).abs() + (pos1.y - pos2.y).abs()) == 1;
  }

  @override
  void onMouseMove(PointerHoverInfo info) {
    final screenPosition = info.eventPosition.game;
    selectedBlock = base.getBlock(screenPosition);
    selector.show = base.containsBlock(selectedBlock);
    selector.position.setFrom(topLeft + base.getBlockRenderPosition(selectedBlock));
  }

  @override
  void onTap(int pointerId) {
    // print("id:" + selectedBlock.x.toString() + "," + selectedBlock.y.toString());
    Block ePos = findEmptyPos();
    if (isAdjacent(ePos, selectedBlock)) {
      int temp = matrix[selectedBlock.y][selectedBlock.x];
      matrix[ePos.y][ePos.x] = temp;
      matrix[selectedBlock.y][selectedBlock.x] = -1;
      // print(isAdjacent(ePos, selectedBlock));
    }
  }
}

class Selector extends SpriteComponent {
  bool show = true;

  Selector(double s, Image image)
      : super(
          sprite: Sprite(image, srcSize: Vector2.all(32.0)),
          size: Vector2.all(s),
        );

  @override
  void render(Canvas canvas) {
    if (!show) {
      return;
    }

    super.render(canvas);
  }
}