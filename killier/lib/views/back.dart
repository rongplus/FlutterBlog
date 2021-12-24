import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../playmodel.dart';

class PlayNormalView extends StatefulWidget {
  @override
  _PlayNormalViewState createState() => _PlayNormalViewState();
}

class _PlayNormalViewState extends State<PlayNormalView> {
  List<Widget> movableItems = [];

  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];




  @override
  Widget build(BuildContext context) {

    // final model = Provider.of<PlayModel>(context);
    // model.players;
    return   Provider<PlayModel>( //                                <--- Provider
        create: (context) => PlayModel(),
        child: Scaffold(
            body: Row(
              children:  <Widget>[
                Expanded(
                  flex: 2, // 20%
                  child: Consumer<PlayModel>( //                    <--- Consumer
                    builder: (context, myModel, child) {
                      return ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: myModel.players.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 50,
                            color: index==0?Colors.blue:Colors.yellow,
                            child: Center(child: Text('Entry ${myModel.players[index]}')),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                      );
                    },
                  ),


                ),

                Expanded(
                  flex:8, // 20%
                  child: Stack(
                    children: movableItems,
                  ),
                ),
              ],
            )
        )
    );

  }
}

