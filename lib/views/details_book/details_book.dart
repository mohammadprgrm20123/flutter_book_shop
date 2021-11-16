import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/controllers/details_controller.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/book_view_model.dart';
import 'package:flutter_booki_shop/models/tag_view_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

@immutable
class DetailsBook extends StatelessWidget {
  static const int maxStar = 5;
  final int _bookId;
  final detailController = Get.put(DetailController());

  DetailsBook(this._bookId) {
    detailController.getDetailsBook(_bookId);
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: _appBar(context),
        body: _scrollView(context),
      );

  SingleChildScrollView _scrollView(final BuildContext context) =>
      SingleChildScrollView(
        child: _detailsOfBooks(context),
      );

  Widget _detailsOfBooks(final BuildContext context) => Obx(() {
        if (detailController.loading.value == true) {
          return const CircularProgressIndicator();
        } else {
          return Column(
            children: _children(context),
          );
        }
      });

  List<Widget> _children(final BuildContext context) => [
        _image(detailController.book.url),
        _bookName(detailController.book.bookName),
        _authorName(
            detailController.book.autherName, detailController.book.translator),
        _score(detailController.book.score),
        _btnAddToShop(context, detailController.book.price),
        _btnAddFavorite(context),
        _divider(),
        _introduction(context),
        _description(context, detailController.book.desc),
        _dividerHeight10(),
        _otherPropertiesOfBook(detailController.book),
        _dividerHeight10(),
        _listTags(detailController.book.tags)
      ];

  Widget _listTags(final List<TagViewModel> tags) =>
      Wrap(direction: Axis.horizontal, children: listTag());

  List<Widget> listTag() => detailController.book.tags
      .map((final e) => Container(
            margin: const EdgeInsets.only(right: 8.0, bottom: 15.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                e.tag,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ))
      .toList();

  Widget _otherPropertiesOfBook(final BookViewModel book) =>
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _category(book.category),
            _price(book.price),
            _publisher(book.publisherName),
            _countPages(book.pages),
          ],
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

  Widget _dividerHeight10() => const Divider(
        height: 10.0,
        thickness: 1.0,
        color: Colors.black,
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

  Widget _outlineButton(final BuildContext context) => OutlineButton(
        onPressed: () {
          detailController.addBookToFavoriteList(detailController.book);
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0)),
        child: Obx(() {
          if (detailController.loadingBtnClick.value == true) {
            return const CircularProgressIndicator();
          } else {
            return Text(S.of(context).add_to_favorite);
          }
        }));

  Widget _btnAddToShop(final BuildContext context, final String price) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: SizedBox(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          child: _btn(price)),
    );

  Widget _btn(final String price) => ElevatedButton(
      onPressed: () {
        detailController.addBookToCartShop(detailController.book);
      },
      child: Obx(() {
        if (detailController.loadingBtnClick.value == true) {
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
                _shareData();
              }),
        ),
        _textScore(score),
        _ratingBar(score),
      ],
    );

  Widget _textScore(final double score) => Expanded(
          child: Text(
        '$score/$maxStar',
        textAlign: TextAlign.end,
        style: const TextStyle(fontSize: 14.0),
      ));

  Widget _ratingBar(final double score) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: RatingBar.builder(
          onRatingUpdate: null,
          initialRating: score,
          minRating: 1,
          wrapAlignment: WrapAlignment.start,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: maxStar,
          itemSize: 20.0,
          itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
          itemBuilder: (final context, final _) => const Icon(
                Icons.star,
                color: Colors.amber,
              )),
    );

  void _shareData() {
    Share.share(
        '${detailController.book.bookName} \n ${detailController.book.desc} ');
  }

  Widget _authorName(final String authorName, final String translator) => Padding(
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

  AppBar _appBar(final BuildContext context) => AppBar(
      backgroundColor: Colors.white,
      title: _title(context),
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.black),
    );

  Widget _title(final BuildContext context) => Text(S.of(context).details,
        style: TextStyle(
            fontFamily: S.of(Get.context).name_font_dana,
            color: Colors.black,
            fontSize: 17.0));
}
