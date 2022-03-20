import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timesheet_app/Backend/SharedPrefrences.dart';
import 'package:timesheet_app/Screens/LoginScreen.dart';
import 'package:timesheet_app/Screens/ViewCalendar.dart';
import 'Screens/BreakStart.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TimeSheet());
}


class TimeSheet extends StatefulWidget {
  @override
  _TimeSheetState createState() => _TimeSheetState();
}

class _TimeSheetState extends State<TimeSheet> {
  String email;
  int work;
  Future<void> gettingEmail() async{
    String em= await gottEmail();
    int wkstart=await gotWorkStart();
    setState(() {
      email=em;
      work=wkstart;
    });
  }
  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    await Permission.storage.request();
    await gettingEmail();
  }
  
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Sheet',
      home: email==null ? LoginScreen():work==0 ? ViewCalendar():BreakStart(),
    );
  }
}