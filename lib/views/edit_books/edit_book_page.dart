import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tag_editor/tag_editor.dart';

import '../../controllers/add_book_controller.dart';
import '../../generated/l10n.dart';
import '../../models/book_view_model.dart';
import '../../models/tag_view_model.dart';
import '../admin_home/admin_home.dart';

class EditBookPage extends StatelessWidget {
  List<String> spinnerList = [
    S.of(Get.context!).category_stoy,
    S.of(Get.context!).novel,
    S.of(Get.context!).philosophy,
    S.of(Get.context!).epic,
    S.of(Get.context!).psychology,
  ];
  final controller = Get.put(AddBookController());
  BookViewModel book;

  EditBookPage(this.book);

  @override
  Widget build(final BuildContext context) {
    initTextController();

    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: Form(
          key: controller.form,
          child: Column(
            children: _listWidget(context),
          ),
        ),
      ),
    );
  }

  void initTextController() {
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
            controller.listTags.add(tag);
          },
          removeTags: (final tag) {
            controller.listTags.remove(tag);
          },
          firstValueListTag: controller.listTags,
        ),
        _btnAddProduct(context)
      ];

  Widget _btnAddProduct(final BuildContext context) => SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ElevatedButton(
              onPressed: () {
                if (controller.form.currentState!.validate()) {
                  sendRequestAddBook();
                  Get.offAll(() => AdminHomePage());
                }
              },
              child: Text(S.of(context).record))));

  Widget _descOfBook() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextFormField(
          validator: validator,
            maxLines: 3,
            controller: controller.descBookCtr,
            onChanged: (final summery) {
              controller.book.desc = summery;
            },
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.description),
                border: const OutlineInputBorder(),
                labelText: S.of(Get.context!).summery_of_book,
                hintText: S.of(Get.context!).summery_of_book)),
      );

  Widget _publisher() => Obx(() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextFormField(
          validator: validator,
            controller: controller.publisherCtr,
            onChanged: (final publisher) {
              controller.book.publisherName = publisher;
              _validatePublisher(publisher);
            },
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.account_circle),
                border: const OutlineInputBorder(),
                errorText: controller.errorTextBookPublisher.value,
                labelText: S.of(Get.context!).publisher,
                hintText: S.of(Get.context!).publisher)),
      ));

  Widget _countPages() => Obx(() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextFormField(
          validator: validator,
            keyboardType: TextInputType.number,
            controller: controller.pagesCtr,
            onChanged: (final countPages) {
              controller.book.pages = countPages;
              _validateCountPages(countPages);
            },
            decoration:
                _decorationCountPages(controller.errorTextBookPages.value)),
      ));

  InputDecoration _decorationCountPages(final String? errorText) =>
      InputDecoration(
          prefixIcon: const Icon(Icons.pages),
          border: const OutlineInputBorder(),
          labelText: S.of(Get.context!).count_pages,
          errorText: errorText,
          hintText: S.of(Get.context!).count_pages);

  Widget _score() => Obx(() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextFormField(
          validator: validator,
            keyboardType: TextInputType.number,
            controller: controller.scoreCtr,
            onChanged: (final score) {
              controller.book.score = double.parse(score).toPrecision(1);
              _validateScore(score);
            },
            decoration: _decorationScore(controller.errorTextBookScore.value)),
      ));

  InputDecoration _decorationScore(final String? errorText) => InputDecoration(
      prefixIcon: const Icon(Icons.score),
      border: const OutlineInputBorder(),
      errorText: errorText,
      labelText: 'امتیاز',
      hintText: 'امتیاز');

  Widget _translatorName() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextFormField(
          validator: validator,
            controller: controller.translatorNameCtr,
            onChanged: (final translator) {
              controller.book.translator = translator;
            },
            decoration: _decorationTranslatorName()),
      );

  InputDecoration _decorationTranslatorName() => InputDecoration(
      prefixIcon: const Icon(Icons.translate),
      border: const OutlineInputBorder(),
      labelText: S.of(Get.context!).translator_name,
      hintText: S.of(Get.context!).translator_name);

  Widget _authorName() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextFormField(
          validator: validator,
            controller: controller.authorNameCtr,
            onChanged: (final authorName) {
              controller.book.autherName = authorName;
              _validatorAutherName(authorName);
            },
            decoration:
                _authorDecoration(controller.errorTextBookPrice.value!)),
      );

  InputDecoration _authorDecoration(final String errorText) => InputDecoration(
      prefixIcon: const Icon(Icons.account_circle),
      border: const OutlineInputBorder(),
      labelText: S.of(Get.context!).author_name,
      errorText: errorText,
      hintText: S.of(Get.context!).author_name);

  Widget _price() => Obx(() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextFormField(
          validator: validator,
            keyboardType: TextInputType.number,
            controller: controller.priceCtr,
            onChanged: (final price) {
              controller.book.price = price;
              _validatePrice(price);
            },
            decoration: _decorationPrice(controller.errorTextBookPrice.value!)),
      ));

  InputDecoration _decorationPrice(final String errorText) => InputDecoration(
      prefixIcon: const Icon(Icons.account_circle),
      border: const OutlineInputBorder(),
      labelText: S.of(Get.context!).price,
      errorText: errorText,
      hintText: S.of(Get.context!).price);

  Widget _bookName() => Obx(() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextFormField(
          validator: validator,
            controller: controller.bookNameCtr,
            onChanged: (final bookName) {
              controller.book.bookName = bookName;
              _validateBookName(bookName);
            },
            decoration:
                _decorationBookName(controller.errorTextOfBookName.value!)),
      ));
  String? validator(final String? value) {
    if (value != null && value.isEmpty) {
      return 'لطفا این مورد را پر کنید';
    }

    return null;
  }
  InputDecoration _decorationBookName(final String errorText) =>
      InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          border: const OutlineInputBorder(),
          labelText: S.of(Get.context!).book_name,
          errorText: errorText,
          hintText: S.of(Get.context!).book_name);

  AppBar _appBar(final BuildContext context) => AppBar(
        backgroundColor: Colors.white,
        title: _title(context),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      );

  Widget _title(final BuildContext context) => Text(
      S.of(Get.context!).edit_product,
      style: TextStyle(
          fontFamily: S.of(Get.context!).name_font_dana,
          color: Colors.black,
          fontSize: 17.0));

  bool validateParameters() {
    if (controller.validatorBookName &&
        controller.validatorBookAuthorName &&
        controller.validatorBookPublisher &&
        controller.validatorBookPrice &&
        controller.validatorBookPages &&
        controller.validatorBookScore) {
      return false;
    } else {
      Get.snackbar(
          S.of(Get.context!).error, S.of(Get.context!).please_fill_parameters);
      return true;
    }
  }

  void sendRequestAddBook() {
    controller.book.tags!.clear();
    for (final element in controller.listTags) {
      controller.book.tags!.add(TagViewModel(tag: element));
    }
    controller.editBook(controller.book);
  }

  void _initFirstValues(final BookViewModel book) {
    _fillBookValues(book);
    _firstValidate(book);
  }

  void _fillBookValues(final BookViewModel book) {
    controller.book = book;
    controller.bookNameCtr.text = book.bookName ?? '';
    controller.priceCtr.text = book.price ?? '';
    controller.authorNameCtr.text = book.autherName ?? '';
    controller.translatorNameCtr.text = book.translator ?? '';
    controller.scoreCtr.text =book.score==null ? '0' : book.score.toString() ;
    controller.categoryCtr.text = book.category ?? '';
    controller.pagesCtr.text = book.pages ?? '0';
    controller.publisherCtr.text = book.publisherName ?? '';
    controller.descBookCtr.text = book.desc ?? '';
    for (final element in book.tags!) {
      controller.listTags.add(element.tag!);
    }
    controller.category.value = book.category ?? '';
  }

  void _firstValidate(final BookViewModel book) {
    _validatePublisher(book.publisherName!);
    _validateCountPages(book.pages!);
    _validateScore(book.score.toString());
    _validatorAutherName(book.autherName!);
    _validatePrice(book.price!);
    _validateBookName(book.bookName!);
  }

  void _validatePrice(final String price) {
    if (price.isEmpty) {
      controller.errorTextBookPrice.value = S.of(Get.context!).should_not_empty;
      controller.validatorBookPrice = false;
    } else {
      final double priceDouble = double.parse(price).toPrecision(1);
      if (priceDouble < 5000 || priceDouble > 100000) {
        controller.validatorBookPrice = false;
      } else {}
    }
  }

  void _validatorAutherName(final String authorName) {
    if (authorName.isEmpty) {
      controller.validatorBookAuthorName = false;
    } else {}
  }

  void _validateScore(final String score) {
    if (score.isEmpty) {
      controller.errorTextBookScore.value = S.of(Get.context!).score_not_empty;
      controller.validatorBookScore = false;
    } else {
      final double scoreDouble = double.parse(score).toPrecision(1);
      if (scoreDouble > 5 || scoreDouble == 0) {
        controller.errorTextBookScore.value =
            S.of(Get.context!).score_betwwen_1_5;
        controller.validatorBookScore = false;
      } else {
        controller.errorTextBookScore.value = null;
        controller.validatorBookScore = true;
        controller.book.score = scoreDouble;
      }
    }
  }

  void _validateBookName(final String bookName) {
    if (bookName.isEmpty) {
    } else {}
  }

  void _validateCountPages(final String pages) {
    if (pages.isEmpty) {
      controller.errorTextBookPages.value = S.of(Get.context!).should_not_empty;
      controller.validatorBookPages = false;
    } else {
      controller.errorTextBookPages.value = null;
      controller.validatorBookPages = true;
    }
  }

  void _validatePublisher(final String publisher) {
    if (publisher.isEmpty) {
      controller.errorTextBookPublisher.value =
          S.of(Get.context!).should_not_empty;
      ;
      controller.validatorBookPublisher = false;
    } else {
      controller.errorTextBookPublisher.value = null;
      controller.validatorBookPublisher = true;
    }
  }
}
