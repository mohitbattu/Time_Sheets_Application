import 'package:flutter/material.dart';
import 'package:timesheet_app/Backend/loading/loading.dart';
import 'package:timesheet_app/Screens/WorkStart.dart';

class SetLocation extends StatefulWidget {
  var carryuser;
  SetLocation({this.carryuser});
  @override
  _SetLocationState createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  final _formKey = GlobalKey<FormState>();
  bool isloading = false;
  DateTime lastPressed;
  @override
  Widget build(BuildContext context) {
    return isloading ? Loading():Form(
      key: _formKey,
          child:Scaffold(
        backgroundColor: const Color(0xFF3F3838),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.location_city, size: 25, color: Colors.white),
            SizedBox(width: 20),
            Text("Set Location"),
          ]),
          centerTitle: true,
          toolbarHeight: 60.2,
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
              SizedBox(height: 115),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                //width: double.infinity,
                child: MaterialButton(
                  color: const Color(0xFF271D1D),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    "Bonn Office",
                    style: new TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    //TODO Write the navigation route
                    setState(()=> isloading=true);
                    var name="Bonn Office";
                    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => WorkStart(location: name,carryinfo: widget.carryuser)));
                    setState(()=> isloading=false);
                  },
                ),
              ),
              SizedBox(height: 25),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                //width: double.infinity,
                child: MaterialButton(
                  color: const Color(0xFF271D1D),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    "Cologne messe",
                    style: new TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    //TODO Write the navigation route
                    setState(()=> isloading=true);
                    var name="Cologne messe";
                   Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => WorkStart(location: name,carryinfo: widget.carryuser)));
                   setState(()=> isloading=false);
                  },
                ),
              ),
              SizedBox(height: 25),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                //width: double.infinity,
                child: MaterialButton(
                  color: const Color(0xFF271D1D),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    "Dusseldorf",
                    style: new TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    //TODO Write the navigation route
                    setState(()=> isloading=true);
                    var name="Dusseldorf";
                   Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => WorkStart(location: name,carryinfo: widget.carryuser)));
                  setState(()=> isloading=false);
                  
                  },
                ),
              ),
              SizedBox(height: 25),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                //width: double.infinity,
                child: MaterialButton(
                  color: const Color(0xFF271D1D),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    "Production",
                    style: new TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    //TODO Write the navigation route
                    setState(()=> isloading=true);
                    var name="Production";
                   Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => WorkStart(location: name,carryinfo: widget.carryuser)));
                  setState(()=> isloading=false);
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                //width: double.infinity,
                child: MaterialButton(
                  color: const Color(0xFF271D1D),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    "DNC",
                    style: new TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    //TODO Write the navigation route
                    setState(()=> isloading=true);
                    var name="DNC";
                   Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => WorkStart(location: name,carryinfo: widget.carryuser)));
                  setState(()=> isloading=false);
                  },
                ),
              ),
            ],
            ),
          )
          ),
        )),
          ),
    );
  }
}
