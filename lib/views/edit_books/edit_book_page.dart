import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/controllers/edit_book_controller.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/views/admin_home/admin_home.dart';
import 'package:get/get.dart';


class EditBookPage extends StatelessWidget {
  List<String> spinnerList = [
    S.of(Get.context).category_stoy,
    S.of(Get.context).novel,
    S.of(Get.context).philosophy,
    S.of(Get.context).epic,
    S.of(Get.context).psychology,
  ];
  EditBookController _editBookController = Get.put(EditBookController());

  TextEditingController _bookNameCtr =new TextEditingController();
  TextEditingController _priceCtr =new TextEditingController();
  TextEditingController _autherNameCtr =new TextEditingController();
  TextEditingController _translatorNameCtr =new TextEditingController();
  TextEditingController _scoreCtr =new TextEditingController();
  TextEditingController _categoryCtr =new TextEditingController();
  TextEditingController _pagesCtr =new TextEditingController();
  TextEditingController _publisherCtr =new TextEditingController();
  TextEditingController _descBookCtr =new TextEditingController();
  TextEditingController _tag1BookCtr =new TextEditingController();
  TextEditingController _tag2BookCtr =new TextEditingController();
  TextEditingController _tag3BookCtr =new TextEditingController();
  TextEditingController _tag4BookCtr =new TextEditingController();

  EditBookPage(Book book){
    _initFirstValues(book);
  }

