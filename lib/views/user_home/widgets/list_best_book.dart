import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/views/details_book/details_book.dart';
import 'package:get/get.dart';

import '../../../controllers/home_controller.dart';
import '../../../generated/l10n.dart';
import 'book_item.dart';
import 'title_list.dart';

class ListBestBook extends StatelessWidget {
  final controller = Get.find<HomeController>();

  @override
  Widget build(final BuildContext context) => _bestBooks(context);

  Widget _bestBooks(final BuildContext context) => Container(
        decoration: _backgroundBoxDecoration(),
        child: Column(
          children: [
            TitleList(
              title: S.of(context).the_best,
              onTap: () {},
            ),
            _listBestBooks()
          ],
        ),
      );

  Widget _listBestBooks() => Obx(
        () {
          if (controller.loading.value == true) {
            return const CircularProgressIndicator();
          } else {
            return Container(
              height: 260,
              child: ListView.builder(
                itemBuilder: (final _, final index) => BookItem(
                  bookViewModel: controller.listBestBook[index],
                  onTap: () {
                    Get.to(() => DetailsBook(
                          bookId: controller.listBestBook[index].id!,
                        ));
                  },
                ),
                itemCount: controller.listBestBook.length,
                scrollDirection: Axis.horizontal,
              ),
            );
          }
        },
      );

  BoxDecoration _backgroundBoxDecoration() => const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white38,
            Colors.black12,
          ],
        ),
      );
}
