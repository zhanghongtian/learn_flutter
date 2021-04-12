import 'dart:async';

import 'package:audio_recorder/audio_recorder.dart';

void main() {
  runApp(MaterialApp(home: MyApp(),));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final audios = <Audio>[
    Audio(
      '/assets/audios/xueronghua.mp3',
      metas: Metas([
        m 
      ]
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: new Row(
          children: [
            new Center(
                child:new Container(
                  child: new ElevatedButton(onPressed: () {_assetsAudioPlayer.playOrPause();}, child: Text("开始录音")),
                )
            ),
            new Center(
                child:new Container(
                  child: new ElevatedButton(onPressed: () {openPlayer();}, child: Text("播放录音")),
                )
            )
          ],
        )
    );
  }
}
