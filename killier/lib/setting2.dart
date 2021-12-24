import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'playmodel.dart';
import 'package:provider/provider.dart';

class SettingView2 extends StatefulWidget {
  @override
  _SettingViewState2 createState() => _SettingViewState2();
}

class _SettingViewState2 extends State<SettingView2>
    with AutomaticKeepAliveClientMixin {
  int _nKiller = 6;
  int _nGod = 6;
  int _nVillager = 6;
  List<String> rs = [];
  List<String> ps = [];
  List<bool> isCheckedList = List<bool>.generate(20, (index) => false);
  int nWolf = 3;
  int nVillager = 3;
  bool bC1 = false;
  bool bC2 = false;
  bool bC3 = false;
  String cRole1 = "";
  String cRole2 = "";
  String cRole3 = "";

  bool bC4 = false;
  bool bC5 = false;
  bool bC6 = false;
  String cRole4 = "";
  String cRole5 = "";
  String cRole6 = "";


  @override
  initState() {
    super.initState();
    //rs = List<String>.generate(_nKiller + _nGod + _nVillager, (index) => "");
    ps = List<String>.generate(_nKiller + _nGod + _nVillager, (index) => "Player");
  }

  void resizeList() {
    print("resize ====");
    List<String> oldRs = rs;
    List<String> oldPs = ps;
    //rs = List<String>.generate(_nKiller + _nGod + _nVillager, (index) => "");
    ps = List<String>.generate(_nKiller + _nGod + _nVillager, (index) => "Player");
    for (int n = 0; n < rs.length && n < oldRs.length; n++) {
      rs[n] = oldRs[n];
      ps[n] = oldPs[n];
    }
  }

  Row createRow(String roleName, int index) {
    return Row(
      children: [Text(roleName), createCheckBox(roleName, index)],
    );
  }

  Checkbox createCheckBox(String roleName, int index) {
    return Checkbox(
      checkColor: Colors.white,
      value: isCheckedList[index],
      onChanged: (bool? value) {
        setState(() {
          isCheckedList[index] = value!;
          if (value) {
            rs.add(roleName);
          } else
            rs.remove(roleName);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
          Expanded(
              child: Row(
            children: [Text("参加人"), Spacer(), Text("角色")],
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
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("平民"),
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: isCheckedList[9],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCheckedList[9] = value!;

                                    });
                                  }),
                              Container(height: 50,
                                width: 120,
                                child: TextField(
                                  enabled: true,
                                  controller: TextEditingController()..text = nVillager.toString(),
                                  keyboardType: TextInputType.number,
                                  //initialValue: index<_nKiller? "I am smart": (index<_nKiller+_nGod?"dd":"ddeee"),

                                  onChanged: (String value) {
                                    nVillager = int.parse(value);
                                    print(' rs saved value = "$value"');
                                    // This optional block of code can be used to run
                                    // code when the user saves the form.
                                  },
                                ),)
                            ],
                          ),
                          createRow("白痴", 5),
                          createRow("守卫", 6),
                          createRow("骑士", 7),
                          createRow("守墓人", 8),

                          Row( children: [
                            Container(height: 50,
                              width: 120,
                              child: TextField(
                                enabled: true,
                                controller: TextEditingController()..text = cRole1,
                                onChanged: (String value) {
                                  cRole1 = value;
                                  print(' rs saved value = "$value"');
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                              ),),
                            Checkbox(
                                checkColor: Colors.white,
                                value: bC1,
                                onChanged: (bool? value) {
                                  setState(() {
                                    bC1 = value!;
                                  });
                                }),
                          ],),
                          Row( children: [
                            Container(height: 50,
                              width: 120,
                              child: TextField(
                                enabled: true,
                                controller: TextEditingController()..text = cRole2,
                                onChanged: (String value) {
                                  cRole2 = value;
                                  print(' rs saved value = "$value"');
                                },
                              ),),
                            Checkbox(
                                checkColor: Colors.white,
                                value: bC2,
                                onChanged: (bool? value) {
                                  setState(() {
                                    bC2 = value!;
                                  });
                                }),
                          ],),
                          Row( children: [
                            Container(height: 50,
                              width: 120,
                              child: TextField(
                                enabled: true,
                                controller: TextEditingController()..text = cRole3,
                                onChanged: (String value) {
                                  cRole3 = value;
                                  print(' rs saved value = "$value"');
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                              ),),
                            Checkbox(
                                checkColor: Colors.white,
                                value: bC3,
                                onChanged: (bool? value) {
                                  setState(() {
                                    bC3 = value!;
                                  });
                                }),
                          ],),
                          // Row(children: [
                          //   IconButton(onPressed:() {},  icon: new Icon(Icons.restore_from_trash),),
                          //   IconButton(onPressed:() {},  icon: new Icon(Icons.save),)
                          // ],
                          // ),

                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5, // 20%
                    //color: Colors.blueGrey,
                    child: Container(
                      color: Colors.grey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("狼人"),
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: isCheckedList[0],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCheckedList[0] = value!;

                                    });
                                  }),
                              Container(height: 50,
                                width: 120,
                                child: TextField(
                                  enabled: true,
                                  keyboardType: TextInputType.number,
                                  controller: TextEditingController()..text = nWolf.toString(),
                                  onChanged: (String value) {
                                    nWolf = int.parse(value) ;
                                    print(' rs saved value = "$value"');
                                    // This optional block of code can be used to run
                                    // code when the user saves the form.
                                  },
                                ),)

                            ],
                          ),
                          createRow("预言家", 1),
                          createRow("狼王", 2),
                          createRow("女巫", 3),
                          createRow("猎人", 4),

                          Row( children: [
                            Container(height: 50,
                              width: 120,
                              child: TextField(
                                enabled: true,
                                controller: TextEditingController()..text = cRole4,
                                onChanged: (String value) {
                                  cRole4 = value;
                                  print(' rs saved value = "$value"');
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                              ),),
                            Checkbox(
                                checkColor: Colors.white,
                                value: bC4,
                                onChanged: (bool? value) {
                                  setState(() {
                                    bC4 = value!;
                                  });
                                }),
                          ],),
                          Row( children: [
                            Container(height: 50,
                              width: 120,
                              child: TextField(
                                enabled: true,
                                controller: TextEditingController()..text = cRole5,
                                onChanged: (String value) {
                                  cRole5 = value;
                                  print(' rs saved value = "$value"');
                                },
                              ),),
                            Checkbox(
                                checkColor: Colors.white,
                                value: bC5,
                                onChanged: (bool? value) {
                                  setState(() {
                                    bC5 = value!;
                                  });
                                }),
                          ],),
                          Row( children: [
                            Container(height: 50,
                              width: 120,
                              child: TextField(
                                enabled: true,
                                controller: TextEditingController()..text = cRole6,
                                onChanged: (String value) {
                                  cRole6 = value;
                                  print(' rs saved value = "$value"');
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                              ),),
                            Checkbox(
                                checkColor: Colors.white,
                                value: bC6,
                                onChanged: (bool? value) {
                                  setState(() {
                                    bC6 = value!;
                                  });
                                }),
                          ],),
                          // Row(children: [
                          //   IconButton(onPressed:() {},  icon: new Icon(Icons.restore_from_trash),),
                          //   IconButton(onPressed:() {},  icon: new Icon(Icons.save),)
                          // ],
                          // ),

                        ],
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
                  rs.clear();




                  if (isCheckedList[0])
                    {
                      for (int n=0; n< nWolf; n++)
                        rs.add("狼人");
                    }
                  if (isCheckedList[1])
                  {
// createRow("预言家", 1),
                    rs.add("预言家");
                  }
                  if (isCheckedList[2])
                  {
// createRow("狼王", 2),
                    rs.add("狼王");
                  }
                  if (isCheckedList[3])
                  {
                    // createRow("女巫", 3),
                    rs.add("女巫");

                  }
                  if (isCheckedList[4])
                  {
// createRow("猎人", 4),
                    rs.add("猎人");

                  }
                  if (isCheckedList[5])
                  {

                    // createRow("白痴", 5),
                    rs.add("白痴");

                  }
                  if (isCheckedList[6])
                  {
                    // createRow("守卫", 6),
                    rs.add("守卫");

                  }
                  if (isCheckedList[7])
                  {
                    // createRow("骑士", 7),
                    rs.add("骑士");

                  }
                  if (isCheckedList[8])
                  {
// createRow("守墓人", 8),
                    rs.add("守墓人");

                  }
                  if (isCheckedList[9])
                  {
                    for (int n=0; n< nVillager; n++)
                      rs.add("平民");
                  }

                  if (bC1)
                    rs.add(cRole1);
                  if (bC2)
                    rs.add(cRole2);
                  if (bC3)
                    rs.add(cRole3);
                  if (bC4)
                    rs.add(cRole4);
                  if (bC5)
                    rs.add(cRole5);
                  if (bC6)
                    rs.add(cRole6);

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
