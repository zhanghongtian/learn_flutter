import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(Audio01App());
}

class Audio01App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "",home: new Scaffold(
      appBar: AppBar(title: new Text("Audio"),),
      body: new Center(
        child: new Container(
          child: ElevatedButton(onPressed: () {
            playerMusic();
          },child: Text("播放"),),
        ),
      ),
    ),);
  }
}



void playerMusic(){
  final assetAudioPlayer =AssetsAudioPlayer();
  assetAudioPlayer.open(
      Audio("assets/audios/xueronghua.mp3")
  );
}
