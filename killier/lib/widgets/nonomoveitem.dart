import 'package:flutter/material.dart';

class NoeMoveableStackItem extends StatefulWidget {
  NoeMoveableStackItem(String name, double x,double y)
  {
    xPosition = x;
    yPosition = y;
    roleName = name;
    print("Create '$name'");
  }

  void reset(double x, double y)
  {
    _state.reset(x, y);
  }

  double xPosition = 0;
  double yPosition = 0;
  String roleName = "";
  @override
  _NoeMoveableStackItemState createState() {
    // _state = _MoveableStackItemState(xPosition, yPosition);
    _state.reset111(xPosition, yPosition);
    return _state;
  }

  _NoeMoveableStackItemState _state = _NoeMoveableStackItemState(0, 0);

}

class _NoeMoveableStackItemState extends State<NoeMoveableStackItem> {
  double xPosition = 0;
  double yPosition = 0;
  Color color = Colors.orange;
  List<bool> _selections = List.generate(1, (_) => false);

  void reset111(double x, double y)
  {
    {
      _selections[0] = false;

      xPosition = x;
      yPosition = y;
    };
  }

  void reset(double x, double y)
  {
    print("here 1");
    setState(() {
      _selections[0] = false;

      xPosition = x;
      yPosition = y;
    });
  }

  _NoeMoveableStackItemState(double x, double y)
  {
    xPosition = x;
    yPosition = y;
  }

  @override
  void initState() {
    //color = RandomColor().randomColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: yPosition,
      left: xPosition,
      child: GestureDetector(
        onPanUpdate: (tapInfo) {
          setState(() {
            xPosition += tapInfo.delta.dx;
            yPosition += tapInfo.delta.dy;
          });
        },
        child: Container(
          width: 240,
          height: 50,
          padding: const EdgeInsets.all(3.0),
          color: Colors.deepOrange[100],
          child: Row(
            children: [
              Container(
              width: 180,
                height: 50,
                child:  TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),

                ),
                  controller: TextEditingController()..text = widget.roleName,
                  onChanged: (String? value) {

                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },

              ),
              )
             ,
              Spacer(), //make space between text and buttons;

              ToggleButtons(
                selectedColor: Colors.deepPurpleAccent,
                fillColor: Colors.blue,
                children: <Widget>[
                  Icon(Icons.cancel,color: Colors.blue[200] ),

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
            ],
          ),
        ),
      ),
    );
  }
}