import 'package:get/get.dart';

import '../generated/l10n.dart';
import '../models/book_view_model.dart';
import '../repository/app_repository.dart';

class EditBookController extends GetxController {
  AppRepository _appRepository;
  final RxBool _loading = false.obs;
  BookViewModel book = BookViewModel();
  List<String> tags = [];
  RxString category = S.of(Get.context).category_stoy.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _appRepository = AppRepository();
  }

  void requestForEditBook(final BookViewModel book) {
    _loading(true);
    _appRepository.editBook(book);
    _loading(false);
  }
}
