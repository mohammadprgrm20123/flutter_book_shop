import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets/details_book.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../controllers/details_controller.dart';
import '../../generated/l10n.dart';

@immutable
class DetailsBook extends StatelessWidget {
  static const int maxStar = 5;
  final int bookId;
  final detailController = Get.put(DetailController());

  DetailsBook({final this.bookId}) {
    detailController.getDetailsBook(bookId);
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: _appBar(context),
        body: _scrollView(context),
      );

  Widget _scrollView(final BuildContext context) =>
      SingleChildScrollView(
        child: OtherBookDetails(bookViewModel: detailController.book,),
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
