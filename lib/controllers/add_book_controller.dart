import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../generated/l10n.dart';
import '../models/book_view_model.dart';
import '../repository/app_repository.dart';

class AddBookController extends GetxController {
  AppRepository _appRepository;
  final RxBool _loading = false.obs;
  BookViewModel book = BookViewModel();
   RxString errorTextOfBookName = ''.obs;
   RxString errorTextBookPrice = ''.obs;
   RxString errorTextBookAuthorName = ' '.obs;
   RxString errorTextBookScore = ''.obs;
   RxString errorTextBookPages = ''.obs;
   RxString errorTextBookPublisher = ''.obs;
   bool validatorBookName = false;
   bool validatorBookPrice = false;
   bool validatorBookAuthorName = false;
   bool validatorBookScore = false;
   bool validatorBookPages = false;
   bool validatorBookPublisher = false;
   List<String> listTags = [];
  RxString category = S.of(Get.context).category_stoy.obs;

  @override
  void onInit() {
    super.onInit();
    _appRepository = AppRepository();
  }

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
