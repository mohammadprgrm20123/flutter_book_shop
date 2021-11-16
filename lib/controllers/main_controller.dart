
import 'package:get/get.dart';

import '../shareprefrence.dart';

class MainController extends GetxController{
  RxBool loading = false.obs;
  RxInt indexStartPage = 0.obs;


  void checkUserLogin() async{
    loading(true);
    await MySharePrefrence().getRole().then((final value){
      if(value=='none'){
        indexStartPage(0);
      }
      else{
        if(value=='admin'){
          indexStartPage(2);
        }else{
          if(value=='user'){
            indexStartPage(1);
          }
        }
      }
      loading(false);
    });

  }
}