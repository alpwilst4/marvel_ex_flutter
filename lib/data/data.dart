import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:marvel_ex_flutter/services/network_helper.dart';

const privateKey = "588b317f5ff26f07f6d12ff7cdf058552d7664e9";
const publicKey = "41a73cf475e65559db98277c9910298b";

class CharacterData {
  Future<dynamic> getCharacterData() async {
    var ts = DateTime.now().millisecondsSinceEpoch;
    var completedKey = ts.toString() + privateKey + publicKey;
    var hash = md5.convert(utf8.encode(completedKey)).toString();

    NetworkHelper networkHelper = NetworkHelper(
        url:
            "https://gateway.marvel.com/v1/public/characters?ts=$ts&apikey=$publicKey&hash=$hash");
            print("https://gateway.marvel.com/v1/public/characters?ts=$ts&apikey=$publicKey&hash=$hash");
    var data = await networkHelper.getData();

    print(data["data"]["limit"]);
    
    
  }
}
