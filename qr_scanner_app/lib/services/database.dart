import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class database {

final CollectionReference _codeCollection = FirebaseFirestore.instance.collection('code');

updateCodeStatus(String scanData, DateTime date) async {

// dataList = [code,amount,uid] indexes = 0, 1, 2
List<String> dataList=convertToList(scanData);
String code = dataList[0];
String uid =dataList[2];
//var codeRef= await _codeCollection.doc(uid).get();
String convertedDate = convertDate(date);
// status="used"
// dateUsed = "Used at: $date"
// used = DateTime.now()
await Future.delayed(const Duration(seconds: 5), (){});
_codeCollection.doc(uid).update({"status" : "used", 'dateUsed' : "Used At: $convertedDate", "used" : date }).then((_) => print('success'),)
    .catchError((error) => print('Fail'),);
}

  List<String> convertToList(String scanData) {

    List<String> dataList = scanData.split(",");
    return dataList;
  }

String convertDate(DateTime date){
  String covertedDate = DateFormat('dd-MM-yyy').format(date);
   return covertedDate;

}

Future<String> checkStatus(String scanData) async {
List<String> dataList=convertToList(scanData);
String uid =dataList[2];
print(uid +" in database");
var doc= await  _codeCollection.doc(uid).get();
String status = doc['status']; // 
print(status);
print(" checking the status");
return status;
}

}