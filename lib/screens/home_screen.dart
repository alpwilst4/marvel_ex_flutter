import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marvel_ex_flutter/models/character.dart';
import 'package:http/http.dart' as http;
import 'package:marvel_ex_flutter/models/comics.dart';

import 'detail_page.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: FutureBuilder<List<Character>>(
        future: getCharacterDatas(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? CharacterList(characters: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class CharacterList extends StatefulWidget {
  CharacterList({this.characters});
  final List<Character> characters;

  @override
  _CharacterListState createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  int count = 30;
  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          if (count > 70) {
            count = 100;
          } else
            count = count + 30;
        });
      }
    });

    return ListView.builder(
      controller: _scrollController,
      itemCount: count,
      itemBuilder: (context, index) {
        return CharacterCard(
          characters: widget.characters,
          index: index,
        );
      },
    );
  }
}

class CharacterCard extends StatelessWidget {
  CharacterCard({this.characters, this.index});
  final int index;
  final List<Character> characters;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Comics comic = Comics();
        List<Comics> newStyle =
            await comic.getComicDatas(jsonEncode(characters[index].comics));

        //print(newStyle[0].name);

        return Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(
                      name: characters[index].name,
                      imageUrl: characters[index].imageUrl,
                      description: characters[index].description,
                      comics: newStyle,
                    )));
      },
      child: Card(
          child: ListTile(
        leading: SizedBox(
            height: 40,
            width: 40,
            child: CachedNetworkImage(
              imageUrl: characters[index].imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            )),
        title: Text(characters[index].name),
      )),
    );
  }
}
