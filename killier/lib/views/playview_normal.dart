import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../playmodel.dart';
import 'package:killier/widgets/moveitem.dart';

import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;


import 'package:flutter_tts/flutter_tts.dart';
enum TtsState { playing, stopped, paused, continued }
class PlayNormalView extends StatefulWidget {
  @override
  _PlayNormalViewState createState() => _PlayNormalViewState();
}

class _PlayNormalViewState extends State<PlayNormalView> with AutomaticKeepAliveClientMixin { //with AutomaticKeepAliveClientMixin
  List<Widget> movableItems = [];


  final List<int> colorCodes = <int>[600, 500, 100];
  late PlayModel model;
  List<bool> _selections = List.generate(3, (_) => false);
  List<bool> _selections4 = List.generate(4, (_) => false);
  //tts
  late FlutterTts flutterTts;

  String? language;
  String? engine;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;
  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWeb => kIsWeb;

  List<MoveableStackItem> ltMoves = [];

  List<DropdownMenuItem<String>> getEnginesDropDownMenuItems(dynamic engines) {
    var items = <DropdownMenuItem<String>>[];
    for (dynamic type in engines) {
      items.add(DropdownMenuItem(
          value: type as String?, child: Text(type as String)));
    }
    return items;
  }
  void changedEnginesDropDownItem(String? selectedEngine) {
    flutterTts.setEngine(selectedEngine!);
    language = null;
    setState(() {
      engine = selectedEngine;
    });
  }

  Widget _enginesDropDownSection(dynamic engines) => Container(
    padding: EdgeInsets.only(top: 50.0),
    child: DropdownButton(
      value: engine,
      items: getEnginesDropDownMenuItems(engines),
      onChanged: changedEnginesDropDownItem,
    ),
  );




  @override
  initState() {
    super.initState();
    initTts();
  }


