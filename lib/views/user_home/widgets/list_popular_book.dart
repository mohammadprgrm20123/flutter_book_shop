import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/home_controller.dart';
import '../../details_book/details_book.dart';
import 'book_item.dart';
import 'title_list.dart';

class ListPopularBook extends StatelessWidget {
  final controller = Get.find<HomeController>();

  @override
  Widget build(final BuildContext context) => Column(
        children: [
          TitleList(
            onTap: () {},
            title: 'معروف ترین ها',
          ),
          _listPopularBooks(),
        ],
      );

  Widget _listPopularBooks() => Obx(() {
        if (controller.loading.value == true) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Container(
            height: 230.0,
            child: ListView.builder(
              itemBuilder: (final _, final index) => BookItem(
                onTap: () {
                  Get.to(() => DetailsBook(
                        bookId: controller.listPopularBook[index].id,
                      ));
                },
                bookViewModel: controller.listPopularBook[index],
              ),
              itemCount: controller.listPopularBook.length,
              scrollDirection: Axis.horizontal,
            ),
          );
        }
      });
}
