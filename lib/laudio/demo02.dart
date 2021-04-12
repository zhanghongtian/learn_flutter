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
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: Scaffold(
  //       backgroundColor: Colors.lightBlue,
  //       body: SafeArea(
  //         child: SingleChildScrollView(
  //           child: Padding(
  //             padding: const EdgeInsets.only(bottom: 48.0),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.max,
  //               crossAxisAlignment: CrossAxisAlignment.stretch,
  //               children: <Widget>[
  //                 SizedBox(
  //                   height: 20,
  //                 ),
  //                 Stack(
  //                   fit: StackFit.passthrough,
  //                   children: <Widget>[
  //                     _assetsAudioPlayer.builderCurrent(
  //                       builder: (BuildContext context, Playing playing) {
  //                         final myAudio =
  //                         find(audios, playing.audio.assetAudioPath);
  //                         return Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Neumorphic(
  //                             style: NeumorphicStyle(
  //                               depth: 8,
  //                               surfaceIntensity: 1,
  //                               shape: NeumorphicShape.concave,
  //                               boxShape: NeumorphicBoxShape.circle(),
  //                             ),
  //                             child: myAudio.metas.image?.path == null
  //                                 ? const SizedBox()
  //                                 : myAudio.metas.image?.type ==
  //                                 ImageType.network
  //                                 ? Image.network(
  //                               myAudio.metas.image?.path,
  //                               height: 150,
  //                               width: 150,
  //                               fit: BoxFit.contain,
  //                             )
  //                                 : Image.asset(
  //                               myAudio.metas.image?.path,
  //                               height: 150,
  //                               width: 150,
  //                               fit: BoxFit.contain,
  //                             ),
  //                           ),
  //                         );
  //                       },
  //                     ),
  //                     Align(
  //                       alignment: Alignment.topRight,
  //                       child: NeumorphicButton(
  //                         style: NeumorphicStyle(
  //                           boxShape: NeumorphicBoxShape.circle(),
  //                         ),
  //                         padding: EdgeInsets.all(18),
  //                         margin: EdgeInsets.all(18),
  //                         onPressed: () {
  //                           AssetsAudioPlayer.playAndForget(
  //                               Audio('assets/audios/horn.mp3'));
  //                         },
  //                         child: Icon(
  //                           Icons.add_alert,
  //                           color: Colors.grey[800],
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(
  //                   height: 20,
  //                 ),
  //                 SizedBox(
  //                   height: 20,
  //                 ),
  //                 _assetsAudioPlayer.builderCurrent(
  //                     builder: (context, Playing? playing) {
  //                       return Column(
  //                         children: <Widget>[
  //                           _assetsAudioPlayer.builderLoopMode(
  //                             builder: (context, loopMode) {
  //                               return PlayerBuilder.isPlaying(
  //                                   player: _assetsAudioPlayer,
  //                                   builder: (context, isPlaying) {
  //                                     return PlayingControls(
  //                                       loopMode: loopMode,
  //                                       isPlaying: isPlaying,
  //                                       isPlaylist: true,
  //                                       onStop: () {
  //                                         _assetsAudioPlayer.stop();
  //                                       },
  //                                       toggleLoop: () {
  //                                         _assetsAudioPlayer.toggleLoop();
  //                                       },
  //                                       onPlay: () {
  //                                         _assetsAudioPlayer.playOrPause();
  //                                       },
  //                                       onNext: () {
  //                                         //_assetsAudioPlayer.forward(Duration(seconds: 10));
  //                                         _assetsAudioPlayer.next(keepLoopMode: true
  //                                           /*keepLoopMode: false*/);
  //                                       },
  //                                       onPrevious: () {
  //                                         _assetsAudioPlayer.previous(
  //                                           /*keepLoopMode: false*/);
  //                                       },
  //                                     );
  //                                   });
  //                             },
  //                           ),
  //                           _assetsAudioPlayer.builderRealtimePlayingInfos(
  //                               builder: (context, RealtimePlayingInfos? infos) {
  //                                 if (infos == null) {
  //                                   return SizedBox();
  //                                 }
  //                                 //print('infos: $infos');
  //                                 return Column(
  //                                   children: [
  //                                     PositionSeekWidget(
  //                                       currentPosition: infos.currentPosition,
  //                                       duration: infos.duration,
  //                                       seekTo: (to) {
  //                                         _assetsAudioPlayer.seek(to);
  //                                       },
  //                                     ),
  //                                     Row(
  //                                       mainAxisAlignment: MainAxisAlignment.center,
  //                                       children: [
  //                                         NeumorphicButton(
  //                                           onPressed: () {
  //                                             _assetsAudioPlayer
  //                                                 .seekBy(Duration(seconds: -10));
  //                                           },
  //                                           child: Text('-10'),
  //                                         ),
  //                                         SizedBox(
  //                                           width: 12,
  //                                         ),
  //                                         NeumorphicButton(
  //                                           onPressed: () {
  //                                             _assetsAudioPlayer
  //                                                 .seekBy(Duration(seconds: 10));
  //                                           },
  //                                           child: Text('+10'),
  //                                         ),
  //                                       ],
  //                                     )
  //                                   ],
  //                                 );
  //                               }),
  //                         ],
  //                       );
  //                     }),
  //                 SizedBox(
  //                   height: 20,
  //                 ),
  //                 _assetsAudioPlayer.builderCurrent(
  //                     builder: (BuildContext context, Playing playing) {
  //                       return SongsSelector(
  //                         audios: audios,
  //                         onPlaylistSelected: (myAudios) {
  //                           _assetsAudioPlayer.open(
  //                             Playlist(audios: myAudios),
  //                             showNotification: true,
  //                             headPhoneStrategy:
  //                             HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
  //                             audioFocusStrategy: AudioFocusStrategy.request(
  //                                 resumeAfterInterruption: true),
  //                           );
  //                         },
  //                         onSelected: (myAudio) async {
  //                           try {
  //                             await _assetsAudioPlayer.open(
  //                               myAudio,
  //                               autoStart: true,
  //                               showNotification: true,
  //                               playInBackground: PlayInBackground.enabled,
  //                               audioFocusStrategy: AudioFocusStrategy.request(
  //                                   resumeAfterInterruption: true,
  //                                   resumeOthersPlayersAfterDone: true),
  //                               headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
  //                               notificationSettings: NotificationSettings(
  //                                 //seekBarEnabled: false,
  //                                 //stopEnabled: true,
  //                                 //customStopAction: (player){
  //                                 //  player.stop();
  //                                 //}
  //                                 //prevEnabled: false,
  //                                 //customNextAction: (player) {
  //                                 //  print('next');
  //                                 //}
  //                                 //customStopIcon: AndroidResDrawable(name: 'ic_stop_custom'),
  //                                 //customPauseIcon: AndroidResDrawable(name:'ic_pause_custom'),
  //                                 //customPlayIcon: AndroidResDrawable(name:'ic_play_custom'),
  //                               ),
  //                             );
  //                           } catch (e) {
  //                             print(e);
  //                           }
  //                         },
  //                         playing: playing,
  //                       );
  //                     }),
  //                 /*
  //                 PlayerBuilder.volume(
  //                     player: _assetsAudioPlayer,
  //                     builder: (context, volume) {
  //                       return VolumeSelector(
  //                         volume: volume,
  //                         onChange: (v) {
  //                           _assetsAudioPlayer.setVolume(v);
  //                         },
  //                       );
  //                     }),
  //                  */
  //                 /*
  //                 PlayerBuilder.forwardRewindSpeed(
  //                     player: _assetsAudioPlayer,
  //                     builder: (context, speed) {
  //                       return ForwardRewindSelector(
  //                         speed: speed,
  //                         onChange: (v) {
  //                           _assetsAudioPlayer.forwardOrRewind(v);
  //                         },
  //                       );
  //                     }),
  //                  */
  //                 /*
  //                 PlayerBuilder.playSpeed(
  //                     player: _assetsAudioPlayer,
  //                     builder: (context, playSpeed) {
  //                       return PlaySpeedSelector(
  //                         playSpeed: playSpeed,
  //                         onChange: (v) {
  //                           _assetsAudioPlayer.setPlaySpeed(v);
  //                         },
  //                       );
  //                     }),
  //                  */
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
