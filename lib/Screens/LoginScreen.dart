import 'package:flutter/material.dart';
import 'ViewCalendar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF121212),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                CircleAvatar(
                  radius: 120.0,
                  backgroundColor: Colors.red[900],
                  backgroundImage: AssetImage('Images/ic_launcher.png'),
                ),
                SizedBox(height: 80),
                Container(
                  //width: 350,
                  width: MediaQuery.of(context).size.width * 0.93,
                  //padding: EdgeInsets.all(20),
                  child: TextFormField(
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(125.0)),
                      ),
                      /*hintText: 'Email',*/
                      icon: Icon(
                        Icons.attach_email_rounded,
                        color: Colors.white,
                      ),
                      /*hintStyle: TextStyle(color: Colors.white),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),*/
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.white),  
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
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    obscureText: true,
                    decoration: InputDecoration(
                      /*hintText: 'Password',
                                      hintStyle: TextStyle(color: Colors.white)*/
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(125.0)),
                      ),
                      icon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.white),
                      suffixIcon:
                          Icon(Icons.visibility_off, color: Colors.white70),
                    ),
                    onChanged: (value) {
                                  setState(() {
                                    _password = value.trim();
                                  });
                                },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.width * 0.1,
                  //width: double.infinity,
                  child: MaterialButton(
                    color: Colors.red[900],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      "Login",
                      style: new TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: () async{
                      await auth.signInWithEmailAndPassword(email: _email, password: _password);
                      Navigator.push(context, MaterialPageRoute(builder:(context) => ViewCalendar()));
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
