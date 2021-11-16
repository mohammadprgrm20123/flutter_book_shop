import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/models/tag_view_model.dart';
import 'package:get/get.dart';
import 'package:tag_editor/tag_editor.dart';

import '../../controllers/add_book_controller.dart';
import '../../generated/l10n.dart';
import '../../models/book_view_model.dart';
import '../admin_home/admin_home.dart';

@immutable
class EditBookPage extends StatelessWidget {
  List<String> spinnerList = [
    S.of(Get.context).category_stoy,
    S.of(Get.context).novel,
    S.of(Get.context).philosophy,
    S.of(Get.context).epic,
    S.of(Get.context).psychology,
  ];
  final editBookController = Get.put(AddBookController());
  BookViewModel book;
  TextEditingController _bookNameCtr;
  TextEditingController _priceCtr;
  TextEditingController _authorNameCtr;
  TextEditingController _translatorNameCtr;
  TextEditingController _scoreCtr;
  TextEditingController _categoryCtr;
  TextEditingController _pagesCtr;
  TextEditingController _publisherCtr;
  TextEditingController _descBookCtr;

  EditBookPage(this.book);

  @override
  Widget build(final BuildContext context) {
    initTextController();

    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: _listWidget(context),
        ),
      ),
    );
  }

  void initTextController() {
    _bookNameCtr = TextEditingController();
    _priceCtr = TextEditingController();
    _authorNameCtr = TextEditingController();
    _translatorNameCtr = TextEditingController();
    _scoreCtr = TextEditingController();
    _categoryCtr = TextEditingController();
    _pagesCtr = TextEditingController();
    _publisherCtr = TextEditingController();
    _descBookCtr = TextEditingController();
    _initFirstValues(book);
  }

  List<Widget> _listWidget(final BuildContext context) => [
        _bookName(),
        _price(),
        _authorName(),
        _translatorName(),
        _score(),
        _countPages(),
        _publisher(),
        _descOfBook(),
        TagEditor(
          addTags: (final tag) {
            editBookController.listTags.add(tag);
          },
          removeTags: (final tag) {
            editBookController.listTags.remove(tag);
          },
          firstValueListTag: editBookController.listTags,
        ),
        _btnAddProduct(context)
      ];

  Widget _btnAddProduct(final BuildContext context) => SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ElevatedButton(
              onPressed: () {
                if (!validateParameters()) {
                  sendRequestAddBook();
                  Get.offAll(() => AdminHome());
                }
              },
              child: Text(S.of(context).record))));

  Widget _descOfBook() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
            maxLines: 3,
            controller: _descBookCtr,
            onChanged: (final summery) {
              editBookController.book.desc = summery;
            },
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.description),
                border: const OutlineInputBorder(),
                labelText: S.of(Get.context).summery_of_book,
                hintText: S.of(Get.context).summery_of_book)),
      );

  Widget _publisher() => Obx(() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
            controller: _publisherCtr,
            onChanged: (final publisher) {
              editBookController.book.publisherName = publisher;
              _validatePublisher(publisher);
            },
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.account_circle),
                border: const OutlineInputBorder(),
                errorText: editBookController.errorTextBookPublisher.value,
                labelText: S.of(Get.context).publisher,
                hintText: S.of(Get.context).publisher)),
      ));

  Widget _countPages() => Obx(() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
            keyboardType: TextInputType.number,
            controller: _pagesCtr,
            onChanged: (final countPages) {
              editBookController.book.pages = countPages;
              _validateCountPages(countPages);
            },
            decoration: _decorationCountPages(
                editBookController.errorTextBookPages.value)),
      ));

  InputDecoration _decorationCountPages(final String errorText) =>
      InputDecoration(
          prefixIcon: const Icon(Icons.pages),
          border: const OutlineInputBorder(),
          labelText: S.of(Get.context).count_pages,
          errorText: errorText,
          hintText: S.of(Get.context).count_pages);

  Widget _score() => Obx(() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
            keyboardType: TextInputType.number,
            controller: _scoreCtr,
            onChanged: (final score) {
              editBookController.book.score =
                  double.parse(score).toPrecision(1);
              _validateScore(score);
            },
            decoration:
                _decorationScore(editBookController.errorTextBookScore.value)),
      ));

  InputDecoration _decorationScore(final String errorText) => InputDecoration(
      prefixIcon: const Icon(Icons.score),
      border: const OutlineInputBorder(),
      errorText: errorText,
      labelText: 'امتیاز',
      hintText: 'امتیاز');

  Widget _translatorName() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
            controller: _translatorNameCtr,
            onChanged: (final translator) {
              editBookController.book.translator = translator;
            },
            decoration: _decorationTranslatorName()),
      );

  InputDecoration _decorationTranslatorName() => InputDecoration(
      prefixIcon: const Icon(Icons.translate),
      border: const OutlineInputBorder(),
      labelText: S.of(Get.context).translator_name,
      hintText: S.of(Get.context).translator_name);

  Widget _authorName() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
            controller: _authorNameCtr,
            onChanged: (final authorName) {
              editBookController.book.autherName = authorName;
              _validatorAutherName(authorName);
            },
            decoration:
                _authorDecoration(editBookController.errorTextBookPrice.value)),
      );

  InputDecoration _authorDecoration(final String errorText) => InputDecoration(
      prefixIcon: const Icon(Icons.account_circle),
      border: const OutlineInputBorder(),
      labelText: S.of(Get.context).author_name,
      errorText: errorText,
      hintText: S.of(Get.context).author_name);

  Widget _price() => Obx(() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
            keyboardType: TextInputType.number,
            controller: _priceCtr,
            onChanged: (final price) {
              editBookController.book.price = price;
              _validatePrice(price);
            },
            decoration:
                _decorationPrice(editBookController.errorTextBookPrice.value)),
      ));

  InputDecoration _decorationPrice(final String errorText) => InputDecoration(
      prefixIcon: const Icon(Icons.account_circle),
      border: const OutlineInputBorder(),
      labelText: S.of(Get.context).price,
      errorText: errorText,
      hintText: S.of(Get.context).price);

  Widget _bookName() => Obx(() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
            controller: _bookNameCtr,
            onChanged: (final bookName) {
              editBookController.book.bookName = bookName;
              _validateBookName(bookName);
            },
            decoration: _decorationBookName(
                editBookController.errorTextOfBookName.value)),
      ));

  InputDecoration _decorationBookName(final String errorText) =>
      InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          border: const OutlineInputBorder(),
          labelText: S.of(Get.context).book_name,
          errorText: errorText,
          hintText: S.of(Get.context).book_name);

  AppBar _appBar(final BuildContext context) => AppBar(
        backgroundColor: Colors.white,
        title: _title(context),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      );

  Widget _title(final BuildContext context) =>
      Text(S.of(Get.context).edit_product,
          style: TextStyle(
              fontFamily: S.of(Get.context).name_font_dana,
              color: Colors.black,
              fontSize: 17.0));

  bool validateParameters() {
    if (editBookController.validatorBookName &&
        editBookController.validatorBookAuthorName &&
        editBookController.validatorBookPublisher &&
        editBookController.validatorBookPrice &&
        editBookController.validatorBookPages &&
        editBookController.validatorBookScore) {
      return false;
    } else {
      Get.snackbar(
          S.of(Get.context).error, S.of(Get.context).please_fill_parameters);
      return true;
    }
  }

  void sendRequestAddBook() {
    editBookController.book.tags.clear();
    for (final element in editBookController.listTags) {
      editBookController.book.tags.add(TagViewModel(tag: element));
    }
    editBookController.editBook(editBookController.book);
  }

  void _initFirstValues(final BookViewModel book) {
    _fillBookValues(book);
    _firstValidate(book);
  }

  void _fillBookValues(final BookViewModel book) {
    editBookController.book = book;
    _bookNameCtr.text = book.bookName;
    _priceCtr.text = book.price;
    _authorNameCtr.text = book.autherName;
    _translatorNameCtr.text = book.translator;
    _scoreCtr.text = book.score.toString();
    _categoryCtr.text = book.category;
    _pagesCtr.text = book.pages;
    _publisherCtr.text = book.publisherName;
    _descBookCtr.text = book.desc;
    for (final element in book.tags) {
      editBookController.listTags.add(element.tag);
    }
    editBookController.category.value = book.category;
  }

  void _firstValidate(final BookViewModel book) {
    _validatePublisher(book.publisherName);
    _validateCountPages(book.pages);
    _validateScore(book.score.toString());
    _validatorAutherName(book.autherName);
    _validatePrice(book.price);
    _validateBookName(book.bookName);
  }

  void _validatePrice(final String price) {
    if (price.isEmpty) {
      editBookController.errorTextBookPrice.value =
          S.of(Get.context).should_not_empty;
      editBookController.validatorBookPrice = false;
    } else {
      final double priceDouble = double.parse(price).toPrecision(1);
      if (priceDouble < 5000 || priceDouble > 100000) {
        editBookController.validatorBookPrice = false;

      } else {

      }
    }
  }

  void _validatorAutherName(final String authorName) {
    if (authorName.isEmpty) {

      editBookController.validatorBookAuthorName = false;
    } else {
    }
  }

  void _validateScore(final String score) {
    if (score.isEmpty) {
      editBookController.errorTextBookScore.value =
          S.of(Get.context).score_not_empty;
      editBookController.validatorBookScore = false;
    } else {
      final double scoreDouble = double.parse(score).toPrecision(1);
      if (scoreDouble > 5 || scoreDouble == 0) {
        editBookController.errorTextBookScore.value =
            S.of(Get.context).score_betwwen_1_5;
        editBookController.validatorBookScore = false;
      } else {
        editBookController.errorTextBookScore.value = null;
        editBookController.validatorBookScore = true;
        editBookController.book.score = scoreDouble;
      }
    }
  }

  void _validateBookName(final String bookName) {
    if (bookName.isEmpty) {

    } else {

    }
  }

  void _validateCountPages(final String pages) {
    if (pages.isEmpty) {
      editBookController.errorTextBookPages.value =
          S.of(Get.context).should_not_empty;
      editBookController.validatorBookPages = false;
    } else {
      editBookController.errorTextBookPages.value = null;
      editBookController.validatorBookPages = true;
    }
  }

  void _validatePublisher(final String publisher) {
    if (publisher.isEmpty) {
      editBookController.errorTextBookPublisher.value =
          S.of(Get.context).should_not_empty;
      ;
      editBookController.validatorBookPublisher = false;
    } else {
      editBookController.errorTextBookPublisher.value = null;
      editBookController.validatorBookPublisher = true;
    }
  }
}
