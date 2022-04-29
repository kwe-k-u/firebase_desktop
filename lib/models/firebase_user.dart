class FirebaseUser{
  String email;
  String id;
  String displayName;
  String idToken;
  bool registered;
  String refreshToken;
  String expiration;


  FirebaseUser({
    required this.id,
    required this.email,
    required this.displayName,
    required this.idToken,
    required this.registered,
    required this.refreshToken,
    required this.expiration,
});

   factory FirebaseUser.fromJson(Map<String,dynamic> map) {
     return FirebaseUser(
         id: map["localId"],
         email: map["email"],
         displayName: map["displayName"] ?? "",
         idToken: map["idToken"],
         registered: map["registered"],
         refreshToken: map["refreshToken"],
         expiration: map["expiresIn"]
     );
   }

}
