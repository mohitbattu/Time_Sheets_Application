import 'package:http/http.dart' as http;
var table;
Future<String> getFirebaseData(String user) async{
final response = await http.get(Uri.parse('https://timesheet-78e8e-default-rtdb.firebaseio.com/'+user+".json?"));
var extractedData = response.body;
return extractedData;
}



