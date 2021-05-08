import 'package:shared_preferences/shared_preferences.dart';
Future<void> savingBool(bool val) async{
 SharedPreferences saveBool= await SharedPreferences.getInstance();
 saveBool.setBool('checking',val);
}
Future<bool> getBool() async{
 SharedPreferences getBool= await SharedPreferences.getInstance();
 bool result=getBool.getBool('checking');
 return result;
}
Future<void> savingCount1(int val) async{
 SharedPreferences saveCount= await SharedPreferences.getInstance();
 saveCount.setInt('Count1',val);
}
Future<int> getInt1() async{
 SharedPreferences getNum= await SharedPreferences.getInstance();
 int result=getNum.getInt('Count1')??0;
 return result;
}
Future<void> savingCount(int val) async{
 SharedPreferences saveCount= await SharedPreferences.getInstance();
 saveCount.setInt('Count',val);
}
Future<int> getInt() async{
 SharedPreferences getNum= await SharedPreferences.getInstance();
 int result=getNum.getInt('Count')??0;
 return result;
}