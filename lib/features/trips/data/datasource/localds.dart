import 'package:audioplayers/audioplayers.dart';

abstract class TripsLocalDatasource {
  ///play sound
  Future playSound(String path);

  ///stop sound
  Future stopSound();
}

class TripsLocalDatasourceImpl implements TripsLocalDatasource {
  final AudioPlayer player;

  TripsLocalDatasourceImpl({required this.player});

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
}
