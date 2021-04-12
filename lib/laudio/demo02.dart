import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
//
// import 'player/PlayingControls.dart';
// import 'player/PositionSeekWidget.dart';
// import 'player/SongsSelector.dart';

void main() {
  AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
    print(notification.audioId);
    return true;
  });

  runApp(MaterialApp(home: MyApp(),));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final audios = <Audio>[
    //Audio.network(
    //  'https://d14nt81hc5bide.cloudfront.net/U7ZRzzHfk8pvmW28sziKKPzK',
    //  metas: Metas(
    //    id: 'Invalid',
    //    title: 'Invalid',
    //    artist: 'Florent Champigny',
    //    album: 'OnlineAlbum',
    //    image: MetasImage.network(
    //        'https://image.shutterstock.com/image-vector/pop-music-text-art-colorful-600w-515538502.jpg'),
    //  ),
    //),
    Audio(
      '/assets/audios/xueronghua.mp3',
      metas: Metas(
        id: 'Online',
        title: 'Online',
        artist: 'Florent Champigny',
        album: 'OnlineAlbum',
        // image: MetasImage.network('https://www.google.cn')
        image: MetasImage.network(
            'https://imagev2.xmcdn.com/group74/M02/28/33/wKgO3F5JHPqwKhIrAAAgc2HJUNc509.jpg'),
      ),
    ),
  ];

  //final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  AssetsAudioPlayer get _assetsAudioPlayer => AssetsAudioPlayer.withId('music');
  final List<StreamSubscription> _subscriptions = [];

  @override
  void initState() {
    super.initState();
    //_subscriptions.add(_assetsAudioPlayer.playlistFinished.listen((data) {
    //  print('finished : $data');
    //}));
    //openPlayer();
    _subscriptions.add(_assetsAudioPlayer.playlistAudioFinished.listen((data) {
      print('playlistAudioFinished : $data');
    }));
    _subscriptions.add(_assetsAudioPlayer.audioSessionId.listen((sessionId) {
      print('audioSessionId : $sessionId');
    }));
    _subscriptions
        .add(AssetsAudioPlayer.addNotificationOpenAction((notification) {
      return false;
    }));
  }

  void openPlayer() async {
    await _assetsAudioPlayer.open(
      Playlist(audios: audios, startIndex: 0),
      showNotification: true,
      autoStart: true,
    );
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    print('dispose');
    super.dispose();
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: new Row(
          children: [
            new Center(
                child:new Container(
                  child: new ElevatedButton(onPressed: () {_assetsAudioPlayer.playOrPause();}, child: Text("暂停")),
                )
            ),
            new Center(
                child:new Container(
                  child: new ElevatedButton(onPressed: () {openPlayer();}, child: Text("播放")),
                )
            ),
            new Center(
                child:new Container(
                  child: new ElevatedButton(onPressed: () {_assetsAudioPlayer.stop();}, child: Text("停止")),
                )
            )
          ],
        )
    );
  }
}
