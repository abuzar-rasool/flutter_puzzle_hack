import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class SoundController {
  final Soundpool _pool;
  int? _tileMovementSoundId;
  int? _winningSound;
  int? _blockHoverSound;

  SoundController() : _pool = Soundpool.fromOptions();

  Future<void> loadSounds() async {
    _tileMovementSoundId = await rootBundle.load("assets/tile_movement_sound.mp3").then((ByteData soundData) {
      return _pool.load(soundData);
    });
    _winningSound = await rootBundle.load("assets/winning_sound.wav").then((ByteData soundData) {
      return _pool.load(soundData);
    });
    _blockHoverSound = await rootBundle.load("assets/tile_hover.wav").then((ByteData soundData) {
      return _pool.load(soundData);
    });
  }

  Future<void> playTileMovementSound({double rate = 1}) async {
    if (_tileMovementSoundId != null) {
      await _pool.play(_tileMovementSoundId!, rate: rate);
    }
  }

  Future<void> playWinningSound({double rate = 1}) async {
    if (_winningSound != null) {
      await _pool.play(_winningSound!, rate: rate);
    }
  }

  Future<void> playBlockHoverSound({double rate = 1}) async {
    if (_blockHoverSound != null) {
      // _pool.stop(_blockHoverSound!);
      await _pool.play(_blockHoverSound!, rate: rate);
    }
  }
}
