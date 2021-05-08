import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timesheet_app/Screens/LoginScreen.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  runApp(TimeSheet());
}


class TimeSheet extends StatefulWidget {
  @override
  _TimeSheetState createState() => _TimeSheetState();
}

class _TimeSheetState extends State<TimeSheet> {
  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    await Permission.storage.request();
  }
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Sheet',
      home: LoginScreen(),
    );
  }
}