
import 'package:get/get.dart';

import '../shareprefrence.dart';

class MainController extends GetxController{
  RxBool _loading = false.obs;
  RxInt _indexStartPage = 0.obs;

  RxBool get loading => _loading;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Rx<int> get indexStartPage => _indexStartPage;

  void checkUserLogin() async{
    _loading(true);
    print("checkUserLogin");
    await MySharePrefrence().getRole().then((value){
      print("checkUserLogin --->$value");
      _loading(false);
      if(value.toString()=='none'){
        _indexStartPage(0);
      }
      else{
        if(value.toString()=='admin'){
          _indexStartPage(2);
        }else{
          if(value.toString()=='user'){
            _indexStartPage(1);
          }
        }
      }
      _loading(false);
    });

  }
}