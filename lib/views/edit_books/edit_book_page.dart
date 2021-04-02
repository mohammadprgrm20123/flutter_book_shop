import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/controllers/add_book_controller.dart';
import 'package:flutter_booki_shop/controllers/edit_book_controller.dart';
import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/views/admin_home/admin_home.dart';
import 'package:get/get.dart';

class EditBookPage extends StatelessWidget {
  List<String> spinnerList = [
    "داستانی",
    "رمان",
    "فلسفه",
    "حماسی",
    "روانشناسی",
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
    print(book.id.toString());
    _editBookController.book = book;
    print(_editBookController.book.category);
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
     // _category(context),
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

  SizedBox _btnAddProduct(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(onPressed: () {
              if (!checkEmpty()) {
                sendRequestAddBook();
                Get.offAll(()=>AdminHome());
              }
              // _addBookController.requestForAddBook();
            }, child: Text("ثبت")


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
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.tag),
              border: OutlineInputBorder(),
              labelText: 'تگ چهارم',
              // errorText: _forthTagCtr.isEmpty?"لظفا فیلد مورد نظر را پر کنید":null,
              hintText: 'تگ چهارم ')),
    );
  }

  Widget _thirdTag() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
          controller: _tag3BookCtr,
          onChanged: (tag3) {
            _editBookController.book.tags.tag3=tag3;
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.tag),
              border: OutlineInputBorder(),
              //  errorText: _thirdTagCtr.isEmpty?"لظفا فیلد مورد نظر را پر کنید":null,
              labelText: 'تگ سوم',
              hintText: 'تگ سوم ')),
    );
  }

  Widget _secondTag() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
          controller: _tag2BookCtr,
          onChanged: (tag2) {
            _editBookController.book.tags.tag2=tag2;
          },
          decoration: InputDecoration(
            //  errorText: _secondTagCtr.isEmpty?"لظفا فیلد مورد نظر را پر کنید":null,
              prefixIcon: Icon(Icons.tag),
              border: OutlineInputBorder(),
              labelText: 'تگ دوم',
              hintText: 'تگ دوم ')),
    );
  }

  Widget _firstTag() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
          controller: _tag1BookCtr,
          onChanged: (tag1) {
            _editBookController.book.tags.tag1=tag1;
          },
          decoration: InputDecoration(
            //errorText: _firstTagCtr.isEmpty?"لظفا فیلد مورد نظر را پر کنید":null,
              prefixIcon: Icon(Icons.tag),
              border: OutlineInputBorder(),
              labelText: 'تگ اول',
              hintText: 'تگ اول')),
    );
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
            //errorText: _summeryCtr.isEmpty?"لظفا فیلد مورد نظر را پر کنید":null,
              prefixIcon: Icon(Icons.description),
              border: OutlineInputBorder(),
              labelText: 'خلاصه کتاب',
              hintText: 'خلاصه کتاب')),
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
            //  errorText: _publisherCtr.isEmpty?"لظفا فیلد مورد نظر را پر کنید":null,
              prefixIcon: Icon(Icons.account_circle),
              border: OutlineInputBorder(),
              labelText: 'ناشر',
              hintText: 'ناشر')),
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
          decoration: InputDecoration(
            //  errorText: _countPageCtr.isEmpty?"لظفا فیلد مورد نظر را پر کنید":null,
              prefixIcon: Icon(Icons.pages),
              border: OutlineInputBorder(),
              labelText: 'تعداد صفحات',
              hintText: 'تعداد صفحات')),
    );
  }

  Widget _category(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Obx(() {
          return DropdownButton<String>(
            value: _editBookController.category.value,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontFamily: 'Dana'),
            underline: Container(
              height: 2,
              color: Colors.blue,
            ),
            onChanged: (String data) {
              _editBookController.category.value = data;
              _editBookController.book.category = data;
            },
            items: spinnerList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          );
        }),
      ),
    );
  }

  Widget _score() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
          controller: _scoreCtr,
          onChanged: (score) {
            _editBookController.book.score = double.parse(score).roundToDouble();
          },
          decoration: InputDecoration(
            //   errorText: _scoreCtr.isEmpty?"لظفا فیلد مورد نظر را پر کنید":null,
              prefixIcon: Icon(Icons.score),
              border: OutlineInputBorder(),
              labelText: 'امتیاز',
              hintText: 'امتیاز')),
    );
  }

  Widget _translatorName() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
          controller: _translatorNameCtr,
          onChanged: (translator) {
            _editBookController.book.translator = translator;
          },
          decoration: InputDecoration(
            //  errorText: _translatorCtr.isEmpty?"لظفا فیلد مورد نظر را پر کنید":null,
              prefixIcon: Icon(Icons.translate),
              border: OutlineInputBorder(),
              labelText: 'نام مترجم',
              hintText: 'نام مترجم')),
    );
  }

  Widget _authorName() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
          controller: _autherNameCtr,
          onChanged: (autherName) {
            _editBookController.book.autherName = autherName;
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_circle),
              border: OutlineInputBorder(),
              labelText: 'نام نویسنده',
              hintText: 'نام نویسنده')),
    );
  }

  Widget _price() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: _priceCtr,
          onChanged: (price) {
            _editBookController.book.price = price;
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_circle),
              border: OutlineInputBorder(),
              labelText: 'قیمت',
              hintText: 'قیمت')),
    );
  }


  Widget _bookName() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: _bookNameCtr,
          onChanged: (bookName) {
            _editBookController.book.bookName = bookName;
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_circle),
              border: OutlineInputBorder(),
              labelText: 'نام کتاب',
              hintText: 'نام کتاب')),
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
    return Text("ویرایش محصول",
        style:
        TextStyle(fontFamily: 'Dana', color: Colors.black, fontSize: 17.0));
  }

  bool checkEmpty() {
    if (_editBookController.book.bookName.isEmpty ||
        _editBookController.book.autherName.isEmpty ||
        _editBookController.book.translator.isEmpty ||
        _editBookController.book.pages.isEmpty ||
        _editBookController.book.desc.isEmpty) {
      Get.snackbar("خطا", "لطفا فیلد ها رو به صورت کامل پر کنید");
      return true;
    }
    return false;
  }

  void sendRequestAddBook() {
    _editBookController.requestForEditBook(_editBookController.book);
  }

  Book _initBookParameters() {
   // _addBookController.book.tags = _initTagParameters();
  //  return _addBookController.book;
  }

  Tags _initTagParameters() {
    /*Tags tags = new Tags(
        tag0: _tag0.value,
        tag1: _tag1.value,
        tag2: _tag2.value,
        tag3: _tag3.value,
        tag4: _tag4.value);
    return tags;*/
  }
}
