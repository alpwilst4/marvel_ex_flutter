import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:marvel_ex_flutter/data/data.dart';

class CharacterInfo extends ChangeNotifier {
  List<CharacterData> _characterDatas = [];

  UnmodifiableListView<CharacterData> get characterData {
    return UnmodifiableListView(_characterDatas);
  }

  void addData(String name,String url){
    final characterData = CharacterData(characterName: name,imageUrl: url);
    _characterDatas.add(characterData);
    notifyListeners();

  }
}
