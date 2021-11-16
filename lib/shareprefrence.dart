import 'package:shared_preferences/shared_preferences.dart';

class MySharePrefrence {
  void setId(final int id) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'user_id';
    await prefs.setInt(key, id);
  }

  Future<int> getId() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'user_id';
    final value = prefs.getInt(key) ?? 0;
    return value;
  }

  void setRole(final String role) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'role';
    await prefs.setString(key, role);
  }

  Future<String> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'role';
    final value = prefs.getString(key) ?? 'none';
    return value;
  }

  void setPhone(final String phone) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'phone';
    await prefs.setString(key, phone);
  }

  Future<String> getPhone() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'phone';
    final value = prefs.getString(key) ?? 'none';
    return value;
  }

  void setUserName(final String userName) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'userName';
    await prefs.setString(key, userName);
  }

  Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'userName';
    final value = prefs.getString(key) ?? 'none';
    return value;
  }

  void setPassword(final String password) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'password';
    await prefs.setString(key, password);
  }

  Future<String> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'password';
    final value = prefs.getString(key) ?? 'none';
    return value;
  }

  void setCartShopList(final List<String> list) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'CartShopList';
    await prefs.setStringList(key, list);
  }

  void addToCartShopList(final String bookId) {
    getCartShopList().then((final value) {
      value.add(bookId);
      setCartShopList(value);
    });
  }

  Future<List<String>> getCartShopList() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'CartShopList';
    final value = prefs.getStringList(key) ?? [];
    return value;
  }

  void clearShareprefrence() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
