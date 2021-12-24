import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'playmodel.dart';

import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class TTSSentence extends StatefulWidget {
  @override
  _TTSSentenceState createState() => _TTSSentenceState();
}

class _TTSSentenceState extends State<TTSSentence> with AutomaticKeepAliveClientMixin{ //with AutomaticKeepAliveClientMixin



  final List<int> colorCodes = <int>[600, 500, 100];
  late PlayModel model;
  List<String> tts_sentences = [];
  
  double w = 600.0;


  @override
  initState() {
    super.initState();


  }

  //Building input box line short answer component
  Widget _buildTextControllerRow(index) {
    return new Padding(
        padding: const EdgeInsets.all(8.0),
    child: Container(
    color: const Color(0xFFFFFFFF),
    padding: EdgeInsets.only(left: 8.0),
    child: _buildTextField(index),
    ));
  }

  //Building input box components
  Widget _buildTextField(index) {
    //The 'textfield' component allows the user to enter text using a hardware or on-screen keyboard.
    return new TextField(
        cursorColor: const Color(0xFFFE7C30),
        cursorWidth: 2.0,
        keyboardType:  TextInputType.multiline ,// multi line
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10.0),
          //The border of a rounded rectangle
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      controller:  TextEditingController()..text ="abc", // controls the text being edited
      onChanged: (String value) {
        tts_sentences[index] = value;
        },
    );
  }

  Row buildInputRow( index, text)
  {
    return  Row(
      children: [
        Text(text),
        Spacer(),
        Container(
          height: 80,
          width: w,
          child: _buildTextControllerRow(index),
        ),

      ],
    );
  }


  @override
  Widget build(BuildContext context) {

    print("===build-----");

    model = Provider.of<PlayModel>(context, listen: false);
    model.addListener(() { setState(() {

    });});



    return Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
         //------------
            buildInputRow(0,"天黑"),
            buildInputRow(1,"天亮"),
            buildInputRow(2,"杀手-睁眼"),
            buildInputRow(3,"杀手-杀人"),
            buildInputRow(4,"杀手-闭眼"),
            buildInputRow(5,"天黑"),
            buildInputRow(6,"预言家-睁眼"),
            buildInputRow(7,"预言家-验人"),
            buildInputRow(8,"预言家-闭眼"),
            buildInputRow(9,"女巫-睁眼"),
            buildInputRow(10,"女巫-解药"),
            buildInputRow(11,"女巫-毒药"),
            buildInputRow(12,"女巫-闭眼"),
            buildInputRow(13,""),
            buildInputRow(14,""),
            buildInputRow(15,""),
            buildInputRow(16,""),

          ]
        )


    );
  }

  @override
// TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

