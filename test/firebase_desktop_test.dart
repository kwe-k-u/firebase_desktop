import 'package:firebase_desktop/models/firestore_document.dart';
import 'package:flutter_test/flutter_test.dart';


Map<String,dynamic> d =
{
  "name": "",
  "fields":{
    "null":{"nullValue" : null},
    "number" : {"integerValue": 3},
    "double" : {"doubleValue": 3.4},
    "time" : {"timestampValue" : DateTime(2022,04,10).toUtc().toString()},//},
    "array" : {"arrayValue":{"values" : [{"stringValue" : "ste"}]}},


  },
  "createTime": DateTime(2022,04,10,15,01,23).toUtc().toString(),
  "updateTime": DateTime(2022,04,10,15,01,23).toUtc().toString()
};

void main() {

  test("Firestore Document and hard typed value should be the same", (){
    Map<String, dynamic> data = {
      "null" : null,
      "number" : 3,
      "double" : 3.4,
      "time" : DateTime(2022,04,10),
      "array" : ["ste"]
    };
    FirestoreDocument uploadDoc = FirestoreDocument(data);
    FirestoreDocument downloadDoc = FirestoreDocument.parseFromFirestore(d);

    // expect(d, uploadDoc.asFirestoreDoc());
    expect(data, downloadDoc.data);
  });

}

