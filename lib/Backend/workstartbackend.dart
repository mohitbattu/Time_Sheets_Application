import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:timesheet_app/Backend/SharedPrefrences.dart';
import 'package:timesheet_app/Backend/sheetscredentials.dart';

final firestoreInstance = FirebaseFirestore.instance;
File _storedimage;
final picker = ImagePicker();

Future<void> takeImage() async {
    final image=await picker.getImage(source: ImageSource.camera);
     _storedimage = File(image.path);
}

Future <String> uploadImage(String user,String uid) async {
  var d=DateTime.now().toString();
  var up=d.split(" ");             
  var date=up[0];
  firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref(user).child(date).child(uid);
 await ref.putFile(_storedimage);
 firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
 final ref1 = storage.ref(user).child(date).child(uid);
  String imageLocation = await ref1.getDownloadURL();
 firestoreInstance.collection(user).doc(up[0]).set(
  {
    "Date" : up[0],
    "email" : "$user"+"@timesheet.com",
  },SetOptions(merge: true));
  return imageLocation;
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

String retrievingUser(String email){
var em=email.split("@");
var user=em[0];
return user;
}

Future<void> workStart(String location,String user) async{
var name='Work_Start';
var d=DateTime.now().toString();
var up=d.split(" ");
var data=dateTime();
var id=data["day"];                     
var date=data["Date"];
await takeImage(); 
await UpdateStartWork(int.parse(id),date,user);
await UpdateWorkLocation(int.parse(id),location,user);
String imglocation=await uploadImage(user,user+"_"+name);
firestoreInstance.collection(user).doc(up[0]).set(
  {
    "StartWorkTime" : date,
     "Location" : location,
     "Start_Work_imgUrl" : imglocation,
  },SetOptions(merge: true));
 }

Future<void> workEnd(String location, String user) async{
   String name = 'Work_End';
   var d=DateTime.now().toString();
   var data=dateTime();
   var id1=data["day"];
   var up=d.split(" ");
   var mod=up[1].split(".");
   var id=up[0].split('-');
   await takeImage();
   await UpdateWorkEnd(int.parse(id[2]),mod[0],user);
   await UpdateWorkLocation(int.parse(id1),location,user);
   String imglocation=await uploadImage(user,user+"_"+name);
   firestoreInstance.collection(user).doc(up[0]).set(
  {
    "WorkEndTime" : mod[0],
     "Location" : location,
     "Work_End_imgUrl" : imglocation,
  },SetOptions(merge: true));
}

Future<void> breakStart(BuildContext context,String user) async{
   String name = 'Break_Start';
   /*------------------------*/
   var d=DateTime.now().toString();
   var up=d.split(" ");
   var mod=up[1].split(".");
   var id=up[0].split('-');
   var number= await getInt();
   for(int i=0;i<1;i++){
   if(number<3){
   await takeImage();
   await savingBool(false);
   await UpdateBreakStart(int.parse(id[2]),mod[0],number,user);
   int setting=(number==2)?2:1;
   String imgloc=await uploadImage(user,user+"_"+name+"_"+setting.toString());
  firestoreInstance.collection(user).doc(up[0]).set(
  {
    "BreakStartTime"+"_"+setting.toString() : mod[0],
     "Break_Start_imgUrl"+"_"+setting.toString() : imgloc,
  },SetOptions(merge: true));
   await savingCount(number+2);
   }
   else{//TODO Include POPUps
     Alert(
       context: context,
       type: AlertType.warning,
       title: "Warning",
       desc: "You Reached Max Limit",
       buttons: [
       DialogButton(
       gradient: LinearGradient(colors: [
        Color.fromRGBO(116, 116, 191, 1.0),
       Color.fromRGBO(52, 138, 199, 1.0)
       ]),

       child: Text(
       "Ok",style: TextStyle(color: Colors.white, fontSize: 20),),
       onPressed: () =>  Navigator.of(context, rootNavigator: true).pop(),
       width: 120,
       )
       ],
       ).show();
       }
    }
}

Future<void> breakEnd(BuildContext context,String user) async{
 String name = 'Break_End';
 /*--------------------*/
var d=DateTime.now().toString();
var up=d.split(" ");
var mod=up[1].split(".");
var id=up[0].split('-');
var number= await getInt1();
for(int i=0;i<1;i++){
if(number<3){
await takeImage();
await savingBool(true);
await UpdateBreakEnd(int.parse(id[2]),mod[0],number,user);
int setting=(number==2)?2:1;
String imgloc=await uploadImage(user,user+"_"+name+"_"+setting.toString());
firestoreInstance.collection(user).doc(up[0]).set(
  {
    "BreakEndTime"+"_"+setting.toString() : mod[0],
     "Break_End_imgUrl"+"_"+setting.toString() : imgloc,
  },SetOptions(merge: true));
await savingCount1(number+2);
}
else{//TODO Include POPUps
Alert(
context: context,
type: AlertType.warning,
title: "Warning",
desc: "You Reached Max Limit",
buttons: [
DialogButton(
gradient: LinearGradient(colors: [
Color.fromRGBO(116, 116, 191, 1.0),
Color.fromRGBO(52, 138, 199, 1.0)
]),
child: Text(
 "Ok",style: TextStyle(color: Colors.white, fontSize: 20),),
onPressed: () =>  Navigator.of(context, rootNavigator: true).pop(),
width: 120,
)
],
).show();
}
 }
}

Future<void> workEndingSecnd(BuildContext context,String user,bool verify) async{
String name = 'Work_End';
/*--------------------*/
var d=DateTime.now().toString();
var up=d.split(" ");
var mod=up[1].split(".");
var id=up[0].split('-');
await takeImage();
if(verify==false){
var number= await getInt1();
for(int i=0;i<1;i++){
print("Inside for loop");
if(number<3){
print("NUMBER");
print(number);
await UpdateBreakEnd(int.parse(id[2]),mod[0],number,user);
int setting=(number==2)?2:1;
String imgloc=await uploadImage(user,user+"_"+name);
firestoreInstance.collection(user).doc(up[0]).set(
  {
    "BreakEndTime"+"_"+setting.toString() : mod[0],
     "Break_End_imgUrl"+"_"+setting.toString() : imgloc,
  },SetOptions(merge: true)
  );
await savingCount1(number+2);
}
else{//TODO Include POPUps,Loading Bar
Alert(
context: context,
type: AlertType.warning,
title: "Warning",
desc: "You Reached Max Limit",
buttons: [
DialogButton(
gradient: LinearGradient(colors: [
Color.fromRGBO(116, 116, 191, 1.0),
Color.fromRGBO(52, 138, 199, 1.0)
]),
child: Text(
 "Ok",style: TextStyle(color: Colors.white, fontSize: 20),),
onPressed: () =>  Navigator.of(context, rootNavigator: true).pop(),
width: 120,
)
],
).show();
}
}
}
/*--------------------*/
print("OUTSIDE FOR LOOP");
await savingBool(true);
await UpdateWorkEnd(int.parse(id[2]),mod[0],user);
String imgloc=await uploadImage(user,user+"_"+name);
firestoreInstance.collection(user).doc(up[0]).set(
  {
    "WorkEndTime" : mod[0],
     "Work_End_imgUrl" : imgloc,
  },SetOptions(merge: true));
}