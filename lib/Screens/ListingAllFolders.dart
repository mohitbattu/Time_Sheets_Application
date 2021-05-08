import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:timesheet_app/Backend/ListingAllFolderBack.dart';
import 'package:json_table/json_table.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';


class ListingAllFolders extends StatefulWidget {

  @override
  _ListingAllFoldersState createState() => _ListingAllFoldersState();
}

class _ListingAllFoldersState extends State<ListingAllFolders> {
EasyRefreshController _controller;
Future<void> displayTable() async{
var gettingData = await getFirebaseData();
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
                  // ),
                  // SizedBox(height: 25),
                  // Container(
                  //   height: 20,
                  //   width: MediaQuery.of(context).size.width,
                  //   child: ListView(
                  //     physics: ClampingScrollPhysics(),
                  //     shrinkWrap: true,
                  //     scrollDirection: Axis.horizontal,
                  //     children: [
                  //       Container(
                  //         width: MediaQuery.of(context).size.width * 0.3,
                  //         height: MediaQuery.of(context).size.width * 0.1,
                  //         //width: double.infinity,
                  //         child: MaterialButton(
                  //           color: Colors.green,
                  //           shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(8)),
                  //           child: Text(
                  //             "Work Start",
                  //             style: new TextStyle(
                  //                 fontFamily: 'Open Sans',
                  //                 fontSize: 16.0,
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Colors.white),
                  //           ),
                  //           onPressed: () async{
                  //             Directory path = Directory(
                  //                 "storage/emulated/0/ViewTime/Work Start");
                  //             await createFolder('Work Start');
                  //             setState(() {
                  //               storing = path;
                  //             });
                  //           },
                  //         ),
                  //       ),
                  //       SizedBox(width: 20),
                  //       Container(
                  //         width: MediaQuery.of(context).size.width * 0.3,
                  //         height: MediaQuery.of(context).size.width * 0.1,
                  //         //width: double.infinity,
                  //         child: MaterialButton(
                  //           color: Colors.red,
                  //           shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(8)),
                  //           child: Text(
                  //             "Work End",
                  //             style: new TextStyle(
                  //                 fontFamily: 'Open Sans',
                  //                 fontSize: 16.0,
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Colors.white),
                  //           ),
                  //           onPressed: () async{
                  //             //TODO Write the navigation route
                  //             // Navigator.push(context, MaterialPageRoute(builder:(context) => ViewCalendar()));
                  //             await createFolder('Work End');
                  //             Directory path = Directory(
                  //                 "storage/emulated/0/ViewTime/Work End");
                  //             setState(() {
                  //               storing = path;
                  //             });
                  //           },
                  //         ),
                  //       ),
                  //       SizedBox(width: 20),
                  //       Container(
                  //         width: MediaQuery.of(context).size.width * 0.3,
                  //         height: MediaQuery.of(context).size.width * 0.1,
                  //         //width: double.infinity,
                  //         child: MaterialButton(
                  //           color: Colors.yellow,
                  //           shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(8)),
                  //           child: Text(
                  //             "Break Start",
                  //             style: new TextStyle(
                  //                 fontFamily: 'Open Sans',
                  //                 fontSize: 16.0,
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Colors.black),
                  //           ),
                  //           onPressed: () async{
                  //             //TODO Write the navigation route
                  //             // Navigator.push(context, MaterialPageRoute(builder:(context) => ViewCalendar()));
                  //             await createFolder('Break Start');
                  //             Directory path = Directory(
                  //                 "storage/emulated/0/ViewTime/Break Start");
                  //             setState(() {
                  //               storing = path;
                  //             });
                  //           },
                  //         ),
                  //       ),
                  //       SizedBox(width: 20),
                  //       Container(
                  //         width: MediaQuery.of(context).size.width * 0.3,
                  //         height: MediaQuery.of(context).size.width * 0.1,
                  //         //width: double.infinity,
                  //         child: MaterialButton(
                  //           color: Colors.red,
                  //           shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(8)),
                  //           child: Text(
                  //             "Break End",
                  //             style: new TextStyle(
                  //                 fontFamily: 'Open Sans',
                  //                 fontSize: 16.0,
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Colors.black),
                  //           ),
                  //           onPressed: () async{
                  //             //TODO Write the navigation route
                  //             Directory path = Directory(
                  //                 "storage/emulated/0/ViewTime/Break End");
                  //             await createFolder('Break End');
                  //             setState(() {
                  //               storing = path;
                  //             });
                  //           },
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height:50),
                  // displayImages(storing??path),
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
//  Widget displayImages(Directory directory) {
//    try{
//     List<String> imageList = directory
//         .listSync()
//         .map((item) => item.path)
//         .where((item) => item.endsWith(".jpg"))
//         .toList(growable: false);
//     return GridView.builder(
//       shrinkWrap: true,
//       scrollDirection: Axis.vertical,
//       itemCount: imageList.length,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3, childAspectRatio: 3.0 / 4.6),
//       itemBuilder: (context, index) {
//         return Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(1.0),
//             child: InkWell(
//               child: Padding(
//                 padding: new EdgeInsets.all(4.0),
//                 child: Image.file(
//                   File(imageList[index]),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//    } catch(e){
//      print(e);
//    }
//   }
}
