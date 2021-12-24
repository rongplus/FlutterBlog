import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import '../playmodel.dart';
import 'package:provider/provider.dart';

class SettingView extends StatefulWidget {
  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView>
    with AutomaticKeepAliveClientMixin {
  int _nKiller = 3;
  int _nGod = 3;
  int _nVillager = 3;
  List<String> rs = [];
  List<String> ps = [];

  @override
  initState() {
    super.initState();
    rs = List<String>.generate(_nKiller + _nGod + _nVillager, (index) => "");
    ps = List<String>.generate(_nKiller + _nGod + _nVillager, (index) => "");
  }

  void resizeList() {
    print("resize ====");
    List<String> oldRs = rs;
    List<String> oldPs = ps;
    rs = List<String>.generate(_nKiller + _nGod + _nVillager, (index) => "");
    ps = List<String>.generate(_nKiller + _nGod + _nVillager, (index) => "");
    for (int n = 0; n < rs.length && n < oldRs.length; n++) {
      rs[n] = oldRs[n];
      ps[n] = oldPs[n];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
          Expanded(
            flex: 2, // 20%
            child: Container(
              color: Colors.white30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: <Widget>[
                      NumberPicker(
                        value: _nKiller,
                        minValue: 0,
                        maxValue: 100,
                        onChanged: (value) {
                          setState(() => _nKiller = value);
                          resizeList();
                        },
                      ),
                      Text('杀手个数: $_nKiller'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      NumberPicker(
                          value: _nGod,
                          minValue: 0,
                          maxValue: 100,
                          onChanged: (value) {
                            setState(() => _nGod = value);
                            resizeList();
                          }),
                      Text('神职个数: $_nGod'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      NumberPicker(
                        value: _nVillager,
                        minValue: 0,
                        maxValue: 100,
                        onChanged: (value) {
                          setState(() => _nVillager = value);
                          resizeList();
                        },
                      ),
                      Text('水民个数: $_nVillager'),
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(child: Row(
            children: [ Text("参加人"),Spacer(),Text("角色")],
          )),
          Expanded(
            flex: 7, // 20%
            child: Container(
              color: Colors.white24,
              child: Row(
                children: [
                  Expanded(
                    flex: 5, // 20%
                    //color: Colors.blueGrey,
                    child: Container(
                      color: Colors.grey,
                      child: ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: _nVillager + _nGod + _nKiller,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 50,
                            //color: Colors.amber[colorCodes[index]],
                            child: Center(
                                child: ListTile(
                                    title: TextField(
                              enabled: true,
                              //initialValue: index<_nKiller? "I am smart": (index<_nKiller+_nGod?"dd":"ddeee"),
                              decoration: InputDecoration(
                                hintText: 'Enter a text',
                              ),
                              onChanged: (String value) {
                                ps[index] = value;
                                print(' rs saved value = "$value"');
                                // This optional block of code can be used to run
                                // code when the user saves the form.
                              },
                            ))),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5, // 20%
                    //color: Colors.blueGrey,
                    child: Container(
                      color: Colors.grey,
                      child: ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: _nVillager + _nGod + _nKiller,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 50,
                            //color: Colors.amber[colorCodes[index]],
                            child: Center(
                                child: ListTile(
                                    title: TextField(
                              enabled: true,
                              //initialValue: index<_nKiller? "I am smart": (index<_nKiller+_nGod?"dd":"ddeee"),
                              decoration: InputDecoration(
                                hintText: 'Enter a text',
                              ),
                              onChanged: (String? value) {
                                rs[index] = value!;
                                // This optional block of code can be used to run
                                // code when the user saves the form.
                              },
                            ))),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Row(
            children: [
              IconButton(
                icon: new Icon(Icons.save),
                highlightColor: Colors.pink,
                onPressed: () async {
                  print("message - save");
                  //-----------------------
                  rs.clear();
                  Provider.of<PlayModel>(context, listen: false).playerList =
                      ps;
                  Provider.of<PlayModel>(context, listen: false).roleList = rs;

                  //------------------------------
                },
              ),
              IconButton(
                icon: new Icon(Icons.search),
                highlightColor: Colors.pink,
                onPressed: () async {
                  print("message");
                  //-----------------------

                  //------------------------------
                },
              )
            ],
          )),
        ]));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
