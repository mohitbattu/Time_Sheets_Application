import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timesheet_app/Backend/SharedPrefrences.dart';
import 'package:timesheet_app/Backend/loading/loading.dart';
import 'package:timesheet_app/Backend/workstartbackend.dart';
import 'ViewCalendar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  bool _passwordVisible = false;
  bool isloading = false;
  final _formKey = GlobalKey<FormState>();
  DateTime lastPressed;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Loading()
        : Form(
            key: _formKey,
            child: Scaffold(
              backgroundColor: const Color(0xFF121212),
              body: WillPopScope(
                onWillPop: () async {
                  final now = DateTime.now();
                  final maxDuration = Duration(seconds: 1);
                  final isWarning = lastPressed == null ||
                      now.difference(lastPressed) > maxDuration;
                  if (isWarning) {
                    lastPressed = DateTime.now();
                    final snackBar = SnackBar(
                      content: Text('Double Tap to Close App'),
                      duration: maxDuration,
                    );
                    print("WARNING");
                    print(isWarning);

                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(snackBar);
                    return false;
                  } else {
                    return true;
                  }
                },
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              "Images/clock.jpg"), // TODO can be simplified
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          new BackdropFilter(
                            filter: new ImageFilter.blur(
                                sigmaX: 4.0, sigmaY: 4.0),
                            child: new Container(
                              decoration: new BoxDecoration(
                                  color: Colors.white.withOpacity(0.0)),
                            ),
                          ),
                          SizedBox(height: 30),
                          CircleAvatar(
                            radius: 80.0,
                            backgroundColor: Colors.red[900],
                            backgroundImage:
                                AssetImage('Images/ic_launcher.png'),
                          ),
                          SizedBox(height: 185),
                          Container(
                            //width: 350,
                            width: MediaQuery.of(context).size.width * 0.93,
                            //padding: EdgeInsets.all(20),
                            child: TextFormField(
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 15.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(250),
                                ),
                                /*hintText: 'Email',*/
                                icon: Icon(
                                  Icons.attach_email_rounded,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.purple)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xA6000000),
                                      style: BorderStyle.solid,
                                      width: 2.5),
                                ),
                                labelText: "Email",
                                labelStyle: TextStyle(
                                    color: const Color(0xC7000000),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _email = value.trim();
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.93,
                            child: TextFormField(
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              obscureText: !_passwordVisible,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 15.0),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(125.0)),
                                ),
                                icon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.orange)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xA6000000),
                                      style: BorderStyle.solid,
                                      width: 2.5),
                                ),
                                labelText: "Password",
                                labelStyle: TextStyle(
                                    color: const Color(0xC4000000),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                                suffixIcon: IconButton(
                                    icon: Icon(
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: const Color(0xD5FFFFFF)),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    }),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _password = value.trim();
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              SizedBox(width: 250),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height:
                                    MediaQuery.of(context).size.width * 0.10,
                                //width: double.infinity,
                                child: MaterialButton(
                                  color: Colors.red[900],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Login",
                                        style: new TextStyle(
                                            fontFamily: 'Open Sans',
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(
                                        Icons.arrow_forward_outlined,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                  onPressed: () async {
                                    try {
                                      setState(() => isloading = true);
                                      await auth.signInWithEmailAndPassword(
                                          email: _email, password: _password);
                                      String em = _email;
                                      await savingEmail(em);
                                      var userinfo = retrievingUser(_email);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewCalendar(
                                                      userinfor: userinfo)));
                                      setState(() => isloading = false);
                                    } catch (e) {
                                      Alert(
                                        context: context,
                                        type: AlertType.error,
                                        title: "Error",
                                        desc: e.toString(),
                                        buttons: [
                                          DialogButton(
                                            gradient: LinearGradient(colors: [
                                              Color.fromRGBO(
                                                  116, 116, 191, 1.0),
                                              Color.fromRGBO(52, 138, 199, 1.0)
                                            ]),
                                            child: Text(
                                              "Ok",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            onPressed: () => Navigator.of(
                                                    context,
                                                    rootNavigator: true)
                                                .pop(),
                                            width: 120,
                                          )
                                        ],
                                      ).show();
                                      setState(() => isloading = false);
                                    }
                                  },
                                ),
                              ),
                            ],
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
