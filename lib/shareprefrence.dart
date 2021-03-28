
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


  void setCartShopList(List<String> list)async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'CartShopList';
    prefs.setStringList(key,list);
  }

  void addToCartShopList(String bookId) {
   getCartShopList().then((value) {
     value.add(bookId);
     setCartShopList(value);
   });

  }
  Future<List<String>> getCartShopList() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'CartShopList';
    final value = prefs.getStringList(key) ?? [];
    return value;
  }


}