import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timesheet_app/Backend/SharedPrefrences.dart';
import 'package:timesheet_app/Backend/loading/loading.dart';
import 'package:timesheet_app/Backend/sheetscredentials.dart';
import 'package:timesheet_app/Backend/workstartbackend.dart';
import 'ViewCalendar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BreakStart extends StatefulWidget {
   var caryinfo;
   BreakStart({this.caryinfo});
  @override
  _BreakStartState createState() => _BreakStartState();
}

class _BreakStartState extends State<BreakStart> {
  final _formKey = GlobalKey<FormState>();
  bool isloading = false;
  bool check;
  DateTime lastPressed;
  void updatingUI() async{
    bool got=await getBool();
    setState((){
      check=got;
    });
  }
File storedimage;
final picker = ImagePicker();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updatingUI();
  }
  @override
  Widget build(BuildContext context) {
    return isloading ? Loading():Form(
      key: _formKey,
          child: Scaffold(
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
      body: WillPopScope(
          onWillPop: () async{
            final now=DateTime.now();
            final maxDuration = Duration(seconds: 1);
            final isWarning = lastPressed == null || 
            now.difference(lastPressed)>maxDuration;
            if(isWarning){
              lastPressed=DateTime.now();
              final snackBar=SnackBar(
                content: Text('Double Tap to Close App'),
                duration: maxDuration,
                );
                ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(snackBar);
                return false;
            } else{
              return true;
            }
          },
          child: SafeArea(
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
                        highlightElevation: 5,
                        onPressed: () async{
                          //TODO BREAK START
                         setState(()=> isloading=true);
                        await breakStart(context,widget.caryinfo.toString());
                        /*-------------------------*/
                        updatingUI();
                        setState(()=> isloading=false);
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
                          //TODO BREAK END
                         setState(()=> isloading=true);
                         await breakEnd(context,widget.caryinfo.toString());
                         /*--------------------*/
                          updatingUI();
                         setState(()=> isloading=false);
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
                          //TODO WORK END
                           setState(()=> isloading=true);
                          await workEndingSecnd(context,widget.caryinfo.toString(),check);
                          await savingWorkStart(0);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => ViewCalendar()));
                           setState(()=> isloading=false);
                        },
                      ),
                    ],
                  ),
                ),
              ),
                ),
    ),
          ),
    );
  }
}
