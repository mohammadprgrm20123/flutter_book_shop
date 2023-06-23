import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/home_controller.dart';
import '../../../custom_widgets/horisental_card_pager.dart';
import '../../details_book/details_book.dart';
import '../../more_books/more_page.dart';
import 'title_list.dart';

class ListAudioBook extends StatelessWidget {
  final controller = Get.find<HomeController>();

  @override
  Widget build(final BuildContext context) => Column(
        children: [
          TitleList(
              title: 'کتاب های صوتی',
              onTap: () {
                Get.to(() => MorePage());
              }),
          _listAudioBooks(),
        ],
      );

  Widget _listAudioBooks() => Obx(() {
        if (controller.loading.value == true) {
          return const CircularProgressIndicator();
        } else {
          return _itemListAudioBooks();
        }
      });

  Padding _itemListAudioBooks() => Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: HorizontalCardPager(
          initialPage: controller.itemsAudioBook.length ~/ 2,
          onPageChanged: (final page) => {},
          onSelectedItem: (final page) {

            Get.to(() => DetailsBook(bookId: controller.itemsAudioBook[page].id));
          },
          items: controller.itemsAudioBook,
        ),
      );
}
