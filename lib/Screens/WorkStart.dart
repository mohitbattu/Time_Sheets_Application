import 'package:flutter/material.dart';
import 'package:timesheet_app/Backend/sheetscredentials.dart';
import 'package:timesheet_app/Backend/workstartbackend.dart';
import 'package:timesheet_app/Screens/ViewCalendar.dart';
import 'BreakStart.dart';

class WorkStart extends StatefulWidget {
  var location;
  WorkStart({this.location});
  @override
  _WorkStartState createState() => _WorkStartState();
}
class _WorkStartState extends State<WorkStart> {
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
                          //TODO Write a navigation route
                          await createFolder('Work Start');
                          String name = 'Work Start';
                          var data=dateTime();
                          var id=data["day"];
                          print("Day "+id);
                          
                          var date=data["Date"];
                          print(" Date"+date);
                          await takeImage(name);
                          print(widget.location);
                          await UpdateStartWork(int.parse(id),date);
                          await UpdateWorkLocation(int.parse(id),widget.location.toString());
                         
                          Navigator.push(context, MaterialPageRoute(builder:(context) => BreakStart()));
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
                          await createFolder('Work End');
                          String name = 'Work End';
                          await takeImage(name);
                          var d=DateTime.now().toString();
                          var up=d.split(" ");
                          var mod=up[1].split(".");
                          print(mod[0]);
                          var id=up[0].split('-');
                          print(id[2]);
                         
                          UpdateWorkEnd(int.parse(id[2]),mod[0]);
                         
                          Navigator.push(context, MaterialPageRoute(builder:(context) => ViewCalendar()));
                        },
                      ),
                    ],
                  ))),
        ));
  }
}
