import 'package:flutter/material.dart';
import 'package:killier/widgets/moveitem.dart';
class NormalView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<NormalView> {
  List<Widget> movableItems = [MoveableStackItem("a",10,10),
    MoveableStackItem("b",50,50),MoveableStackItem("c",200,200)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: movableItems,
        ));
  }
}

