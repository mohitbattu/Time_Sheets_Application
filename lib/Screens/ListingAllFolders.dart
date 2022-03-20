import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:timesheet_app/Backend/ListingAllFolderBack.dart';
import 'package:json_table/json_table.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';


class ListingAllFolders extends StatefulWidget {
  var userinfo;
  ListingAllFolders({this.userinfo});
  @override
  _ListingAllFoldersState createState() => _ListingAllFoldersState();
}

class _ListingAllFoldersState extends State<ListingAllFolders> {
EasyRefreshController _controller;
Future<void> displayTable() async{
var gettingData = await getFirebaseData(widget.userinfo.toString());
var json=jsonDecode(gettingData);
setState(() {
  table=json;
});
}
@override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    await displayTable();
    _controller = EasyRefreshController();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xD2534A4A),
        appBar: AppBar(
          title: Text("View Time"),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: EasyRefresh(
          enableControlFinishRefresh: false,
          enableControlFinishLoad: true,
          controller: _controller,
          header: PhoenixHeader(),
          footer: PhoenixFooter(),
          onRefresh: () async{
            await displayTable();
          },
            child: SafeArea(
            child: SingleChildScrollView(
                child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Hour Protocol for Permanent Staff",
                      style: new TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  table==null?Center(child: CircularProgressIndicator(backgroundColor: Colors.black)): JsonTable(table,showColumnToggle: true,allowRowHighlight: true,rowHighlightColor: Colors.red[500].withOpacity(0.7),paginationRowCount: 31,columns: [
                     JsonTableColumn("Day", label: "Day"),
                     JsonTableColumn("WorkPlace", label: "WorkPlace"),
                     JsonTableColumn("Hours", label: "Hours"),
                     JsonTableColumn("Minute", label: "Minute"),
                     JsonTableColumn("TotalPauseTime", label: "Total_Pause_Time"),
                     JsonTableColumn("NumberOfMealsTime", label: "Number_of_Meals_Time"),
                     JsonTableColumn("SFrom", label: "Staff_From"),
                     JsonTableColumn("STo", label: "Staff_To"),
                     JsonTableColumn("P1From", label: "Pause_From1"),
                     JsonTableColumn("P1To", label: "Pause_To1"),
                     JsonTableColumn("P2From", label: "Pause_From2"),
                     JsonTableColumn("P2To", label: "Pause_To2"),
                    JsonTableColumn("CigarettePause", label: "Cigarette_Pause"),
                    JsonTableColumn("Remarks", label: "Remarks"),
                            ]),
                ],
              ),
            )),
          ),
        ),
      );
  }
}
