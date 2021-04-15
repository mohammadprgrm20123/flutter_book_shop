
import 'package:get/get.dart';

import '../shareprefrence.dart';

class MainController extends GetxController{
  RxBool _loading = false.obs;
  RxInt _indexStartPage = 0.obs;
  RxBool get loading => _loading;

  Rx<int> get indexStartPage => _indexStartPage;

  void checkUserLogin() async{
    _loading(true);
    await MySharePrefrence().getRole().then((value){
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