  void _initFirstValues(Book book) {
    _editBookController.book = book;
    _bookNameCtr.text =book.bookName;
    _priceCtr.text =book.price;
    _autherNameCtr.text =book.autherName;
    _translatorNameCtr.text =book.translator;
    _scoreCtr.text =book.score.toString();
    _categoryCtr.text =book.category;
    _pagesCtr.text =book.pages;
    _publisherCtr.text =book.publisherName;
    _descBookCtr.text =book.desc;
    _tag1BookCtr.text =book.tags.tag1;
    _tag2BookCtr.text =book.tags.tag2;
    _tag3BookCtr.text =book.tags.tag3;
    _tag4BookCtr.text =book.tags.tag4;
    _editBookController.category.value = book.category;
  }

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
      _bookName(),
      _price(),
      _authorName(),
      _translatorName(),
      _score(),
      _countPages(),
      _publisher(),
      _descOfBook(),
      _firstTag(),
      _secondTag(),
      _thirdTag(),
      _forthTag(),
      _btnAddProduct(context)
    ];
  }

  Widget _btnAddProduct(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(onPressed: () {
              if (!checkEmpty()) {
                sendRequestAddBook();
                Get.offAll(()=>AdminHome());
              }
            }, child: Text(S.of(context).record)
            )));
  }

  Widget _forthTag() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: _tag4BookCtr,
          onChanged: (tag4) {
            _editBookController.book.tags.tag4=tag4;
          },
          decoration: _decorationForthTag()),
    );
  }

  InputDecoration _decorationForthTag() {
    return InputDecoration(
            prefixIcon: Icon(Icons.tag),
            border: OutlineInputBorder(),
            labelText: S.of(Get.context).forth_tag,
            hintText: S.of(Get.context).forth_tag);
  }

  Widget _thirdTag() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
          controller: _tag3BookCtr,
          onChanged: (tag3) {
            _editBookController.book.tags.tag3=tag3;
          },
          decoration: _decorationThirdTag()),
    );
  }

  InputDecoration _decorationThirdTag() {
    return InputDecoration(
            prefixIcon: Icon(Icons.tag),
            border: OutlineInputBorder(),
            labelText: S.of(Get.context).third_tag,
            hintText: S.of(Get.context).third_tag);
  }

  Widget _secondTag() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
          controller: _tag2BookCtr,
          onChanged: (tag2) {
            _editBookController.book.tags.tag2=tag2;
          },
          decoration: _decorationSecondTag()),
    );
  }

  InputDecoration _decorationSecondTag() {
    return InputDecoration(
            prefixIcon: Icon(Icons.tag),
            border: OutlineInputBorder(),
            labelText: S.of(Get.context).second_tag,
            hintText: S.of(Get.context).second_tag);
  }

  Widget _firstTag() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
          controller: _tag1BookCtr,
          onChanged: (tag1) {
            _editBookController.book.tags.tag1=tag1;
          },
          decoration: _decorationFirstTag()),
    );
  }

  InputDecoration _decorationFirstTag() {
    return InputDecoration(
            prefixIcon: Icon(Icons.tag),
            border: OutlineInputBorder(),
            labelText: S.of(Get.context).firstTag,
            hintText: S.of(Get.context).firstTag);
  }

  Widget _descOfBook() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        maxLines: 3,
          controller: _descBookCtr,
          onChanged: (summery) {
            _editBookController.book.desc = summery;
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
        controller: _publisherCtr,
          onChanged: (publisher) {
            _editBookController.book.publisherName = publisher;
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
          controller: _pagesCtr,
          onChanged: (countPages) {
            _editBookController.book.pages = countPages;
          },
          decoration: _decorationCountPages()),
    );
  }

  InputDecoration _decorationCountPages() {
    return InputDecoration(
            prefixIcon: Icon(Icons.pages),
            border: OutlineInputBorder(),
            labelText: S.of(Get.context).count_pages,
            hintText: S.of(Get.context).count_pages);
  }

  Widget _score() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
          controller: _scoreCtr,
          onChanged: (score) {
            _editBookController.book.score = double.parse(score).roundToDouble();
          },
          decoration: _decorationScore()),
    );
  }

  InputDecoration _decorationScore() {
    return InputDecoration(
          //   errorText: _scoreCtr.isEmpty?"لظفا فیلد مورد نظر را پر کنید":null,
            prefixIcon: Icon(Icons.score),
            border: OutlineInputBorder(),
            labelText: 'امتیاز',
            hintText: 'امتیاز');
  }

  Widget _translatorName() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
          controller: _translatorNameCtr,
          onChanged: (translator) {
            _editBookController.book.translator = translator;
          },
          decoration: _decorationTranslatorName()),
    );
  }

  InputDecoration _decorationTranslatorName() {
    return InputDecoration(
            prefixIcon: Icon(Icons.translate),
            border: OutlineInputBorder(),
            labelText: S.of(Get.context).translator_name,
            hintText: S.of(Get.context).translator_name);
  }

  Widget _authorName() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
          controller: _autherNameCtr,
          onChanged: (autherName) {
            _editBookController.book.autherName = autherName;
          },
          decoration: _autherDecoration()),
    );
  }

  InputDecoration _autherDecoration() {
    return InputDecoration(
            prefixIcon: Icon(Icons.account_circle),
            border: OutlineInputBorder(),
            labelText: S.of(Get.context).auther_name,
            hintText: S.of(Get.context).auther_name);
  }

  Widget _price() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: _priceCtr,
          onChanged: (price) {
            _editBookController.book.price = price;
          },
          decoration: _decorationPrice()),
    );
  }

  InputDecoration _decorationPrice() {
    return InputDecoration(
            prefixIcon: Icon(Icons.account_circle),
            border: OutlineInputBorder(),
            labelText: S.of(Get.context).price,
            hintText: S.of(Get.context).price);
  }


  Widget _bookName() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: _bookNameCtr,
          onChanged: (bookName) {
            _editBookController.book.bookName = bookName;
          },
          decoration: _decorationBookName()),
    );
  }

  InputDecoration _decorationBookName() {
    return InputDecoration(
            prefixIcon: Icon(Icons.account_circle),
            border: OutlineInputBorder(),
            labelText: S.of(Get.context).book_name,
            hintText: S.of(Get.context).book_name);
  }


  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: _title(context),
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
    );
  }

  Widget _title(BuildContext context) {
    return Text(S.of(Get.context).edit_product,
        style:
        TextStyle(fontFamily: S.of(Get.context).name_font_dana, color: Colors.black, fontSize: 17.0));
  }

  bool checkEmpty() {
    if (_editBookController.book.bookName.isEmpty ||
        _editBookController.book.autherName.isEmpty ||
        _editBookController.book.translator.isEmpty ||
        _editBookController.book.pages.isEmpty ||
        _editBookController.book.desc.isEmpty) {
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).please_fill_parameters);
      return true;
    }
    return false;
  }

  void sendRequestAddBook() {
    _editBookController.requestForEditBook(_editBookController.book);
  }
  
}
