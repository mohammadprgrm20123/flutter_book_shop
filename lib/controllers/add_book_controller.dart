import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../generated/l10n.dart';
import '../models/book_view_model.dart';
import '../repository/app_repository.dart';
import '../server/api_client.dart';

class AddBookController extends GetxController {
  final AppRepository _appRepository = AppRepository(ApiClient());
  final RxBool _loading = false.obs;

  TextEditingController bookNameCtr =TextEditingController();
  TextEditingController priceCtr=TextEditingController();
  TextEditingController authorNameCtr=TextEditingController();
  TextEditingController translatorNameCtr=TextEditingController();
  TextEditingController scoreCtr=TextEditingController();
  TextEditingController categoryCtr=TextEditingController();
  TextEditingController pagesCtr=TextEditingController();
  TextEditingController publisherCtr=TextEditingController();
  TextEditingController descBookCtr=TextEditingController();


  BookViewModel book = BookViewModel();
   RxnString errorTextOfBookName = RxnString('');
   RxnString errorTextBookPrice = RxnString('');
   RxnString errorTextBookAuthorName = RxnString('');
   RxnString errorTextBookScore = RxnString('');
   RxnString errorTextBookPages = RxnString('');
   RxnString errorTextBookPublisher = RxnString('');
   bool validatorBookName = false;
   bool validatorBookPrice = false;
   bool validatorBookAuthorName = false;
   bool validatorBookScore = false;
   bool validatorBookPages = false;
   bool validatorBookPublisher = false;
   List<String> listTags = [];
  RxString category = S.of(Get.context!).category_stoy.obs;

  RxBool get loading => _loading;

  void requestForAddBook(final BookViewModel book) {
    _loading(true);
    _appRepository.addBook(book);
    _loading(false);
  }

  void editBook(final BookViewModel book) {
    _loading(true);
    _appRepository.editBook(book);
    _loading(false);
  }
}
