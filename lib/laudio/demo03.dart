import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

///
typedef Fn = void Function();

///
/// 播放、录音
///
void main() {
  runApp(MaterialApp(
    home: MyRecorderApp(),
  ));
}

class MyRecorderApp extends StatefulWidget {
  @override
  _MyRecorderAppState createState() => _MyRecorderAppState();
}

class _MyRecorderAppState extends State<MyRecorderApp> {
  FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();

  bool _mPlayerIsInited = false;

  @override
  void initState() {
    super.initState();
    //播放器
    _mPlayer?.openAudioSession().then((value){
      setState(() {
        _mPlayerIsInited=true;
      });
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: new AppBar(title: new Text("播放音频"),),
  //     body: new Container(
  //       child: new ElevatedButton(onPressed: (){
  //         if(_mPlayerIsInited) play();
  //       }, child: Icon(Icons.play_arrow)),
  //     ),
  //   );
  // }
  void play() async {
    await _mPlayer.startPlayer(
        fromURI: "'https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_700KB.mp3",
        codec: Codec.mp3,
        whenFinished: (){setState((){

        });}
    );
    setState(() {});
  }

  Future<void> stopPlayer() async {
    if (_mPlayer != null) {
      await _mPlayer.stopPlayer();
    }
  }

  @override
  void dispose(){
    /**
     * 关闭会话
     */
    stopPlayer();
    if(_mPlayer!=null){
      _mPlayer.closeAudioSession();
      _mPlayer=null;
    }
    super.dispose();
  }

  Fn getPlaybackFn() {
    if (!_mPlayerIsInited) {
      return null;
    }
    return _mPlayer?.isStopped
        ? play
        : () {
      stopPlayer().then((value) => setState(() {}));
    };
  }

  @override
  Widget build(BuildContext context) {
    Widget makeBody() {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.all(3),
            height: 80,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFFFAF0E6),
              border: Border.all(
                color: Colors.indigo,
                width: 3,
              ),
            ),
            child: Row(children: [
              ElevatedButton(
                onPressed: getPlaybackFn(),
                //color: Colors.white,
                //disabledColor: Colors.grey,
                child: Text(_mPlayer?.isPlaying ? 'Stop' : 'Play'),
              ),
              SizedBox(
                width: 20,
              ),
              Text(_mPlayer?.isPlaying
                  ? 'Playback in progress'
                  : 'Player is stopped'),
            ]),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Simple Playback'),
      ),
      body: makeBody(),
    );
  }
}