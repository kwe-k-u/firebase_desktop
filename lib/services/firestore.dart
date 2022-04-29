import 'dart:convert';

import 'package:firebase_desktop/models/firestore_document.dart';
import 'package:http/http.dart' as http;
class Firestore{
  late String _baseUrl;

  Firestore({required String projectId, String database="(default)"}){
    _baseUrl = "https://firestore.googleapis.com/v1/projects/$projectId/databases/$database/documents";
  }



  Future<String> getDocument(String path) async {
    var request = http.Request('GET', Uri.parse("$_baseUrl/$path"));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print();
    }
    else {
    print(response.reasonPhrase);
    }
    return await response.stream.bytesToString();

  }


  Future<void> deleteDocument(String path) async {
    var request = http.Request('DELETE', Uri.parse("$_baseUrl/$path"));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  Future<String> uploadDocument(String path, Map<String,dynamic> map) async {
    var request = http.Request('POST', Uri.parse("$_baseUrl/$path"));
    request.body = json.encode(FirestoreDocument(map).asFirestoreDoc());

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print();
    }
    else {
      print(response.reasonPhrase);
    }
    return await response.stream.bytesToString();

  }

  Future<String> listDocuments(String path, {Map<String, dynamic>? params }) async {

    var request = http.Request('GET', Uri.parse('$_baseUrl/$path?pageSize=100'));


    http.StreamedResponse response = await request.send();

    String data = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      // print();
    }
    else {
      print(response.reasonPhrase);
    }

    return data;

  }

  Future<String> listCollections(String path) async {
    return "";
  }
}


