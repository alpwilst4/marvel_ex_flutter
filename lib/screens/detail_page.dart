import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marvel_ex_flutter/models/comics.dart';
import 'package:marvel_ex_flutter/models/comics_with_dates.dart';

const start = "(";
const end = ")";

class DetailPage extends StatelessWidget {
  DetailPage(
      {this.name, this.description, this.imageUrl, this.index, this.comics});
  final String description;
  final String name;
  final String imageUrl;
  final String index;
  final List<Comics> comics;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Hero(
              tag: "image",
              child: SizedBox(
                child: Image.network(imageUrl),
              ),
            ),
            Text(name),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                  child: Text(
                description,
                style: TextStyle(fontSize: 20),
              )),
            ),
            Expanded(
              child: ListView(
                children: getComics(),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Card> getComics() {
    List<ComicsWithDates> data = [];
    for (var comic in comics) {
      final startIndex = comic.name.indexOf(start);
      final endIndex = comic.name.indexOf(end, startIndex + start.length);
      int date = int.tryParse(
              comic.name.substring(startIndex + start.length, endIndex)) ??
          1000;
      data.add(ComicsWithDates(name: comic.name, date: date));
    }
    List reversed = selectionSort(data).reversed.toList();
    List<Card> ar = [];
    int i = 0;

    for (var item in reversed) {
      if (item.date > 2005 && i < 10) {
        ar.add(Card(
            child: ListTile(
                title: Text(
          item.name,
          style: TextStyle(fontSize: 12),
        ))));
        i++;
      }
    }
    return ar;
  }

  List selectionSort(List<ComicsWithDates> list) {
    if (list == null || list.length == 0) return null;
    int n = list.length;
    int i, steps;
    for (steps = 0; steps < n; steps++) {
      for (i = steps + 1; i < n; i++) {
        if (list[steps].date > list[i].date) {
          swap(list, steps, i);
        }
      }
    }
    return list;
  }

  void swap(List<ComicsWithDates> list, int steps, int i) {
    var temp = list[steps];
    list[steps] = list[i];
    list[i] = temp;
  }
}
