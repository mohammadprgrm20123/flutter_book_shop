import 'package:get/get.dart';

import '../generated/l10n.dart';
import '../models/book_view_model.dart';
import '../repository/app_repository.dart';
import '../server/api_client.dart';

class EditBookController extends GetxController {
  final AppRepository _appRepository =AppRepository(ApiClient());
  final RxBool _loading = false.obs;
  BookViewModel book = BookViewModel();
  List<String> tags = [];
  RxString category = S.of(Get.context!).category_stoy.obs;


  void requestForEditBook(final BookViewModel book) {
    _loading(true);
    _appRepository.editBook(book);
    _loading(false);
  }
}
