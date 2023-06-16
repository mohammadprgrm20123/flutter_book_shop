import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tag_editor/tag_editor.dart';

import '../../controllers/add_book_controller.dart';
import '../../generated/l10n.dart';
import '../../models/book_view_model.dart';
import '../../models/tag_view_model.dart';
import '../admin_home/admin_home.dart';

class AddBookPage extends StatelessWidget {
  List<String> spinnerList = [
    S.of(Get.context!).category_stoy,
    S.of(Get.context!).novel,
    S.of(Get.context!).philosophy,
    S.of(Get.context!).epic,
    S.of(Get.context!).psychology,
  ];

  final controller = Get.put(AddBookController());

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: appBar(context),
        body: SingleChildScrollView(
          child: Form(
            key: controller.form,
            child: Column(
              children: _listWidget(context),
            ),
          ),
        ),
      );

  List<Widget> _listWidget(final BuildContext context) => [
        // _image(),
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
          controller.listTags.add(tag);
        },
        removeTags: (final tag) {
          controller.listTags.remove(tag);
        },
        firstValueListTag: const [],
      );

  SizedBox _btnAddProduct(final BuildContext context) => SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
          padding: const EdgeInsets.all(15.0), child: _elevatedButton()));

  ElevatedButton _elevatedButton() => ElevatedButton(onPressed: () async {

    if(controller.form.currentState!.validate()){
      final List<TagViewModel> listTag = [];
      controller.listTags.forEach((final tagItem) {
        listTag.add(TagViewModel(tag: tagItem));
      });
      controller.book.tags = listTag;
      controller.book.category = controller.category.value;
      controller.book.releaseDate = "";
      controller.book.createdAt = "";
      controller.book.url = "";
      controller.book =BookViewModel(
        autherName:controller.authorNameCtr.text,
        bookName: controller.bookNameCtr.text,
        category: controller.category.value,
        desc: controller.descBookCtr.text,
        url: '',
          createdAt: '',
        tags: listTag,
        releaseDate: '',
        isFavorite: false,
        isInCartShop: false,
        translator: controller.translatorNameCtr.text,
        score: 1.3,
        publisherName: controller.publisherCtr.text,
        pages: controller.pagesCtr.text,
        price: controller.priceCtr.text,



      );

      await controller.requestForAddBook(controller.book);
      //   sendRequestAddBook();
      //   Get.offAll(() => AdminHomePage());
      // } else {
      //   Get.snackbar(S.of(Get.context!).error, S.of(Get.context!).not_filled);


    }

        // if (!validateParameters()) {
        //   sendRequestAddBook();
        //   Get.offAll(() => AdminHomePage());
        // } else {
        //   Get.snackbar(S.of(Get.context!).error, S.of(Get.context!).not_filled);
        // }
      }, child: Obx(() {
        if (controller.loading.value == true) {
          return const CircularProgressIndicator();
        } else {
          return Text(S.of(Get.context!).add_product);
        }
      }));

  Widget _summeryOfBook() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextFormField(
            keyboardType: TextInputType.text,
            onChanged: (final summery) {
              controller.book.desc = summery;
            },
            validator: validator,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.description),
                border: const OutlineInputBorder(),
                labelText: S.of(Get.context!).summery_of_book,
                hintText: S.of(Get.context!).summery_of_book)),
      );

  Widget _publisher() => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Obx(() => TextFormField(
          keyboardType: TextInputType.text,
          onChanged: (final publisher) {
            controller.book.publisherName = publisher;
            _validatePublisher(publisher);
          },
          validator: validator,
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.account_circle),
              border: const OutlineInputBorder(),
              labelText: S.of(Get.context!).publisher,
              errorText: controller.errorTextBookPublisher.value,
              hintText: S.of(Get.context!).publisher))));

  Widget _countPages() => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Obx(() => TextFormField(
          keyboardType: TextInputType.number,
          // onChanged: (final pages) {
          //   addBookController.book.pages = pages;
          //   _validateCountPages(pages);
          // },
          validator: validator,
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.pages),
              border: const OutlineInputBorder(),
              labelText: S.of(Get.context!).count_pages,
              errorText: controller.errorTextBookPages.value,
              hintText: S.of(Get.context!).count_pages))));

  Widget _category(final BuildContext context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Obx(_dropdownButton),
        ),
      );

  DropdownButton<String> _dropdownButton() => DropdownButton<String>(
        value: controller.category.value,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: S.of(Get.context!).name_font_dana),
        underline: Container(
          height: 2,
          color: Colors.blue,
        ),
        onChanged: (final data) {
          if (data != null) {
            controller.category.value = data;
            controller.book.category = data;
          }
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
      child: Obx(() => TextFormField(
          keyboardType: TextInputType.number,
          // onChanged: (final score) {
          //   addBookController.book.score = double.parse(score).toPrecision(1);
          //   validateScore(score);
          // },
          validator: validator,
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.score),
              border: const OutlineInputBorder(),
              labelText: S.of(Get.context!).score,
              errorText: controller.errorTextBookScore.value,
              hintText: S.of(Get.context!).score))));

  Widget _translatorName() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextFormField(
            keyboardType: TextInputType.text,
            // onChanged: (final translator) {
            //   addBookController.book.translator = translator;
            // },
            validator: validator,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.translate),
                border: const OutlineInputBorder(),
                labelText: S.of(Get.context!).translator_name,
                hintText: S.of(Get.context!).translator_name)),
      );

  Widget _authorName() => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Obx(() => TextFormField(
          keyboardType: TextInputType.text,
          validator: validator,
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.account_circle),
              border: const OutlineInputBorder(),
              labelText: S.of(Get.context!).author_name,
              errorText: controller.errorTextBookAuthorName.value,
              hintText: S.of(Get.context!).author_name))));

  Widget _price() => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Obx(() => TextFormField(
          keyboardType: TextInputType.number,
          validator: validator,
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.account_circle),
              border: const OutlineInputBorder(),
              labelText: S.of(Get.context!).price,
              errorText: controller.errorTextBookPrice.value,
              hintText: S.of(Get.context!).price))));

  Widget _bookName() => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Obx(() => TextFormField(
          keyboardType: TextInputType.text,
          validator: validator,
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.account_circle),
              border: const OutlineInputBorder(),
              labelText: S.of(Get.context!).book_name,
              errorText: controller.errorTextBookPrice.value,
              hintText: S.of(Get.context!).book_name))));

  String? validator(final String? value) {
    if (value != null && value.isEmpty) {
      return 'لطفا این مورد را پر کنید';
    }

    return null;
  }

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

  Text _title(final BuildContext context) =>
      Text(S.of(Get.context!).add_product,
          style: TextStyle(
              fontFamily: S.of(Get.context!).name_font_dana,
              color: Colors.black,
              fontSize: 17.0));

  bool validateParameters() {
    if (controller.validatorBookScore &&
        controller.validatorBookPages &&
        controller.validatorBookAuthorName &&
        controller.validatorBookPrice &&
        controller.validatorBookName &&
        controller.validatorBookPublisher) {
      return false;
    }
    Get.snackbar(S.of(Get.context!).error,
        S.of(Get.context!).has_problem_wher_enter_the_info);
    return true;
  }

  void sendRequestAddBook() {
    controller.requestForAddBook(_initBookParameters());
    controller.requestForAddBook(_initBookParameters());
  }

  BookViewModel _initBookParameters() {
    final List<TagViewModel> listTag = [];
    controller.listTags.forEach((final tagItem) {
      listTag.add(TagViewModel(tag: tagItem));
    });
    controller.book.tags = listTag;
    controller.book.category = controller.category.value;
    controller.book.releaseDate = "";
    controller.book.createdAt = "";
    controller.book.url = "";
    return controller.book;
  }

  void validatePrice(final String price) {
    if (price.isEmpty) {
      controller.errorTextBookPrice.value =
          S.of(Get.context!).should_not_empty;
      controller.validatorBookPages = false;
    } else {
      final double priceDouble = double.parse(price).toPrecision(1);
      if (priceDouble < 5000 || priceDouble > 100000) {
        controller.validatorBookPrice = false;
      } else {
        controller.validatorBookPrice = true;
      }
    }
  }

  void validatorAutherName(final String authorName) {
    if (authorName.isEmpty) {
      S.of(Get.context!).authername_not_empty;
      controller.validatorBookAuthorName = false;
    } else {
      controller.validatorBookAuthorName = true;
    }
  }

  void validateScore(final String score) {
    if (score.isEmpty) {
      controller.errorTextBookScore.value =
          S.of(Get.context!).score_not_empty;
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
      }
    }
  }

  void _validateBookName(final String bookName) {
    if (bookName.isEmpty) {
      controller.validatorBookName = false;
    } else {
      controller.validatorBookName = true;
    }
  }

  void _validateCountPages(final String pages) {
    if (pages.isEmpty) {
      controller.errorTextBookPages.value =
          S.of(Get.context!).should_not_empty;
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
      controller.validatorBookPublisher = false;
    } else {
      controller.errorTextBookPublisher.value = null;
      controller.validatorBookPublisher = true;
    }
  }
}
