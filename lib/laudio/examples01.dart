import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app2/laudio/subtitle.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

final String _STORAGE_URL = "";

void main() {
  runApp(MaterialApp(
    home: SingAlong(
      musicName: "雪莲花",
      uri: "",
      musicImage:
          "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fbpic.588ku.com%2Felement_origin_min_pic%2F18%2F01%2F26%2Fe42638b1438df7cd0e76fb6a7356bdba.jpg&refer=http%3A%2F%2Fbpic.588ku.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1620892296&t=5a6acfbe5af60164b22a93fe39d48b4d",
      lyric:
          "00:00 歌词：\n00:25 我要穿越这片沙漠\n00:28 找寻真的自我\n00:30 身边只有一匹骆驼陪我\n00:34 这片风儿吹过\n00:36 那片云儿飘过",
    ),
  ));
}

/// 跟唱
class SingAlong extends StatefulWidget {
  String musicName; // 音乐名称
  String uri; // 播放地址
  String musicImage; // 音乐图片
  String lyric; // 歌词
  String storage_url; // 录音存储地址

  SingAlong(
      {@required String uri,
      @required String musicImage,
      @required String lyric,
      @required String musicName,
      String storage_url}) {
    this.uri = uri;
    this.musicImage = musicImage;
    this.lyric = lyric;
    this.storage_url = storage_url;
    this.musicName = musicName;
  }

  @override
  _SingAlongState createState() => _SingAlongState(
      uri: this.uri,
      musicImage: this.musicImage,
      lyric: this.lyric,
      storage_url: this.storage_url);
}

class _SingAlongState extends State<SingAlong> with TickerProviderStateMixin {
  FlutterSoundPlayer _myMusicPlayer = FlutterSoundPlayer(); // 音乐播放器
  FlutterSoundPlayer _mSaPlayer = FlutterSoundPlayer(); // 跟唱播放器
  FlutterSoundRecorder _mRecorder = FlutterSoundRecorder(); //录音器
  String uri; // 播放地址
  String musicImage; // 音乐图片
  String lyric; // 歌词
  String storage_url; // 录音存储地址
  String musicName; // 音乐名称

  bool _isPlayerMusic = false; // 是否在播放音乐
  bool _isPlayerSa = false; // 是否在播放录音
  bool _isRecorder = false; //是否在录音
  bool _isBackPlayer = false; //是否可以回放

  _SingAlongState(
      {@required this.uri,
      @required this.musicImage,
      @required this.lyric,
      this.storage_url});

  @override
  void initState() {
    super.initState();
    if (storage_url == null) {
      storage_url = "sound.aac";
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
                Container(
                  // 歌曲图片和播放录音按钮
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
                        // 歌曲图片
                        child: Image.network(
                          musicImage,
                          width: 300,
                          height: 250,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(20),
                            // 播放按钮
                            child: IconButton(
                                icon: Icon(
                                  Icons.play_arrow,
                                  size: 50,
                                ),
                                onPressed: () {
                                  // 播放音乐
                                }),
                          ),
                          Container(
                            margin: EdgeInsets.all(20),
                            // 录音按钮
                            child: IconButton(
                              icon: Icon(
                                Icons.mic_none_rounded,
                                size: 50,
                              ),
                              onPressed: () {},
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 350,
                  height: 400,
                  // 歌词展示
                  child: LyricContent(
                    title: musicName,
                    lyric: this.lyric,
                  ),
                )
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
  LyricContent({Key key, this.title, this.lyric}) : super(key: key);

  final String title; // 标题
  final String lyric; // 歌词

  @override
  _LyricContentState createState() => _LyricContentState(lyric);
}

class _LyricContentState extends State<LyricContent>
    with TickerProviderStateMixin {
  _LyricContentState(this.lyric);

  List<SubtitleEntry> _subtitleList = [];
  String lyric;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    var jsonStr =
    await DefaultAssetBundle.of(context).loadString('assets/subtitle.txt');
    var list = jsonStr.split(RegExp('\n'));
    list.forEach((f) {
      if (f.isNotEmpty) {
        var r = f.split(RegExp(' '));
        if (r.length >= 2) {
          _subtitleList.add(SubtitleEntry(r[0], r[1]));
        }
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Subtitle(
      _subtitleList,
      diameterRatio: 2,
      selectedTextStyle: TextStyle(color: Colors.black, fontSize: 18),
      unSelectedTextStyle: TextStyle(
        color: Colors.black.withOpacity(.6),
      ),
      itemExtent: 45,
    );
  }
}
