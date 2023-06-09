import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/details_controller.dart';
import '../../generated/l10n.dart';
import 'widgets/details_book.dart';

class DetailsBook extends GetView<DetailController>{
  static const int maxStar = 5;
  final int bookId;

  const DetailsBook({required this.bookId});

  @override
  Widget build(final BuildContext context) {
    Get.lazyPut(() => DetailController(bookId));

    return Scaffold(
      appBar: _appBar(context),
      body: _scrollView(context),
    );
  }
    Widget _scrollView(final BuildContext context) => SingleChildScrollView(
      child: Obx(() => controller.loading.value
          ? const CircularProgressIndicator()
          : controller.book.value!=null ?OtherBookDetails(
        bookViewModel: controller.book.value!,
      ) : const Center(child:Text('NO Data'))),
    );

    AppBar _appBar(final BuildContext context) => AppBar(
      backgroundColor: Colors.white,
      title: _title(context),
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.black),
    );

    Widget _title(final BuildContext context) => Text(S.of(context).details,
        style: TextStyle(
            fontFamily: S.of(Get.context!).name_font_dana,
            color: Colors.black,
            fontSize: 17.0));
  }

