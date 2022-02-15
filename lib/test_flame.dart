import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';

class TestFlame extends FlameGame with MouseMovementDetector, TapDetector {
  final topLeft = Vector2(250, 150);
  static const scale = 2.0;
  static const srcTileSize = 32.0;
  static const destTileSize = scale * srcTileSize;

  static const halfSize = true;
  static const tileHeight = scale * (halfSize ? 8.0 : 16.0);
  static const suffix = halfSize ? '-short' : '';

  final originColor = Paint()..color = const Color(0xFFFF00FF);
  final originColor2 = Paint()..color = const Color(0xFFAA55FF);

  late IsometricTileMapComponent base;
  late Selector selector;

  TestFlame();

  @override
  Future<void> onLoad() async {
    final tilesetImage = await images.load('tile_maps/tiles$suffix.png');
    final tileset = SpriteSheet(
      image: tilesetImage,
      srcSize: Vector2.all(srcTileSize),
    );
    final matrix = [
      [1, 0, 1],
      [1, 1, 1],
      [1, 1, -1],
    ];
    base = IsometricTileMapComponent(
      tileset,
      matrix,
      destTileSize: Vector2.all(destTileSize),
      tileHeight: tileHeight,
      position: topLeft,
    );
    add(base);

    final selectorImage = await images.load('tile_maps/selector$suffix.png');
    add(selector = Selector(destTileSize, selectorImage));
    super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.renderPoint(topLeft, size: 6, paint: originColor);
    canvas.renderPoint(
      topLeft.clone()..y -= tileHeight,
      size: 5,
      paint: originColor2,
    );
  }

  @override
  void onMouseMove(PointerHoverInfo info) {
    final screenPosition = info.eventPosition.game;
    // final Block block = base.getBlock(screenPosition);
    // if (base.blockValue(block) != -1) {
    //   selector.show = base.containsBlock(block);
    //   selector.position.setFrom(topLeft + base.getBlockRenderPosition(block));
    // }
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




// class CustomIsometricTileMapComponent extends IsometricTileMapComponent {
//   List<Vector2> tilePositions = [];
//   List<int> tileElements = [];
//   int emptyTileRenderIndex = 8;
//   CustomIsometricTileMapComponent(
//     SpriteSheet tileset,
//     List<List<int>> matrix, {
//     Vector2? destTileSize,
//     double? tileHeight,
//     Vector2? position,
//     Vector2? size,
//     Vector2? scale,
//     double? angle,
//     Anchor? anchor,
//     int? priority,
//   }) : super(
//           tileset,
//           matrix,
//           destTileSize: destTileSize,
//           tileHeight: tileHeight,
//           position: position,
//           size: size,
//           scale: scale,
//           angle: angle,
//           anchor: anchor,
//           priority: priority,
//         ) {
//     for (var i = 0; i < matrix.length; i++) {
//       for (var j = 0; j < matrix[i].length; j++) {
//         final element = matrix[i][j];
//         final p = getBlockRenderPositionInts(j, i);
//         tilePositions.add(p);
//         tileElements.add(element);
//       }
//     }
//   }
//   @override
//   void render(Canvas c) {
//     final size = effectiveTileSize;
//     for (int i = 0; i < matrix.length * matrix[0].length; i++) {
//       final position = tilePositions[i];
//       final element = tileElements[i];
//       if (element != -1) {
//         final sprite = tileset.getSpriteById(element);
//         sprite.render(c, position: position, size: size);
//       } else {
//         emptyTileRenderIndex = i;
//       }
//     }
//   }

//   moveBlockToEmptyPosition(Block block) {
//     final blockRenderPosition = getBlockRenderPosition(block);
//     if (tilePositions.contains(blockRenderPosition)) {
//       final tileRenderIndex = tilePositions.indexOf(blockRenderPosition);
//       final temp = tileElements[tileRenderIndex];
//       tileElements[tileRenderIndex] = tileElements[emptyTileRenderIndex];
//       tileElements[emptyTileRenderIndex] = temp;
//       final effect = MoveEffect.to(Vector2(100, 500), EffectController(duration: 3));
//       effect.add(block);
//       // effect.add();

//     }
//   }
// }
