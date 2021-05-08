import 'package:gsheets/gsheets.dart';
const _credentials =r'''{
  "type": "service_account",
  "project_id": "timesheet-78e8e",
  "private_key_id": "d87230be9e669b0e8964489838407d6a94e5735a",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDZUoMVPm61PUJt\nEcHH2sHT/KlwAWK6Cczoo45KdealjBxpQTjVPxaZTB0J4065DuimG4Afj3NJ14Hc\nkVUjUsNHfVr3Ipp59hOLkWVq5ePC52YqX7yq1caoKuytmzAIiIcTqglOZElnpHTg\n8DK/8SdQFYASvmtLhfwcTMDoOtFB9xYLvKOYGmYTJWNuyXhd/zyP2YtumeHhLjcY\nwXuPo8KbJq93k8IoWuelKsKc2rsQEaGQ0rDIWDYjgar5wu6fHIMp927238JbXdxF\n5QXHjKEyW5TGaoZnW5wl6iAb04Y96nea1KwtP/WGqrMPMzZO5rZaPo2iJZSQkbTE\naWssjqkDAgMBAAECggEAG/qdCL+kdi4AXtVx6t6VpMq7L8Hl6Yi4el0QRTLfsoGS\n6NQuUnoQWUUs2eiLapTqS/RvbuDDmYam3/RQDz+pB4uyie3JEJmnU4kxEu2tAJtV\nEnCH9ECYlm8MUJ+RtA+LwHLcRtzvfGn2aD1Uc1TDWHKkLgWY/7ysxCH3lg54gXLm\n8rrd/HfmL8F/J1S0AC51zOpBXVgx45Mgx/SFoZGnES5ntxO+L7O4v1k7fsVZgyoi\nIea9V6LNCmJmpjgUKNLy6qaQCqE/gUdvZ5mX8O73q4Nr+4gmbJDl5a4QB2u2C9Wt\nv+dcxhOnted5SOvUbkVJ39232BTvhuO9gfr7CVf/MQKBgQD39WwDrsMwtdzAYCQt\njE7Idz8y76bHu+wIZddVnoQH6VtD2XgEsQgzIVyUmileCHj+MrH4VDYmQ11N5HqZ\nHg36NG4gbKhZUXPOEvDIKt4Q3i3R/4EgJUBsnx1+3OIfJMBL61XcFm/5uRYtzMLZ\nxwGwOSZWxZ1lDX56FS1PD7KzEQKBgQDgXr5vuF/KSYa/R4IxcUxE2ByqdVhPz2TK\nWCgCpyEi0FVaP4HYB/XNpmjcj4oMYjB0Rx5FTJRdis97/yhAmjDX0609VLOmy+ZN\nhOOogGwZaKvPw6VkWvnP3B5kTpdtoqWf41gjYFSImPLUOXhBKRK6VVqMRtZis7+s\niAzSwQ/y0wKBgQDKmii41Zo9ecu3EJde9C8HU5A7IWAoAV+5+OS627vL7xuYU9/i\nDXjCtna8IT69y7R5F5kdbEmWeCKL261k4Q7Qqvh02/Ouj4RNFGLTW1t5cuEDnn62\nclmyp0xldTv58ICDR/Yuz9KMvHPn1lA7u4SgpgGykuOpRx5ZyGXuHMiJ0QKBgQCB\nHcSVYhKtxFYoqSwA6+QqEfudFF43v2+PCeAsdqUY9a7IepdsDFilecgKdQfKTI75\nuxtuYb1Xf1QbVSCC3LiS2xtsmduwdtIXdgvUoeKTVKraqwn4kGoF9fP/YUK/MsQB\nGMFVyk+bM/k5q8DKLqq6U/gBlZo1vp7k2H4YokVdRQKBgGN/0qT3n2NfFQ1k4s0m\n9iCCqrygGnBJk5xVraY4OzpTIoZmYQYnRbAvY5t1sE021yzgG0XvCWTH2Adrs/VX\nboiEJwtR1OyPICPDyedpiQioo0RaqU/cdxSWopQGjPKAgaauE/GcW0xt0H6f7soH\nqRkJpj0qRDFkJjfjDKn/vov5\n-----END PRIVATE KEY-----\n",
  "client_email": "firebasetosheets@timesheet-78e8e.iam.gserviceaccount.com",
  "client_id": "114119270602061485274",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebasetosheets%40timesheet-78e8e.iam.gserviceaccount.com"
}
''';

const _spreadsheetId = '109KmggnayMFE6wKyX3ET4VU1b408vxp9OfnXY27JZKc';

Future<void> UpdateStartWork(int id,String data) async{
  final gsheets = GSheets(_credentials);
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  var sheet = ss.worksheetByTitle("user1timesheet");
  print(sheet.values.allRows());
  print(await sheet.values.insertValue(data, column: 7, row: id+10));
}
Future<void> UpdateWorkLocation(int id,String data) async{
  final gsheets = GSheets(_credentials);
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  var sheet = ss.worksheetByTitle("user1timesheet");
  print(await sheet.values.insertValue(data, column: 2, row: id+10));
}
Future<void> UpdateWorkEnd(int id,String data) async{
  final gsheets = GSheets(_credentials);
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  var sheet = ss.worksheetByTitle("user1timesheet");
  print(sheet.values);
  print(await sheet.values.insertValue(data, column: 8, row: id+10));
}

Future<void> UpdateBreakEnd(int id,String data,int count) async{
  final gsheets = GSheets(_credentials);
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  var sheet = ss.worksheetByTitle("user1timesheet");
  var number=count+10;
  print("UPDATEBREAKEND");
  print(number);
  print(await sheet.values.insertValue(data, column: number, row: id+10));
}
Future<void> UpdateBreakStart(int id,String data,int count) async{
  final gsheets = GSheets(_credentials);
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  var sheet = ss.worksheetByTitle("user1timesheet");
  var number=9+count;
  print("UPDATEBREAKSTART");
  print(number);
  print(await sheet.values.insertValue(data, column: number, row: id+10));
}