import 'dart:io';
import 'package:http/http.dart' as http;

Future<String> getFirebaseData() async{
final response = await http.get("https://timesheet-78e8e-default-rtdb.firebaseio.com/TimeSheet.json?");
print(response.body);
var extractedData = response.body;
return extractedData;
}
Directory storing;
  var table;
  Directory path = Directory("storage/emulated/0/ViewTime");
Future<void> createFolder(String foldername) async{
String folderName=foldername;
Directory path= Directory("storage/emulated/0/ViewTime/$folderName");
if ((await path.exists())){
  print("Folder Already Exists");
}else{
  print("Folder does not exist");
  path.create();
}
}
