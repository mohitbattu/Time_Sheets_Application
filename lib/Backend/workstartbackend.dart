import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
Future<String> createFolder(String foldername) async{
String folderName=foldername;
Directory path= Directory("storage/emulated/0/ViewTime/$folderName");
if ((await path.exists())){
  print("Folder Already Exists");
}else{
  print("Folder does not exist");
  path.create();
}
return path.toString().split('/').last;
}
File storedimage;
final picker = ImagePicker();

Future<void> takeImage(String fileName) async {
    final image=await picker.getImage(source: ImageSource.camera);
     storedimage = File(image.path);
     print(storedimage);
    await storedimage.rename("storage/emulated/0/ViewTime/"+"$fileName/"+DateFormat('h:mm a').format(DateTime.now()).toString()+".jpg");
}

Map<String,String> dateTime(){
var d=DateTime.now().toString();
var up=d.split(" ");
var mod=up[1].split(".");
print(mod[0]);
var id=up[0].split('-');
print(id[2]);
var data={"day": id[2],"Date": mod[0]};
return data;
}