import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timesheet_app/Backend/SharedPrefrences.dart';
import 'package:timesheet_app/Backend/loading/loading.dart';
import 'package:timesheet_app/Screens/LoginScreen.dart';
import 'ListingAllFolders.dart';
import 'Setlocation.dart';

class ViewCalendar extends StatefulWidget {
  var userinfor;
  ViewCalendar({this.userinfor});
  @override
  _ViewCalendarState createState() => _ViewCalendarState();
}
signOutCredentials() async{
final FirebaseAuth _auth = FirebaseAuth.instance;
SharedPreferences delPrefs= await SharedPreferences.getInstance();
delPrefs.remove('checking');
delPrefs.remove('Count1');
delPrefs.remove('Count');
delPrefs.remove('userinf');
delPrefs.remove('email');
await _auth.signOut();
}
class _ViewCalendarState extends State<ViewCalendar> {
  final _formKey = GlobalKey<FormState>();
  bool isloading = false;
  DateTime lastPressed;
  @override
  Widget build(BuildContext context) {
    return isloading ? Loading():Form(
      key: _formKey,
          child:  Scaffold(
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
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => MaterialApp(
                      //             debugShowCheckedModeBanner: false,
                      //             theme: dark,
                      //             home: Calendar())));
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
                      "Year Plan",
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
                      String em=await gottEmail();
                      print(em);
                      setState(()=> isloading=true);
                      String carried=widget.userinfor.toString();
                      print(carried);
                      if(carried!="null"){
                        await savingUser(widget.userinfor.toString());
                      }else{
                        carried=await getUser();
                      }
                      print(carried);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SetLocation(carryuser: carried)));
                    setState(()=> isloading=false);
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
                    onPressed: () async{
                      //TODO Write the navigation route
                      setState(()=> isloading=true);
                      String cd1=widget.userinfor.toString();
                      if(cd1!="null"){
                        await savingUser(widget.userinfor.toString());
                      }else{
                        cd1=await getUser();
                      }
                      Navigator.push(context, MaterialPageRoute(builder:(context) => ListingAllFolders(userinfo: cd1)));
                    setState(()=> isloading=false);
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
                    onPressed: () async{
                      //TODO Write the navigation route
                      setState(()=> isloading=true);
                      await signOutCredentials();
                      Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                      setState(()=> isloading=false);
                      //Navigator.push(context, MaterialPageRoute(builder:(context) => SetLocation()));
                    },
                  ),
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
