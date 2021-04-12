import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/controllers/add_book_controller.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/views/admin_home/admin_home.dart';
import 'package:get/get.dart';

@immutable
class AddBookPage extends StatelessWidget {
  List<String> spinnerList = [
    S.of(Get.context).category_stoy,
    S.of(Get.context).novel,
    S.of(Get.context).philosophy,
    S.of(Get.context).epic,
    S.of(Get.context).psychology,
  ];
  


  AddBookController _addBookController = Get.put(AddBookController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: _listWidget(context),
        ),
      ),
    );
  }

  List<Widget> _listWidget(BuildContext context) {
    return [
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
      _firstTag(),
      _secondTag(),
      _thirdTag(),
      _forthTag(),
      _btnAddProduct(context)
    ];
  }

  SizedBox _btnAddProduct(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: _elevatedButton()));
  }

  ElevatedButton _elevatedButton() {
    return ElevatedButton(onPressed: () {
            if (!checkEmpty()) {
              sendRequestAddBook();
              Get.offAll(()=>AdminHome());
            }
          }, child: Obx(() {
            if (_addBookController.loading.value == true) {
              return CircularProgressIndicator();
            } else {
              return Text(S.of(Get.context).add_product);
            }
          }));
  }

  Widget _forthTag() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
          onChanged: (tag4) {
            _addBookController.tag4 = tag4;
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.tag),
              border: OutlineInputBorder(),
              labelText: S.of(Get.context).forth_tag,
              hintText: S.of(Get.context).forth_tag)),
    );
  }

  Widget _thirdTag() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
          onChanged: (tag3) {
            _addBookController.tag3 = tag3;
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.tag),
              border: OutlineInputBorder(),
              labelText: S.of(Get.context).third_tag,
              hintText: S.of(Get.context).third_tag)),
    );
  }

  Widget _secondTag() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
          onChanged: (tag2) {
            _addBookController.tag2 = tag2;
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.tag),
              border: OutlineInputBorder(),
              labelText: S.of(Get.context).second_tag,
              hintText: S.of(Get.context).second_tag)),
    );
  }

  Widget _firstTag() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
          onChanged: (tag1) {
            _addBookController.tag1 = tag1;
            _addBookController.tag0 = tag1;
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.tag),
              border: OutlineInputBorder(),
              labelText: S.of(Get.context).firstTag,
              hintText: S.of(Get.context).firstTag)),
    );
  }

  Widget _summeryOfBook() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
          keyboardType: TextInputType.text,
          onChanged: (summery) {
            _addBookController.book.desc = summery;
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.description),
              border: OutlineInputBorder(),
              labelText: S.of(Get.context).summery_of_book,
              hintText: S.of(Get.context).summery_of_book)),
    );
  }

  Widget _publisher() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
          keyboardType: TextInputType.text,
          onChanged: (publisher) {
            _addBookController.book.publisherName = publisher;
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_circle),
              border: OutlineInputBorder(),
              labelText: S.of(Get.context).publisher,
              hintText: S.of(Get.context).publisher)),
    );
  }

  Widget _countPages() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
          keyboardType: TextInputType.number,
          onChanged: (publisher) {
            _addBookController.book.pages = publisher;
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.pages),
              border: OutlineInputBorder(),
              labelText: S.of(Get.context).count_pages,
              hintText: S.of(Get.context).count_pages)),
    );
  }

  Widget _category(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Obx(() {
          return _dropdownButton();
        }),
      ),
    );
  }

  DropdownButton<String> _dropdownButton() {
    return DropdownButton<String>(
          value: _addBookController.category.value,
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontFamily: S.of(Get.context).name_font_dana),
          underline: Container(
            height: 2,
            color: Colors.blue,
          ),
          onChanged: (String data) {
            _addBookController.category.value = data;
            _addBookController.book.category = data;
          },
          items: spinnerList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        );
  }

  Widget _score() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
          keyboardType: TextInputType.number,
          onChanged: (score) {
            _addBookController.book.score = double.parse(score);
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.score),
              border: OutlineInputBorder(),
              labelText: S.of(Get.context).score,
              hintText: S.of(Get.context).score )),
    );
  }

  Widget _translatorName() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
          keyboardType: TextInputType.text,
          onChanged: (translator) {
            _addBookController.book.translator = translator;
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.translate),
              border: OutlineInputBorder(),
              labelText: S.of(Get.context).translator_name,
              hintText: S.of(Get.context).translator_name)),
    );
  }

  Widget _authorName() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
          keyboardType: TextInputType.text,
          onChanged: (authorName) {
            _addBookController.book.authorName = authorName;
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_circle),
              border: OutlineInputBorder(),
              labelText: S.of(Get.context).author_name,
              hintText: S.of(Get.context).author_name)),
    );
  }

  Widget _price() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
          keyboardType: TextInputType.number,
          onChanged: (price) {
            _addBookController.book.price = price;
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_circle),
              border: OutlineInputBorder(),
              labelText: S.of(Get.context).price,
              hintText: S.of(Get.context).price)),
    );
  }


  Widget _bookName() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        keyboardType: TextInputType.text,
          onChanged: (bookName) {
            _addBookController.book.bookName = bookName;
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_circle),
              border: OutlineInputBorder(),
              labelText: S.of(Get.context).book_name,
              hintText: S.of(Get.context).book_name)),
    );
  }

  Padding _image() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
          height: 120.0,
          width: 120.0,
          child: CircleAvatar(
              child: Icon(
            Icons.camera_alt,
            size: 45.0,
          ))),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: _titile(context),
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
    );
  }

  Text _titile(BuildContext context) {
    return Text(S.of(Get.context).add_product,
        style:
            TextStyle(fontFamily: S.of(Get.context).name_font_dana, color: Colors.black, fontSize: 17.0));
  }

  bool checkEmpty() {
    if (_addBookController.book.bookName.isEmpty ||
        _addBookController.book.authorName.isEmpty ||
        _addBookController.book.translator.isEmpty ||
        _addBookController.book.pages.isEmpty ||
        _addBookController.book.desc.isEmpty) {
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).please_fill_parameters);
      return true;
    }
    return false;
  }

  void sendRequestAddBook() {
    _addBookController.requestForAddBook(_initBookParameters());
  }

  Book _initBookParameters() {
    _addBookController.book.tags = _initTagParameters();
    _addBookController.book.category = "رمان";
    _addBookController.book.releaseDate = "";
    _addBookController.book.createdAt = "";
    _addBookController.book.url = "";
    return _addBookController.book;
  }

  Tags _initTagParameters() {
    Tags tags = new Tags(
        tag0: _addBookController.tag0,
        tag1: _addBookController.tag1,
        tag2: _addBookController.tag2,
        tag3: _addBookController.tag3,
        tag4: _addBookController.tag4);
    return tags;
  }
}
