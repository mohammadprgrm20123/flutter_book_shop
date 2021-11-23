import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/details_controller.dart';
import '../../../generated/l10n.dart';
import '../../../models/book_view_model.dart';
import 'list_tag.dart';
import 'rating_bar.dart';

class OtherBookDetails extends GetView<DetailController> {
  final BookViewModel bookViewModel;

  const OtherBookDetails({final this.bookViewModel, final Key key})
      : super(key: key);

  @override
  Widget build(final BuildContext context) => _detailsOfBooks(context);

  Widget _detailsOfBooks(final BuildContext context) => Obx(() {
        if (controller.loading.value == true) {
          return const CircularProgressIndicator();
        } else {
          return Column(
            children: _children(context),
          );
        }
      });

  List<Widget> _children(final BuildContext context) => [
        _image(bookViewModel.url),
        _bookName(bookViewModel.bookName),
        _authorName(bookViewModel.autherName, bookViewModel.translator),
        _score(bookViewModel.score),
        _btnAddToShop(context, bookViewModel.price),
        _btnAddFavorite(context),
        _divider(),
        _introduction(context),
        _description(context, bookViewModel.desc),
        _dividerHeight10(),
        _otherPropertiesOfBook(bookViewModel),
        _dividerHeight10(),
        ListTag()
      ];

  Widget _authorName(final String authorName, final String translator) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          '$authorName/$translator',
          style: const TextStyle(color: Colors.black38, fontSize: 14.0),
        ),
      );

  Widget _bookName(final String bookName) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          bookName,
          style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
      );

  Widget _image(final String url) => Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: _cardImageBook(url),
        ),
      );

  Widget _cardImageBook(final String url) => Card(
        elevation: 10.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: FadeInImage.assetNetwork(
            fadeInCurve: Curves.bounceIn,
            height: 240.0,
            image: url,
            placeholder: 'assets/images/1.jpg',
          ),
        ),
      );

  Widget _btnAddToShop(final BuildContext context, final String price) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SizedBox(
            height: 50.0,
            width: MediaQuery.of(context).size.width,
            child: _btn(price)),
      );

  Widget _description(final BuildContext context, final String desc) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(desc,
            style: const TextStyle(fontSize: 13.0, color: Colors.black45)),
      );

  Widget _introduction(final BuildContext context) => Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(S.of(context).book_introduction,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ));

  Widget _divider() => const Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        child: Divider(
          thickness: 1.0,
          color: Colors.black12,
        ),
      );

  Widget _btnAddFavorite(final BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: SizedBox(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          child: _outlineButton(context),
        ),
      );

  Widget _dividerHeight10() => const Divider(
        height: 10.0,
        thickness: 1.0,
        color: Colors.black,
      );

  Widget _otherPropertiesOfBook(final BookViewModel bookViewModel) =>
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _category(bookViewModel.category),
            _price(bookViewModel.price),
            _publisher(bookViewModel.publisherName),
            _countPages(bookViewModel.pages),
          ],
        ),
      );

  Widget _price(final String price) => Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const Text('قیمت'),
              Text(
                price,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );

  Widget _countPages(final String countPage) => Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Column(
                  children: [
                    const Text('تعداد صفحات'),
                    Text(
                      countPage,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget _publisher(final String publisher) => Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const Text('ناشر'),
              Text(
                publisher,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );

  Widget _category(final String category) => Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const Text('دسته بندی'),
                Text(
                  category,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _outlineButton(final BuildContext context) => OutlineButton(
      onPressed: () {
        controller.addBookToFavoriteList(bookViewModel);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      child: Obx(() {
        if (controller.loadingBtnClick.value == true) {
          return const CircularProgressIndicator();
        } else {
          return Text(S.of(context).add_to_favorite);
        }
      }));

  Widget _btn(final String price) => ElevatedButton(
        onPressed: () {
          controller.addBookToCartShop(bookViewModel);
        },
        child: Obx(() {
          if (controller.loadingBtnClick.value == true) {
            return const CircularProgressIndicator();
          } else {
            return Text('اضافه کردن به سبد خرید    $price تومان ');
          }
        }),
      );

  Widget _score(final double score) => Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
                icon: const Icon(
                  Icons.share_outlined,
                  size: 30.0,
                ),
                onPressed: () {
                  controller.shareData();
                }),
          ),
          _textScore(score),
          RatingBarWidget(score: score),
        ],
      );

  Widget _textScore(final double score) => Expanded(
          child: Text(
        '$score/5',
        textAlign: TextAlign.end,
        style: const TextStyle(fontSize: 14.0),
      ));


}
