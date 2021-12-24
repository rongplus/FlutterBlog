

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PlayerWidget extends StatefulWidget {

  PlayerWidget(String name)
  {
    print(name);
    playName = name;
  }
  double xPosition = 0;
  double yPosition = 0;
  String playName="";
  @override
  _PlayerWidgetState createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  double xPosition = 0;
  double yPosition = 0;
  Color color = Colors.blue;
  late FlutterTts flutterTts;

  String? language;
  String? engine;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;

  @override
  void initState() {
    //color = RandomColor().randomColor();
    //widget.yPosition;

    super.initState();
    initTts();
  }

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
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



  List<bool> _selections = List.generate(2, (_) => false);



  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.playName, style:TextStyle(color: Colors.blue.withOpacity(1.0),fontSize: 20),textAlign: TextAlign.center,),
        Spacer(), //make space between text and buttons;

        ToggleButtons(
        children: <Widget>[
        Icon(Icons.cancel ),
        Icon(Icons.bloodtype_sharp),
       // Icon(Icons.add_location),
        ],
        isSelected: _selections,
        onPressed: (int index) async {
           //await flutterTts.awaitSpeakCompletion(true);
           //await flutterTts.speak(widget.playName);
        setState(() {
        _selections[index] = !_selections[index];
        });
        },
        ),
    //     IconButton(
    //       icon: new Icon(Icons.search),
    //       highlightColor: Colors.pink,
    //       onPressed: () async { print("message");
    //       //-----------------------
    //
    // await flutterTts.awaitSpeakCompletion(true);
    // await flutterTts.speak(widget.playName);
    //
    //         //------------------------------
    //       },
    //     )
      ],
    );
  }
}