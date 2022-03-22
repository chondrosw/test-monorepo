import 'package:shared_preferences/shared_preferences.dart';

class UserServiceTesting{
  Future<String> addInstance({required String username})async{
    final dataSet = await SharedPreferences.getInstance();
    dataSet.setString("username", username);
    return username;
  }
}
