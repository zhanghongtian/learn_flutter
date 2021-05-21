import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app2/xuelianhua/subtitle.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

const String _STORAGE_URL = "flutter_sound_example.aac";

void main() {
  runApp(MaterialApp(
    home: SingAlong(
      musicName: "雪莲花",
      uri: "https://weiop-test.oss-cn-beijing.aliyuncs.com/xueronghua.mp3",
      musicImage:
          "https://aliyunimg.9ku.com/pic/zjpic/15/141641.jpg?x-oss-process=image/resize,m_fill,w_300,h_300,limit_0/auto-orient,0",
      lyric_file: "assets/lyrics/xueronghua.txt",
    ),
  ));
}

/// 跟唱
class SingAlong extends StatefulWidget {
  String musicName; // 音乐名称
  String uri; // 播放地址
  String musicImage; // 音乐图片
  String lyric_file; // 歌词
  String storage_url; // 录音存储地址

  SingAlong(
      {Key key,
      @required String uri,
      @required String musicImage,
      @required String lyric_file,
      @required String musicName,
      String storage_url = _STORAGE_URL}) {
    this.uri = uri;
    this.musicImage = musicImage;
    this.lyric_file = lyric_file;
    this.storage_url = storage_url;
    this.musicName = musicName;
  }

  @override
  _SingAlongState createState() => _SingAlongState();
}

class _SingAlongState extends State<SingAlong> with TickerProviderStateMixin {
  FlutterSoundPlayer _myMusicPlayer = FlutterSoundPlayer(); // 音乐播放器
  FlutterSoundPlayer _mSaPlayer = FlutterSoundPlayer(); // 跟唱播放器
  FlutterSoundRecorder _mRecorder = FlutterSoundRecorder(); //录音器

  bool _isPlayerMusic = false; // 是否可以播放音乐
  bool _startRollingLyrics = false; // 是否开始滚动歌词
  bool _isPlayerSa = false; // 是否可以播放录音
  bool _isRecorder = false; //是否可以录音
  bool _isBackPlayer = false; //是否可以回放

  @override
  void initState() {
    super.initState();
    if (widget.storage_url == null) {
      widget.storage_url = "sound.aac";
    }

    // 让这个页面横屏展示
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    _myMusicPlayer?.openAudioSession().then((value) {
      setState(() {
        _isPlayerMusic = true;
      });
    });

    _mSaPlayer?.openAudioSession().then((value) {
      setState(() {
        _isPlayerSa = true;
      });
    });

    openTheRecorder().then((value) {
      setState(() {
        _isRecorder = true;
      });
    });
  }

  Future<void> openTheRecorder() async {
    // 判断程序是否是在web上运行
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder?.openAudioSession();
    _isRecorder = true;
  }

  @override
  void dispose() {
    _myMusicPlayer?.closeAudioSession();
    _myMusicPlayer = null;

    _mSaPlayer?.closeAudioSession();
    _mSaPlayer = null;

    _mRecorder?.closeAudioSession();
    _mRecorder = null;

    //页面关闭的是否恢复竖屏
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.dispose();
  }

  void playMusic() {
    //播放音乐
    assert(_isPlayerMusic && _isRecorder && _myMusicPlayer?.isStopped);
    _myMusicPlayer
        ?.startPlayer(
            fromURI: widget.uri,
            //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
            whenFinished: () {
              setState(() {
                // 如果录音没有结束，就解释录音
                if (_mRecorder.isRecording) {
                  stopRecorder();
                }
              });
            })
        .then((value) {
      setState(() {});
    });
  }

  void stopPlayMusic() {
    //停止播放音乐
    _myMusicPlayer?.stopPlayer().then((value) {
      setState(() {
        if (_mRecorder.isRecording) {
          stopRecorder();
        }
      });
    });
  }

  ///
  /// 录音
  ///
  void record() {
    print("录音地址：" + widget.storage_url);
    _mRecorder
        ?.startRecorder(
      toFile: widget.storage_url,
      //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
    )
        .then((value) {
      setState(() {});
    });
  }

  ///
  /// 停止录音
  ///
  void stopRecorder() async {
    await _mRecorder?.stopRecorder().then((value) {
      setState(() {});
    });
  }

  ///
  /// 播放录音
  ///
  void playerRecord() {
    _mSaPlayer
        ?.startPlayer(
            fromURI: widget.storage_url,
            //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
            whenFinished: () {
              setState(() {});
            })
        .then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.greenAccent[100],
      // ),
      body: Column(
        children: [
          Container(
            // 播放、录音、歌词展示
            child: Row(
              children: [
                new Expanded(
                  child: new Container(
                    // 歌曲图片和播放录音按钮
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
                          // 歌曲图片
                          child: Image.network(
                            widget.musicImage,
                            width: 350,
                            height: 200,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(30, 40, 30, 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: IconButton(
                                      icon: Icon(
                                        !_myMusicPlayer.isPlaying
                                            ? Icons.play_arrow
                                            : Icons.stop,
                                        size: 45,
                                      ),
                                      onPressed: () {
                                        // 播放音乐或者停止播放
                                        !_myMusicPlayer.isPlaying
                                            ? playMusic()
                                            : stopPlayMusic();
                                        setState(() {});
                                      })),
                              Expanded(
                                  child: IconButton(
                                icon: Icon(
                                  // 音乐播放才可以使用跟唱功能
                                  !_mRecorder.isRecording
                                      ? Icons.mic_none_rounded
                                      : Icons.workspaces_filled,
                                  size: 45,
                                ),
                                onPressed: () {
                                  print("开始录音");
                                  _mRecorder.isRecording
                                      ? stopRecorder()
                                      : record();
                                },
                              )),
                              Expanded(
                                  child: IconButton(
                                icon: Icon(
                                  // 播放录音按钮
                                  Icons.loop,
                                  size: 45,
                                ),
                                onPressed: () {
                                  playerRecord();
                                },
                              ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                        // 歌词展示
                        alignment: Alignment.center,
                        width: 350,
                        height: 300,
                        // 歌词展示
                        child: _myMusicPlayer.isPlaying
                            ? LyricContent(
                                title: widget.musicName,
                                lyric_file: this.widget.lyric_file,
                                startRollingLyrics:
                                    _myMusicPlayer.isPlaying ? true : false)
                            : Text(widget.musicName)))
              ],
            ),
          ),
          Container(
              // 音调对比栏
              )
        ],
      ),
    );
  }
}

class LyricContent extends StatefulWidget {
  LyricContent({Key key, this.title, this.lyric_file, this.startRollingLyrics})
      : super(key: key);

  final String title; // 标题
  final String lyric_file; // 歌词文件
  bool startRollingLyrics = false; // 开始播放歌词

  @override
  _LyricContentState createState() => _LyricContentState();
}

class _LyricContentState extends State<LyricContent>
    with TickerProviderStateMixin {
  List<SubtitleEntry> _subtitleList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    var jsonStr =
        await DefaultAssetBundle.of(context).loadString(widget.lyric_file);
    var list = jsonStr.split(RegExp('\n'));
    list.forEach((f) {
      if (f.isNotEmpty) {
        var r = f.split(RegExp(']'));
        if (r.length >= 2) {
          _subtitleList.add(SubtitleEntry(r[0], r[1]));
        }
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Subtitle(_subtitleList,
        diameterRatio: 2,
        selectedTextStyle: TextStyle(color: Colors.black, fontSize: 18),
        unSelectedTextStyle: TextStyle(
          color: Colors.black.withOpacity(.6),
        ),
        itemExtent: 45,
        startRollingLyrics: widget.startRollingLyrics);
  }
}
