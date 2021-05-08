import 'package:flutter/material.dart';
import 'package:timesheet_app/Screens/ViewCalendar.dart';
import 'package:timesheet_app/Screens/WorkStart.dart';

class SetLocation extends StatefulWidget {
  @override
  _SetLocationState createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: SafeArea(
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
                    var name="Bonn Office";
                   Navigator.push(context, MaterialPageRoute(builder:(context) => WorkStart(location: name)));
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
                    var name="Cologne messe";
                   Navigator.push(context, MaterialPageRoute(builder:(context) => WorkStart(location: name)));
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
                    var name="Dusseldorf";
                   Navigator.push(context, MaterialPageRoute(builder:(context) => WorkStart(location: name)));
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
                    var name="Production";
                   Navigator.push(context, MaterialPageRoute(builder:(context) => WorkStart(location: name)));
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
                    var name="DNC";
                   Navigator.push(context, MaterialPageRoute(builder:(context) => WorkStart(location: name)));
                  },
                ),
              ),
            ],
            ),
          )
          ),
        ));
  }
}
