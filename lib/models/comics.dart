import 'dart:convert';

class Comics {
  final String name;
  final String resourceURI;

  Comics({this.name,this.resourceURI});

  factory Comics.fromJson(Map<String, dynamic> json) {
    return Comics(
      name: json['name'].toString(),
     
    );
  }
List<Comics> parseComicsData(String responseBody) {
  final Map<String, dynamic> parsed = jsonDecode(responseBody);
  return List<Comics>.from(parsed['items'].map((x) => Comics.fromJson(x)));
}

Future<List<Comics>> getComicDatas(String body) async {
  

  return parseComicsData(body);
}




}

  