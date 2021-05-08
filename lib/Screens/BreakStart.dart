import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:timesheet_app/Backend/SharedPrefrences.dart';
import 'package:timesheet_app/Backend/sheetscredentials.dart';
import 'ViewCalendar.dart';

class BreakStart extends StatefulWidget {
  
  @override
  _BreakStartState createState() => _BreakStartState();
}

class _BreakStartState extends State<BreakStart> {
  bool check;
  void updatingUI() async{
    bool got=await getBool();
    setState((){
      check=got;
    });
  }
File storedimage;
final picker = ImagePicker();
Future<void> takeImage(String fileName) async {
    final image=await picker.getImage(source: ImageSource.camera);
     storedimage = File(image.path);
     print(storedimage);
    await storedimage.rename("storage/emulated/0/ViewTime/"+"$fileName/"+DateFormat('h:mm a').format(DateTime.now()).toString()+".jpg");
}
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updatingUI();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3F3838),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.timeline, size: 25, color: Colors.white),
          SizedBox(width: 20),
          Text("Time Sheet"),
        ]),
        centerTitle: true,
        toolbarHeight: 60.2,
        backgroundColor: Colors.black,
        elevation: 50.0,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      SizedBox(height: 100),
                      check??true==true?MaterialButton(
                        shape: CircleBorder(),
                        child: CircleAvatar(
                          backgroundColor: Colors.yellow,
                          radius: 80.0,
                          child: Text(
                            "Break Start",
                            style: TextStyle(
                                fontFamily: 'Lora',
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        elevation: 50,
                        focusElevation: 50,
                        //hoverElevation: 5000,
                        highlightElevation: 5,
                        onPressed: () async{
                          //TODO Write a navigation route
                          await createFolder('Break Start');
                          String name = 'Break Start';
                          await takeImage(name);
                          await savingBool(false);
                          /*------------------------*/
                          var d=DateTime.now().toString();
                          var up=d.split(" ");
                          var mod=up[1].split(".");
                          print(mod[0]);
                          var id=up[0].split('-');
                          print(id[2]);
                          var number= await getInt();
                          for(int i=0;i<1;i++){
                          if(number<3){
                          await UpdateBreakStart(int.parse(id[2]),mod[0],number);
                          await savingCount(number+2);
                          }
                          else{//TODO Include POPUps
                            print("You Reached Max Limit");
                          }
                          }
                          /*-------------------------*/
                          updatingUI();
                        },
                      ):
                      MaterialButton(
                        shape: CircleBorder(),
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 80.0,
                          child: Text(
                            "Break End",
                            style: TextStyle(
                                fontFamily: 'Lora',
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        elevation: 50,
                        focusElevation: 50,
                        //hoverElevation: 5000,
                        highlightElevation: 5,
                        onPressed: () async{
                          //TODO Write a navigation route
                          await createFolder('Break End');
                          String name = 'Break End';
                          await takeImage(name);
                          await savingBool(true);
                          /*--------------------*/
                          var d=DateTime.now().toString();
                          var up=d.split(" ");
                          var mod=up[1].split(".");
                          print(mod[0]);
                          var id=up[0].split('-');
                          print(id[2]);
                          var number= await getInt1();
                          for(int i=0;i<1;i++){
                          if(number<3){
                          await UpdateBreakEnd(int.parse(id[2]),mod[0],number);
                          await savingCount1(number+2);
                          }
                          else{//TODO Include POPUps
                            print("You Reached Max Limit");
                          }
                          }
                         /*--------------------*/
                          updatingUI();
                        },
                      ),
                      SizedBox(height: 100),
                      MaterialButton(
                        shape: CircleBorder(),
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 80.0,
                          child: Text(
                            "Work End",
                            style: TextStyle(
                                fontFamily: 'Lora',
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        elevation: 50,
                        focusElevation: 50,
                        //hoverElevation: 5000,
                        highlightElevation: 5,
                        onPressed: () async{
                          //TODO Write a navigation route
                          await createFolder('Work End');
                          String name = 'Work End';
                          await takeImage(name);
                          /*--------------------*/
                          var d=DateTime.now().toString();
                          var up=d.split(" ");
                          var mod=up[1].split(".");
                          print(mod[0]);
                          var id=up[0].split('-');
                          print(id[2]);
                          await savingCount(0);
                          await savingCount1(0);
                          if(check==false){
                          var number= await getInt1();
                          for(int i=0;i<1;i++){
                          if(number<3){
                          await UpdateBreakEnd(int.parse(id[2]),mod[0],number);
                          await savingCount1(number+2);
                          }
                          else{//TODO Include POPUps,Loading Bar
                            print("You Reached Max Limit");
                          }
                          }
                         }
                         /*--------------------*/
                          await savingBool(true);
                          await UpdateWorkEnd(int.parse(id[2]),mod[0]);
                          Navigator.push(context, MaterialPageRoute(builder:(context) => ViewCalendar()));
                        },
                      ),
                    ],
                  )))),
    );
  }
}
