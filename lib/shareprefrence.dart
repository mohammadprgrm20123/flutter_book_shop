import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyStorage {
  void setId(final int id) async {
    final box = GetStorage();
    await box.write('user_id', id);
  }

  Future<int> getId() async {
    final box = GetStorage();
    return box.read('user_id');
  }

  void setRole(final String role) async {
    final box = GetStorage();
    await box.write('role', role);
  }

  Future<String> getRole() async {
    final box = GetStorage();
    return box.read('role');
  }

  void setPhone(final String phone) async {
    final box = GetStorage();
    await box.write('phone', phone);
  }

  Future<String> getPhone() async {
    final box = GetStorage();
    return box.read('phone');
  }

  void setUserName(final String userName) async {
    final box = GetStorage();
    await box.write('userName', userName);
  }

  Future<String> getUserName() async {
    final box = GetStorage();
    return box.read('userName');
  }

  void setPassword(final String password) async {
    final box = GetStorage();
    await box.write('password', password);
  }

  Future<String> getPassword() async {
    final box = GetStorage();
    return box.read('password');
  }

  void setCartShopList(final List<String> list) async {
    final box = GetStorage();
    await box.write('CartShopList', list);
  }

  void addToCartShopList(final String bookId) {
    getCartShopList().then((final value) {
      value.add(bookId);
      setCartShopList(value);
    });
  }

  Future<List<String>> getCartShopList() async {
    final box = GetStorage();
    return box.read('CartShopList');
  }

  void clearShareprefrence() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
