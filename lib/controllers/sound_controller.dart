import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class SoundController {
  final Soundpool _pool;
  int? _tileMovementSoundId;

  SoundController() : _pool = Soundpool.fromOptions();

  Future<void> loadSounds() async {
    _tileMovementSoundId = await rootBundle.load("assets/tile_movement_sound.mp3").then((ByteData soundData) {
      return _pool.load(soundData);
    });
  }

  Future<void> playTileMovementSound({double rate=1})  async {
    if (_tileMovementSoundId != null) {
     await  _pool.play(_tileMovementSoundId!, rate: rate);
    }
  }
}
