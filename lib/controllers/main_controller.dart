
import 'package:get/get.dart';

import '../shareprefrence.dart';

class MainController extends GetxController{
  Rx<int> _indexStartPage = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Rx<int> get indexStartPage => _indexStartPage;

  void checkUserLogin() async{
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
    });
  }
}