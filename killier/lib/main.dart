import 'package:flutter/material.dart';

import 'playmodel.dart';
import 'tworoleplayview.dart';
import 'setting2.dart';
import 'playview2face.dart';
import 'tts_sentence.dart';

import 'package:provider/provider.dart';
import 'playview_tradition.dart';

final playModel = PlayModel();

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlayModel()),
      ],
      child:  MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '我要杀人'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  Container buildBox(String title, Color color) {
    return Container(
        width: 100,
        height: 100,
        color: color,
        child: Center(
            child: Text(title,
                style: TextStyle(fontSize: 18, color: Colors.black))));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            bottom:  TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.flash_on),
                  text: '普通杀',
                ),
                Tab(
                  icon: Icon(Icons.sync),
                  text: '双身份',
                ),
                Tab(
                  icon: Icon(Icons.sync),
                  text: '双身份2',
                ),
                Tab(
                  icon: Icon(Icons.storage),
                  text: '设置',
                ),
                Tab(
                  icon: Icon(Icons.storage),
                  text: '语音',
                ),
              ],
            ),
            title: const Text('我要杀人'),
          ),
          body:  TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              TraditionView(),
              Play2FaceView(),
              TwoRolePlayView(),
              SettingView2(),
              TTSSentence()
            ],
          ),
          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text('Drawer Header'),
                ),
                ListTile(
                  title: Container(child: Row(
                    children: [
                    Text("ddd", ),

                    TextField(
                    enabled: true,
                    decoration: InputDecoration(
                      hintText: 'Enter a text',
                    ),),
                    ]
                  ),),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Item 2'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
