import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/favorite_controller.dart';
import '../../generated/l10n.dart';
import '../../models/favorite_item_view_model.dart';
import '../../shareprefrence.dart';
import '../details_book/details_book.dart';

class Favorite extends StatelessWidget {
  static const int crosAxisCount = 2;
  final favoriteController = Get.put(FavoriteController());

  @override
  Widget build(final BuildContext context) {
    MyStorage().getId().then(favoriteController.getFavoriteBooks);

    return Scaffold(
        appBar: _appBar(context),
        body: _listBooks());
  }

  Widget _listBooks() => Obx(() {
        if (favoriteController.loading.value == true) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (favoriteController.listFavorite.isEmpty) {
            return Center(child: Text(S.of(Get.context).not_exit_cases));
          } else {
            return _gridView();
          }
        }
      });

  Widget _gridView() => GridView.builder(
        itemCount: favoriteController.listFavorite.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crosAxisCount),
        itemBuilder: (final context, final index) =>
            _itemList(favoriteController.listFavorite.elementAt(index)),
      );

  Widget _itemList(final FavoriteItem listFavorite) => GestureDetector(
      onTap: () {
        Get.to(DetailsBook(listFavorite.book.id));
      },
      child: _card(listFavorite),
    );

  Widget _card(final FavoriteItem item) => Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        elevation: 10.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _imageBook(item),
            _textBookName(item),
            Row(children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        favoriteController.listFavorite.remove(item);
                        favoriteController.removeFavoriteItem(item.id);
                      },
                      child: const Text(
                        'حذف',
                        overflow: TextOverflow.fade,
                      )))
            ]),
          ],
        ),
      ),
    );

  Widget _textBookName(final FavoriteItem listFavorite) => Center(
      child: Text(
        listFavorite.book.bookName,
      ),
    );

  Widget _imageBook(final FavoriteItem listFavorite) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: Image.network(
          listFavorite.book.url,
          height: 100,
          width: 100,
        ),
      ),
    );

  AppBar _appBar(final BuildContext context) => AppBar(
      title: _title(context),
      backgroundColor: Colors.white,
      centerTitle: true,
    );

  Widget _title(final BuildContext context) => Text(
      S.of(context).favorite,
      style: TextStyle(
          fontFamily: S.of(Get.context).name_font_dana,
          color: Colors.black,
          fontSize: 17.0),
    );
}
