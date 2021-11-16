import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/tag_view_model.dart';
import 'package:get/get.dart';
import 'package:tag_editor/tag_editor.dart';

import '../../controllers/add_book_controller.dart';
import '../../generated/l10n.dart';
import '../../models/book_view_model.dart';
import '../admin_home/admin_home.dart';

class AddBookPage extends StatelessWidget {
  List<String> spinnerList = [
    S.of(Get.context).category_stoy,
    S.of(Get.context).novel,
    S.of(Get.context).philosophy,
    S.of(Get.context).epic,
    S.of(Get.context).psychology,
  ];

  final addBookController = Get.put(AddBookController());

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: appBar(context),
        body: SingleChildScrollView(
          child: Column(
            children: _listWidget(context),
          ),
        ),
      );

  List<Widget> _listWidget(final BuildContext context) => [
        _image(),
        _bookName(),
        _price(),
        _authorName(),
        _translatorName(),
        _score(),
        _category(context),
        _countPages(),
        _publisher(),
        _summeryOfBook(),
        _tags(),
        _btnAddProduct(context)
      ];

  TagEditor _tags() => TagEditor(
        addTags: (final tag) {
          addBookController.listTags.add(tag);
        },
        removeTags: (final tag) {
          addBookController.listTags.remove(tag);
        },
      );

  SizedBox _btnAddProduct(final BuildContext context) => SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
          padding: const EdgeInsets.all(15.0), child: _elevatedButton()));

  ElevatedButton _elevatedButton() => ElevatedButton(onPressed: () {
        if (!validateParameters()) {
          sendRequestAddBook();
          Get.offAll(() => AdminHome());
        } else {
          Get.snackbar(S.of(Get.context).error, S.of(Get.context).not_filled);
        }
      }, child: Obx(() {
        if (addBookController.loading.value == true) {
          return const CircularProgressIndicator();
        } else {
          return Text(S.of(Get.context).add_product);
        }
      }));

  Widget _summeryOfBook() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
            keyboardType: TextInputType.text,
            onChanged: (final summery) {
              addBookController.book.desc = summery;
            },
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.description),
                border: const OutlineInputBorder(),
                labelText: S.of(Get.context).summery_of_book,
                hintText: S.of(Get.context).summery_of_book)),
      );

  Widget _publisher() => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Obx(() => TextField(
          keyboardType: TextInputType.text,
          onChanged: (final publisher) {
            addBookController.book.publisherName = publisher;
            _validatePublisher(publisher);
          },
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.account_circle),
              border: const OutlineInputBorder(),
              labelText: S.of(Get.context).publisher,
              errorText: addBookController.errorTextBookPublisher.value,
              hintText: S.of(Get.context).publisher))));

  Widget _countPages() => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Obx(() => TextField(
          keyboardType: TextInputType.number,
          onChanged: (final pages) {
            addBookController.book.pages = pages;
            _validateCountPages(pages);
          },
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.pages),
              border: const OutlineInputBorder(),
              labelText: S.of(Get.context).count_pages,
              errorText: addBookController.errorTextBookPages.value,
              hintText: S.of(Get.context).count_pages))));

  Widget _category(final BuildContext context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Obx(_dropdownButton),
        ),
      );

  DropdownButton<String> _dropdownButton() => DropdownButton<String>(
        value: addBookController.category.value,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: S.of(Get.context).name_font_dana),
        underline: Container(
          height: 2,
          color: Colors.blue,
        ),
        onChanged: (final data) {
          addBookController.category.value = data;
          addBookController.book.category = data;
        },
        items: spinnerList
            .map<DropdownMenuItem<String>>(
                (final value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
            .toList(),
      );

  Widget _score() => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Obx(() => TextField(
          keyboardType: TextInputType.number,
          onChanged: (final score) {
            addBookController.book.score = double.parse(score).toPrecision(1);
            validateScore(score);
          },
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.score),
              border: const OutlineInputBorder(),
              labelText: S.of(Get.context).score,
              errorText: addBookController.errorTextBookScore.value,
              hintText: S.of(Get.context).score))));

  Widget _translatorName() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
            keyboardType: TextInputType.text,
            onChanged: (final translator) {
              addBookController.book.translator = translator;
            },
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.translate),
                border: const OutlineInputBorder(),
                labelText: S.of(Get.context).translator_name,
                hintText: S.of(Get.context).translator_name)),
      );

  Widget _authorName() => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Obx(() => TextField(
          keyboardType: TextInputType.text,
          onChanged: (final authorName) {
            addBookController.book.autherName = authorName;
            validatorAutherName(authorName);
          },
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.account_circle),
              border: const OutlineInputBorder(),
              labelText: S.of(Get.context).author_name,
              errorText: addBookController.errorTextBookAuthorName.value,
              hintText: S.of(Get.context).author_name))));

  Widget _price() => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Obx(() => TextFormField(
          keyboardType: TextInputType.number,
          onChanged: (final price) {
            addBookController.book.price = price;
            validatePrice(price);
          },
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.account_circle),
              border: const OutlineInputBorder(),
              labelText: S.of(Get.context).price,
              errorText: addBookController.errorTextBookPrice.value,
              hintText: S.of(Get.context).price))));

  Widget _bookName() => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Obx(() => TextField(
          keyboardType: TextInputType.text,
          onChanged: (final bookName) {
            addBookController.book.bookName = bookName;
            _validateBookName(bookName);
          },
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.account_circle),
              border: const OutlineInputBorder(),
              labelText: S.of(Get.context).book_name,
              errorText: addBookController.errorTextBookPrice.value,
              hintText: S.of(Get.context).book_name))));

  Widget _image() => const Padding(
        padding: EdgeInsets.all(20.0),
        child: SizedBox(
            height: 120.0,
            width: 120.0,
            child: CircleAvatar(
                child: Icon(
              Icons.camera_alt,
              size: 45.0,
            ))),
      );

  AppBar appBar(final BuildContext context) => AppBar(
        backgroundColor: Colors.white,
        title: _title(context),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      );

  Text _title(final BuildContext context) => Text(S.of(Get.context).add_product,
      style: TextStyle(
          fontFamily: S.of(Get.context).name_font_dana,
          color: Colors.black,
          fontSize: 17.0));

  bool validateParameters() {
    if (addBookController.validatorBookScore &&
        addBookController.validatorBookPages &&
        addBookController.validatorBookAuthorName &&
        addBookController.validatorBookPrice &&
        addBookController.validatorBookName &&
        addBookController.validatorBookPublisher) {
      return false;
    }
    Get.snackbar(S.of(Get.context).error,
        S.of(Get.context).has_problem_wher_enter_the_info);
    return true;
  }

  void sendRequestAddBook() {
    addBookController.requestForAddBook(_initBookParameters());
    addBookController.requestForAddBook(_initBookParameters());
  }

  BookViewModel _initBookParameters() {
    final List<TagViewModel> listTag = [];
    addBookController.listTags.forEach((final tagItem) {
      listTag.add(TagViewModel(tag: tagItem));
    });
    addBookController.book.tags = listTag;
    addBookController.book.category = addBookController.category.value;
    addBookController.book.releaseDate = "";
    addBookController.book.createdAt = "";
    addBookController.book.url = "";
    return addBookController.book;
  }

  void validatePrice(final String price) {
    if (price.isEmpty) {
      addBookController.errorTextBookPrice.value =
          S.of(Get.context).should_not_empty;
      addBookController.validatorBookPages = false;
    } else {
      final double priceDouble = double.parse(price).toPrecision(1);
      if (priceDouble < 5000 || priceDouble > 100000) {
        addBookController.validatorBookPrice = false;
      } else {
        addBookController.validatorBookPrice = true;
      }
    }
  }

  void validatorAutherName(final String authorName) {
    if (authorName.isEmpty) {
      S.of(Get.context).authername_not_empty;
      addBookController.validatorBookAuthorName = false;
    } else {
      addBookController.validatorBookAuthorName = true;
    }
  }

  void validateScore(final String score) {
    if (score.isEmpty) {
      addBookController.errorTextBookScore.value =
          S.of(Get.context).score_not_empty;
      addBookController.validatorBookScore = false;
    } else {
      final double scoreDouble = double.parse(score).toPrecision(1);
      if (scoreDouble > 5 || scoreDouble == 0) {
        addBookController.errorTextBookScore.value =
            S.of(Get.context).score_betwwen_1_5;
        addBookController.validatorBookScore = false;
      } else {
        addBookController.errorTextBookScore.value = null;
        addBookController.validatorBookScore = true;
      }
    }
  }

  void _validateBookName(final String bookName) {
    if (bookName.isEmpty) {
      addBookController.validatorBookName = false;
    } else {
      addBookController.validatorBookName = true;
    }
  }

  void _validateCountPages(final String pages) {
    if (pages.isEmpty) {
      addBookController.errorTextBookPages.value =
          S.of(Get.context).should_not_empty;
      addBookController.validatorBookPages = false;
    } else {
      addBookController.errorTextBookPages.value = null;
      addBookController.validatorBookPages = true;
    }
  }

  void _validatePublisher(final String publisher) {
    if (publisher.isEmpty) {
      addBookController.errorTextBookPublisher.value =
          S.of(Get.context).should_not_empty;
      addBookController.validatorBookPublisher = false;
    } else {
      addBookController.errorTextBookPublisher.value = null;
      addBookController.validatorBookPublisher = true;
    }
  }
}
