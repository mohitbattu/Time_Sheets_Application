import 'package:flutter/material.dart';
import 'package:timesheet_app/Backend/theme.dart';
import 'package:timesheet_app/Screens/LoginScreen.dart';
import 'ListingAllFolders.dart';
import 'Setlocation.dart';
import 'calendar.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
class ViewCalendar extends StatefulWidget {
  @override
  _ViewCalendarState createState() => _ViewCalendarState();
}

class _ViewCalendarState extends State<ViewCalendar> {
  Future<void> createFolder(String foldername) async{
String folderName=foldername;
Directory path= Directory('/storage/emulated/0'+"/$folderName");
await Permission.storage.request();
if ((await path.exists())){
  print("Folder Already Exists");
  print(path);
}else{
  print("Folder does not exist");
  path.create();
}
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3F3838),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.calendar_today, size: 25, color: Colors.white),
          SizedBox(width: 20),
          Text("View Calendar"),
        ]),
        centerTitle: true,
        toolbarHeight: 60.2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.black,
        elevation: 50.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 150),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.width * 0.15,
                  //width: double.infinity,
                  child: MaterialButton(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      "Calendar",
                      style: new TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      //TODO Write the navigation route
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MaterialApp(
                                  debugShowCheckedModeBanner: false,
                                  theme: dark,
                                  home: Calendar())));
                    },
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.width * 0.15,
                  //width: double.infinity,
                  child: MaterialButton(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      "Monthly Time Sheet",
                      style: new TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      //TODO Write the navigation route by Manoj
                      //Navigator.push(context, MaterialPageRoute(builder:(context) => ViewCalendar()));
                    },
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.width * 0.15,
                  //width: double.infinity,
                  child: MaterialButton(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      "Start Work Button",
                      style: new TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: () async{
                      //TODO Write the navigation route
                      await createFolder('ViewTime');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SetLocation()));
                    },
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.width * 0.15,
                  //width: double.infinity,
                  child: MaterialButton(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      "View Time",
                      style: new TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      //TODO Write the navigation route
                      Navigator.push(context, MaterialPageRoute(builder:(context) => ListingAllFolders()));
                    },
                  ),
                ),
                SizedBox(height: 100),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.width * 0.15,
                  //width: double.infinity,
                  child: MaterialButton(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Sign Out",
                            style: new TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 191),
  
                          Icon(Icons.logout,
                                size: 25, color: Colors.white),   
                        ]),
                    onPressed: () {
                      //TODO Write the navigation route
                      Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                      //Navigator.push(context, MaterialPageRoute(builder:(context) => SetLocation()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
