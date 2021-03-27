
import 'package:shared_preferences/shared_preferences.dart';

class MySharePrefrence {
  var _pref;
  getMySharePrefrence() async{
    _pref = await SharedPreferences.getInstance();
  }


  void setId(int id) async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    prefs.setInt(key, id);
  }

   Future<int> getId() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final value = prefs.getInt(key) ?? 0;
    print('read: $value');
    return value;
  }

  void setRole(String role) async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'role';
    prefs.setString(key, role);
  }
  Future<String> getRole() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'role';
    final value = prefs.getString(key) ?? 'none';
    return value;
  }



}