  initTts() {
    flutterTts = FlutterTts();

    if (isAndroid) {
      _getDefaultEngine();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    if (isWeb || isIOS) {
      flutterTts.setPauseHandler(() {
        setState(() {
          print("Paused");
          ttsState = TtsState.paused;
        });
      });

      flutterTts.setContinueHandler(() {
        setState(() {
          print("Continued");
          ttsState = TtsState.continued;
        });
      });
    }

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future<dynamic> _getLanguages() => flutterTts.getLanguages;

  Future<dynamic> _getEngines() => flutterTts.getEngines;

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }
  String? _newVoiceText;
  Future _speak(String text) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (text != null) {
      if (text.isNotEmpty) {
        await flutterTts.awaitSpeakCompletion(true);
        await flutterTts.speak(text);
      }
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  Future _pause() async {
    var result = await flutterTts.pause();
    if (result == 1) setState(() => ttsState = TtsState.paused);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }


  List<DropdownMenuItem<String>> getLanguageDropDownMenuItems(
      dynamic languages) {
    var items = <DropdownMenuItem<String>>[];
    for (dynamic type in languages) {
      items.add(DropdownMenuItem(
          value: type as String?, child: Text(type as String)));
    }
    return items;
  }
  void changedLanguageDropDownItem(String? selectedType) {
    setState(() {
      language = selectedType;
      flutterTts.setLanguage(language!);
      if (isAndroid) {
        flutterTts
            .isLanguageInstalled(language!)
            .then((value) => isCurrentLanguageInstalled = (value as bool));
      }
    });
  }
  Widget _languageDropDownSection(dynamic languages) => Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        DropdownButton(
          value: language,
          items: getLanguageDropDownMenuItems(languages),
          onChanged: changedLanguageDropDownItem,
        ),
        Visibility(
          visible: isAndroid,
          child: Text("Is installed: $isCurrentLanguageInstalled"),
        ),
      ]));
  Widget _futureBuilder() => FutureBuilder<dynamic>(
      future: _getLanguages(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return _languageDropDownSection(snapshot.data);
        } else if (snapshot.hasError) {
          return Text('Error loading languages...');
        } else
          return Text('Loading Languages...');
      });







  @override
  Widget build(BuildContext context) {

    print("===build-----");
    List<String> players = Provider.of<PlayModel>(context, listen: false).players;
    List<String> roles = Provider.of<PlayModel>(context, listen: false).roles;
    model = Provider.of<PlayModel>(context, listen: false);
    model.addListener(() { setState(() {

    });});
    ltMoves = List<MoveableStackItem>.generate(roles.length, (index) => MoveableStackItem(roles[index],500,110+35.0*index));

    return Scaffold(
        body: Column(
          children: [
            Expanded(flex: 9, // 20%
           child:  Row(
             children:  <Widget>[
               Expanded(
                   flex: 2, // 20%
                   child:ListView.separated(
                     padding: const EdgeInsets.all(8),
                     itemCount: 18,
                     itemBuilder: (BuildContext context, int index) {
                       return Container(
                         height: 50,
                         color: Colors.amber[50],
                         //child: Center(child: PlayerWidget( "${players[index]}")),
                         child: TextField(
                           enabled: true,
                           controller: TextEditingController()..text = "player " +index.toString(),

                           //initialValue: index<_nKiller? "I am smart": (index<_nKiller+_nGod?"dd":"ddeee"),
                           decoration: InputDecoration(
                             //hintText: ps[index],
                             //labelText:"Name",
                           ),
                           onChanged: (String? value) {

                             // This optional block of code can be used to run
                             // code when the user saves the form.
                           },
                         )
                       );
                     },
                     separatorBuilder: (BuildContext context, int index) => const Divider(),
                   )
               ),

               Expanded(
                 flex:8, // 20%
                 child: Stack(
                   children: ltMoves,
                 ),
               ),


             ],
           )
            ),
            Expanded(
                flex:1, // 20%
                child:
                Row(
                  children: [
                    IconButton(
                      icon: new Icon(Icons.wb_sunny,color: Colors.pink,),
                      highlightColor: Colors.pink,
                      onPressed: () async { print("message");
                        //-----------------------
                      await flutterTts.awaitSpeakCompletion(true);
                      await flutterTts.speak("天亮请挣眼。");
                        //------------------------------
                      },
                    ),
                    IconButton(
                      icon: new Icon(Icons.bedtime,color: Colors.grey),
                      highlightColor: Colors.pink,
                      onPressed: () async { print("message");
                        //-----------------------


                       _speak("天黑请闭眼。");
                        //------------------------------
                      },
                    ),
                    Container(
                      width: 1,
                      height: 30.0,
                      color: Colors.red,
                    ),

                    ToggleButtons(
                      children: <Widget>[
                        Icon(Icons.wb_sunny,color: Colors.pink, ),
                        Icon(Icons.bloodtype_sharp,color: Colors.red[200]),
                         Icon(Icons.bedtime,color: Colors.grey),
                      ],
                      isSelected: _selections,
                      onPressed: (int index) async {
                        await flutterTts.awaitSpeakCompletion(true);
                        if (index==0)
                          await flutterTts.speak("狼人请挣眼。");
                        else if  (index==1)
                          await flutterTts.speak("狼人请杀人。");
                        else
                          await flutterTts.speak("狼人请闭眼。");
                      },
                    ),
                    Container(
                      width: 1,
                      height: double.maxFinite,
                      color: Colors.grey,
                    ),
                    ToggleButtons(
                      children: <Widget>[
                        Icon(Icons.wb_sunny,color: Colors.pink, ),
                        Icon(Icons.child_care_rounded,color: Colors.red[200]),
                        Icon(Icons.bedtime,color: Colors.grey),
                      ],
                      isSelected: _selections,
                      onPressed: (int index) async {
                        await flutterTts.awaitSpeakCompletion(true);
                        if (index==0)
                          await flutterTts.speak("预言家请挣眼。");
                        else if  (index==1)
                        await flutterTts.speak("预言家请验人。");
                        else
                        await flutterTts.speak("预言家请闭眼。");
                      },
                    ),
                    Container(
                      width: 1,
                      height: double.maxFinite,
                      color: Colors.grey,
                    ),
                    ToggleButtons(
                      children: <Widget>[
                        Icon(Icons.wb_sunny, color: Colors.pink,),
                        Icon(Icons.colorize_outlined,color: Colors.red[200] ),
                        Icon(Icons.create_sharp ,color: Colors.red[200] ),
                        Icon(Icons.bedtime,color: Colors.grey),
                      ],
                      isSelected: _selections4,
                      onPressed: (int index) async {
                        await flutterTts.awaitSpeakCompletion(true);
                        if (index==0)
                          await flutterTts.speak("女巫请挣眼。");
                        else if  (index==1)
                          await flutterTts.speak("女巫,你有一瓶解药，他死了， 你要救他吗？");
                        else if  (index==2)
                          await flutterTts.speak("女巫,你有一瓶毒药，你要用吗？");
                        else
                          await flutterTts.speak("女巫请闭眼。");
                      },
                    ),
                    _futureBuilder(),
                    IconButton(
                      icon: new Icon(Icons.save),
                      highlightColor: Colors.pink,
                      onPressed: ()  {
                        print("message - save");
                        int i=0;
                        for (var item in ltMoves)
                          {
                            item.reset( 500,110+35.0*i++);
                          }

                      },
                    )
                  ],
                )
            ),
          ],
        )


    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

