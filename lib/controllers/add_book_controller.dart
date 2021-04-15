import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/repository/app_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AddBookController extends GetxController {
  AppRepository _appRepository;
  RxBool _loading = false.obs;
  Book book = new Book();
  RxString _errorTextOfBookName = "".obs;
  RxString _errorTextBookPrice = ''.obs;
  RxString _errorTextBookAuthorName = ' '.obs;
  RxString _errorTextBookScore = ''.obs;
  RxString _errorTextBookPages = ''.obs;
  RxString _errorTextBookPublisher = ''.obs;
  bool _validatorBookName = false;
  bool _validatorBookPrice = false;
  bool _validatorBookAuthorName = false;
  bool _validatorBookScore = false;
  bool _validatorBookPages = false;
  bool _validatorBookPublisher = false;
  List<String> _listTags = [];
  RxString category = "${S.of(Get.context).category_stoy}".obs;

  @override
  void onInit() {
    super.onInit();
    _appRepository = new AppRepository();
  }

  RxBool get loading => _loading;

  requestForAddBook(Book book) {
    _loading(true);
    _appRepository.addBook(book);
    _loading(false);
  }

  bool get validatorBookAuthorName => _validatorBookAuthorName;

  set validatorBookAuthorName(bool value) {
    _validatorBookAuthorName = value;
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

  RxString get errorTextBookScore => _errorTextBookScore;

  set errorTextBookScore(RxString value) {
    _errorTextBookScore = value;
  }

  RxString get errorBookAutherName => _errorTextBookAuthorName;

  set errorBookAutherName(RxString value) {
    _errorTextBookAuthorName = value;
  }

  RxString get errorOfBookName => _errorTextOfBookName;

  set errorOfBookName(RxString value) {
    _errorTextOfBookName = value;
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

  void editBook(Book book) {
    _loading(true);
    _appRepository.editBook(book);
    _loading(false);
  }
}
