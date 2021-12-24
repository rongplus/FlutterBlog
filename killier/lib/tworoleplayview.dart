import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'playmodel.dart';
import 'widgets/moveitem.dart';

import 'dart:async';
import 'widgets/nonomoveitem.dart';
import 'painter/towrolepainter.dart';

import 'package:flutter_tts/flutter_tts.dart';
enum TtsState { playing, stopped, paused, continued }
class TwoRolePlayView extends StatefulWidget {
  @override
  _TwoRolePlayViewState createState() => _TwoRolePlayViewState();
}

class _TwoRolePlayViewState extends State<TwoRolePlayView> { //with AutomaticKeepAliveClientMixin



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

  List<MoveableStackItem> movableItems = [];
  List<Widget> ltMoves = [];

  @override
  initState() {
    super.initState();
    initTts();

  }

  initTts() async {
    flutterTts = FlutterTts();


    _getDefaultEngine();


    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");

      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");

      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");

      });
    });



    flutterTts.setContinueHandler(() {
      setState(() {
        print("Continued");

      });
    });

    double volume = 0.5;
    double pitch = 1.0;
    double rate = 0.5;
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);
  }



  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }



  @override
  Widget build(BuildContext context) {

    print("===build-----");
    List<String> players = Provider.of<PlayModel>(context, listen: false).players;
    List<String> roles = Provider.of<PlayModel>(context, listen: false).roles;
    int nPlayer = roles.length;
    ltMoves.clear();
    // movableItems.clear();
    // noneMovableItems.clear();

    ltMoves.add(Container(
      height: 1500,
    ));
    ltMoves.add( Container(
        width: 500,
        height: 1000,
        child:CustomPaint(
          size: Size.infinite, //2
          painter: TwoRolePainter( ), //3
        )));

    for (int n=0; n< roles.length; n++)
    {
      var item = MoveableStackItem(roles[n],600,30+35.0*n);
      movableItems.add(item);
      ltMoves.add(item );
    }

    model = Provider.of<PlayModel>(context, listen: false);
    model.addListener(() { setState(() {

    });});

    return Scaffold(
        body: Column(
          children: [
            Expanded(flex: 9, // 20%
                child:  Row(
                  children:  <Widget>[
                    Expanded(
                        flex: 3, // 20%
                        child:ListView.separated(
                          padding: const EdgeInsets.all(8),
                          itemCount: 14,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 50,
                              color: Colors.amber[50],
                              //child: Center(child: PlayerWidget( "${players[index]}")),
                              child:  NoeMoveableStackItem("player",750,30+ 55.0*index

                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => const Divider(),
                        )
                    ),

                    Expanded(
                      flex:7, // 20%
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
                      await flutterTts.speak("天黑请闭眼。");
                        //------------------------------
                      },
                    ),
                    IconButton(
                      icon: new Icon(Icons.bedtime,color: Colors.grey),
                      highlightColor: Colors.pink,
                      onPressed: () async { print("message");
                      //-----------------------
                      await flutterTts.awaitSpeakCompletion(true);
                      await flutterTts.speak("天亮请挣眼。");
                        //------------------------------
                      },
                    ),
                    Container(
                      width: 1,
                      height: 30.0,
                      color: Colors.grey,
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
                      height: 30.0,
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
                      height: 30.0,
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
                    IconButton(
                      icon: new Icon(Icons.save),
                      highlightColor: Colors.pink,
                      onPressed: ()  {
                        print("message - save");
                        int i=0;
                        for (var item in movableItems)
                        {
                          item.reset( 600,30+45.0*i);
                          i++;
                        }
                        i = 0;


                      },
                    )
                  ],
                )
            ),
          ],
        )


    );
  }

//@override
// TODO: implement wantKeepAlive
//bool get wantKeepAlive => true;
}

