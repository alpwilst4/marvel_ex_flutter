import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:marvel_ex_flutter/data/data.dart';

const size = "/portrait_small.jpg";

class Character {
  final String name;
  final String imageUrl;
  final String description;
  final String comics;
  Character({this.name, this.imageUrl,this.description,this.comics});

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'].toString(),
      imageUrl: json['thumbnail']['path'].toString() + size,
      description: json['description'].toString(),
      //comics: json['comics']['items']["name"]
    );
  }
}

List<Character> parseCharacterData(String responseBody) {
  final Map<String, dynamic> parsed = jsonDecode(responseBody);
  return List<Character>.from(
      parsed["data"]["results"].map((x) => Character.fromJson(x)));
}

Future<List<Character>> getCharacterDatas(http.Client client) async {
  final response = await CharacterData().getCharacterData();

  return parseCharacterData(response.body);
}
