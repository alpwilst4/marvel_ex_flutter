import 'package:flutter/material.dart';
import 'package:marvel_ex_flutter/data/data.dart';

class HomeScreen extends StatelessWidget {
  CharacterData characterData = CharacterData();

  Future<dynamic> getData() async {
    final data = await characterData.getCharacterData();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Container();
  }
}
