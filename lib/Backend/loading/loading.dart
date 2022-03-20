import 'package:flutter/material.dart';
import 'package:timesheet_app/Backend/loading/loader.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      child: Center(child:
      ColorLoader3(dotRadius: 20.0 ,radius: 30.0), 
      ),
    );
  }
}