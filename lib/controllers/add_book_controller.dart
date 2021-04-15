


import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/repository/app_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AddBookController extends GetxController{

  AppRepository _appRepository;
  RxBool _loading =false.obs;
  Book book=new Book();
  RxString _errorTextOfBookName="".obs;
  RxString _errorTextBookPrice=''.obs;
  RxString _errorTextBookAutherName=' '.obs;
  RxString _errorTextBookScore=''.obs;
  RxString _errorTextBookPages=''.obs;
  RxString _errorTextBookPublisher=''.obs;
  bool _validatorBookName=false;
  bool _validatorBookPrice=false;
  bool _validatorBookAutherName=false;
  bool _validatorBookScore=false;
  bool _validatorBookPages=false;
  bool _validatorBookPublisher=false;
  List<String> _listTags=[];
  bool get validatorBookAutherName => _validatorBookAutherName;

  set validatorBookAutherName(bool value) {
    _validatorBookAutherName = value;
  }



  bool get validatorBookName => _validatorBookName;

  set validatorBookName(bool value) {
    _validatorBookName = value;
  }

  List<String> get listTags => _listTags;

  set listTags(List<String> value) {
    _listTags = value;
  }

  RxString get errorTextBookPublisher => _errorTextBookPublisher;

  set errorTextBookPublisher(RxString value) {
    _errorTextBookPublisher = value;
  }

  RxString get errorTextBookPages => _errorTextBookPages;

  set errorTextBookPages(RxString value) {
    _errorTextBookPages = value;
  }

  RxString category = "${S.of(Get.context).category_stoy}".obs;
  String _tag0;
  String _tag1;


  RxString get errorTextBookScore => _errorTextBookScore;

  set errorTextBookScore(RxString value) {
    _errorTextBookScore = value;
  }

  RxString get errorBookAutherName => _errorTextBookAutherName;

  set errorBookAutherName(RxString value) {
    _errorTextBookAutherName = value;
  }

  RxString get errorOfBookName => _errorTextOfBookName;

  set errorOfBookName(RxString value) {
    _errorTextOfBookName = value;
  }

  String _tag2;
  String _tag3;
  String _tag4;
  @override
  void onInit() {
    super.onInit();
    _appRepository =new AppRepository();
  }


  set tag0(String value) {
    _tag0 = value;
  }

  String get tag1 => _tag1;

  RxBool get loading => _loading;

  requestForAddBook(Book book) {
    _loading(true);
    _appRepository.requestAddBook(book);
    _loading(false);

  }

  String get tag2 => _tag2;

  String get tag3 => _tag3;

  String get tag4 => _tag4;

  String get tag0 => _tag0;

  set tag1(String value) {
    _tag1 = value;
  }

  set tag2(String value) {
    _tag2 = value;
  }

  set tag3(String value) {
    _tag3 = value;
  }

  set tag4(String value) {
    _tag4 = value;
  }

  RxString get errorBookPrice => _errorTextBookPrice;

  set errorBookPrice(RxString value) {
    _errorTextBookPrice = value;
  }

  bool get validatorBookPrice => _validatorBookPrice;

  set validatorBookPrice(bool value) {
    _validatorBookPrice = value;
  }



  bool get validatorBookScore => _validatorBookScore;

  set validatorBookScore(bool value) {
    _validatorBookScore = value;
  }

  bool get validatorBookPages => _validatorBookPages;

  set validatorBookPages(bool value) {
    _validatorBookPages = value;
  }

  bool get validatorBookPublisher => _validatorBookPublisher;

  set validatorBookPublisher(bool value) {
    _validatorBookPublisher = value;
  }


  void requestForEditBook(Book book) {
    _loading(true);
    _appRepository.requestForEditBook(book);
    _loading(false);
  }
}