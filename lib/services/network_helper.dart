



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class NetworkHelper {
  NetworkHelper({@required this.url});
  final String url;

  Future getData() async {

    http.Response response = await http.get(Uri.parse(url));


     if (response.statusCode == 200) {
      

      return response;
    } else
      print(response.statusCode);



  }
}