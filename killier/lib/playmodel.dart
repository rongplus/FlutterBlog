import 'package:flutter/cupertino.dart';

class PlayModel with ChangeNotifier
{
  List<String> _playerList = [];
  List<String> get players => _playerList;
  set playerList(List<String> lt) {
    _playerList = lt;
    print("==========_playerList========================");
    print(_playerList);
    print("==================================");
    notifyListeners();
  }

  List<String> _roleList = [];
  List<String> get roles => _roleList;
  set roleList(List<String> lt) {
    _roleList = lt;
    print("===========_roleList=======================");
    print(_roleList);
    print("==================================");
    notifyListeners();
  }

  List<String> ttsStrings = ["天黑请闭眼。","天亮请挣眼。","狼人请挣眼。","狼人请杀人。","狼人请闭眼。",
    "预言家请挣眼。","预言家请验人。","预言家请闭眼。","女巫请挣眼。","女巫,你有一瓶解药，他死了， 你要救他吗？",
    "女巫,你有一瓶毒药，你要用吗？","女巫请闭眼。"
  ];

}