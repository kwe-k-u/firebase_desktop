library firebase_desktop;
import 'dart:convert';

import 'package:firebase_desktop/models/firebase_user.dart';
import 'package:http/http.dart' as http;


class FirebaseDesktopAuth{
  late String apiKey;

  FirebaseDesktopAuth(String apikey) {
    apiKey = apikey;
  }


  factory FirebaseDesktopAuth.instance(String apiKey) {
    return FirebaseDesktopAuth(apiKey);
  }


  Future<FirebaseUser?> signInWithEmailAndPassword(String email, String password) async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST',
        Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$apiKey'));
    request.body = json.encode({
      "email": email,
      "password": password,
      "returnSecureToken": true
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String,dynamic> streamData = json.decode(await response.stream.bytesToString()) as Map<String,dynamic>;
      print(streamData);

      return FirebaseUser.fromJson(streamData);
    }
    else {
      print(response);
    }
    return null;
    // return response;

  }


  Future<FirebaseUser?> signUpWithEmailAndPassword(String email, String password) async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST',
        Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$apiKey'));
    request.body = json.encode({
      "email": email,
      "password": password,
      "returnSecureToken": true
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.toString());

    if (response.statusCode == 200) {
      print("good");
      FirebaseUser user = FirebaseUser.fromJson(json.decode(await response.stream.bytesToString()));
      return user;
    }
    else {
      print(response.reasonPhrase);
    }
    // return response;
    return null;

  }



  Future<http.StreamedResponse> updateProfile({
  String? displayName,
  String? photoUrl,
}) async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST',
        Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:update?key=$apiKey'));
    Map<String,dynamic> body = {"returnSecureToken": true};
    if (displayName != null){
      body["displayName"] = displayName;
    }

    if (photoUrl != null){
      body["photoUrl"] = photoUrl;
    }

    request.body = json.encode(body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
    return response;

  }



}