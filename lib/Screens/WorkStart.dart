import 'package:flutter/material.dart';
import 'package:timesheet_app/Backend/SharedPrefrences.dart';
import 'package:timesheet_app/Backend/loading/loading.dart';
import 'package:timesheet_app/Backend/workstartbackend.dart';
import 'package:timesheet_app/Screens/ViewCalendar.dart';
import 'BreakStart.dart';

class WorkStart extends StatefulWidget {
  var carryinfo,location;
  
  WorkStart({this.carryinfo,this.location});
  @override
  _WorkStartState createState() => _WorkStartState();
}
class _WorkStartState extends State<WorkStart> {
  final _formKey = GlobalKey<FormState>();
  DateTime lastPressed;
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return isloading ? Loading():Form(
      key: _formKey,
          child:  Scaffold(
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
        body:  WillPopScope(
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
                      SizedBox(height: 150),
                      MaterialButton(
                        shape: CircleBorder(),
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 80.0,
                          child: Text(
                            "Work Start",
                            style: TextStyle(
                                fontFamily: 'Lora',
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                                

                          ),
                        ),
                        elevation: 50,
                        focusElevation: 50,
                        //hoverElevation: 5000,
                        highlightElevation: 5,
                        onPressed: () async{
                          //TODO Start Work Location
                          setState(()=> isloading=true);
                          print(widget.location.toString());
                          await workStart(widget.location.toString(),widget.carryinfo.toString());
                          await savingWorkStart(1);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => BreakStart(caryinfo: widget.carryinfo.toString())));
                        setState(()=> isloading=false);
                        },
                      ),
                      SizedBox(height: 50),
                      MaterialButton(
                        shape: CircleBorder(),
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 80.0,
                          child: Text(
                            "Work End",
                            style: TextStyle(
                                fontFamily: 'Lora',
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        elevation: 50,
                        focusElevation: 50,
                        //hoverElevation: 5000,
                        highlightElevation: 5,
                        onPressed: () async{
                          //TODO Write a navigation route
                          setState(()=> isloading=true);
                          await workEnd(widget.location.toString(),widget.carryinfo.toString());
                          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => ViewCalendar()));
                          setState(()=> isloading=false);
                        },
                      ),
                    ],
                  ))),
        )),
          ),
    );
  }
}
