import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';

abstract class TripsLocalDatasource {
  ///play sound
  Future playSound(String path);

  ///stop sound
  Future stopSound();

  //play direction sound
  Future playDirectionSound({required String instruction});

  //stop play direction sound
  Future stopDirectionPlaySound();
}

class TripsLocalDatasourceImpl implements TripsLocalDatasource {
  final AudioPlayer player;
  final FlutterTts flutterTts;

  TripsLocalDatasourceImpl({
    required this.player,
    required this.flutterTts,
  });

  @override
  Future playSound(String path) async {
    player.audioCache = AudioCache(prefix: '');
    player.setReleaseMode(ReleaseMode.loop);

    return await player.play(AssetSource(path));
  }

  @override
  Future stopSound() async {
    return await player.stop();
  }

  @override
  Future playDirectionSound({required String instruction}) async {
    await flutterTts.speak(instruction);
  }

  @override
  Future stopDirectionPlaySound() async {
    await flutterTts.stop();
  }
}
