



import 'package:firebase_desktop/services/firestore.dart';
import 'package:flutter/cupertino.dart';

class FirestoreDocument{
  Map<String,dynamic> data = {};
  String? name;
  // DateTime



  FirestoreDocument(Map<String,dynamic> map){
    data = map;

  }

  factory FirestoreDocument.parseFromFirestore(Map<String,dynamic> result) {
    dynamic _parseFirestore(Map<String, dynamic> valueMap){
      switch (valueMap.keys.first){
        case "integerValue":
          return int.parse(valueMap.values.first);
        case "arrayValue":
          return List.generate(valueMap.values.first.length, (index) => _parseFirestore(valueMap.values.first["values"][index]));
        case "timestampValue":
          return DateTime.parse(valueMap.values.first).toLocal();
        default:
          return  valueMap.values.first;
      }
    }




    Map<String,dynamic> map = {};
    result["fields"].forEach((String key, dynamic value) {
      map[key] = _parseFirestore(value);
    });







    return FirestoreDocument(map);
  }



  Map<String,dynamic> asFirestoreDoc(){
    DateTime now = DateTime.now();
    return {
      "name" : "",
      "fields" : _genFields(),
      "createTime" : now.toUtc().toIso8601String(),
      "updateTime" : now.toUtc().toIso8601String()
    };

  }


  Map<String,dynamic> _genFields() {
    Map<String,dynamic> map= {};

    data.forEach((key, value) {
      map[key] = _parseValue(value);
    });

    // debugPrint(map.toString());
    return map;
  }

  Map<String, dynamic> _parseValue(dynamic value) {
    switch (value.runtimeType){
      case int:
        return {"integerValue" : value};
      case double:
        return {"doubleValue" : value};
      case Null:
        return {"nullValue" : value};
      case String:
        return {"stringValue" : value};
      case DateTime:
        return {"timestampValue" : value.toUtc().toIso8601String()};
      case List<String>:
      case List<int>:
      case List<double>:
      case List<void>:
      case List<List<String>>:
      case List<List<double>>:
      case List<List<int>>:
      case List<List<void>>:
        return {"arrayValue": {
          "values" : List.generate(value.length,
        (index) => _parseValue(value[index]))
        }
        };
    }

    throw Exception("${value.runtimeType.toString()} not accepted");
  }

}