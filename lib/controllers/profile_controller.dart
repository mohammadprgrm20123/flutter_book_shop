
import 'package:flutter_booki_shop/models/User.dart';
import 'package:flutter_booki_shop/repository/AppRepository.dart';
import 'package:flutter_booki_shop/shareprefrence.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{

  RxBool _loading =false.obs;
  AppRepository _appRepository;
  final _user = User();

  RxBool get loading => _loading;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _appRepository = new AppRepository();
    getUserProfile();
  }



  getUserProfile() async{
    _loading(true);
   await MySharePrefrence().getPhone().then((value) {
      _user.phone = value;
      print(value.toString());
    });
    await  MySharePrefrence().getUserName().then((value) {
      _user.userName = value;
    });
    await MySharePrefrence().getPassword().then((value) {
      _user.password = value;
    });
    _loading(false);
  }

  User get user => _user;
}