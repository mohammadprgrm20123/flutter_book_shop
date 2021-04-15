import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/controllers/add_book_controller.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/views/admin_home/admin_home.dart';
import 'package:get/get.dart';
import 'package:tag_editor/tag_editor.dart';

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
      _tags(),
      _btnAddProduct(context)
    ];
  }

  TagEditor _tags() {
    return TagEditor(
      addTags: (tag) {
        _addBookController.listTags.add(tag);
      },
      removeTags: (tag){
        _addBookController.listTags.remove(tag);
      },
    );
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
            if (!validateParameters()) {
              sendRequestAddBook();
              Get.offAll(()=>AdminHome());
            }
            else{
              Get.snackbar(S.of(Get.context).error, S.of(Get.context).not_filled);
            }
          }, child: Obx(() {
            if (_addBookController.loading.value == true) {
              return CircularProgressIndicator();
            } else {
              return Text(S.of(Get.context).add_product);
            }
          }));
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
        child: Obx(() {
          return TextField(
              keyboardType: TextInputType.text,
              onChanged: (publisher) {
                _addBookController.book.publisherName = publisher;
                _validatePublisher(publisher);
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.account_circle),
                  border: OutlineInputBorder(),
                  labelText: S.of(Get.context).publisher,
                  errorText: _addBookController.errorTextBookPublisher.value,
                  hintText: S.of(Get.context).publisher));
        }));
  }

  Widget _countPages() {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          return TextField(
              keyboardType: TextInputType.number,
              onChanged: (pages) {
                _addBookController.book.pages = pages;
                _validateCountPages(pages);
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.pages),
                  border: OutlineInputBorder(),
                  labelText: S.of(Get.context).count_pages,
                  errorText: _addBookController.errorTextBookPages.value,
                  hintText: S.of(Get.context).count_pages));
        }));
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
        child: Obx(() {
          return TextField(
              keyboardType: TextInputType.number,
              onChanged: (score) {
                _addBookController.book.score = double.parse(score).toPrecision(1);
                _validateScore(score);
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.score),
                  border: OutlineInputBorder(),
                  labelText: S.of(Get.context).score,
                  errorText: _addBookController.errorTextBookScore.value,
                  hintText: S.of(Get.context).score));
        }));
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
        child: Obx(() {
          return TextField(
              keyboardType: TextInputType.text,
              onChanged: (authorName) {
                _addBookController.book.autherName = authorName;
                _validatorAutherName(authorName);
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.account_circle),
                  border: OutlineInputBorder(),
                  labelText: S.of(Get.context).author_name,
                  errorText: _addBookController.errorBookAutherName.value,
                  hintText: S.of(Get.context).author_name));
        }));
  }

  Widget _price() {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          return TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (price) {
                _addBookController.book.price = price;
                _validatePrice(price);
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.account_circle),
                  border: OutlineInputBorder(),
                  labelText: S.of(Get.context).price,
                  errorText: _addBookController.errorBookPrice.value,
                  hintText: S.of(Get.context).price));
        }));
  }


  Widget _bookName() {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          return TextField(
              keyboardType: TextInputType.text,
              onChanged: (bookName) {
                _addBookController.book.bookName = bookName;
                _validateBookName(bookName);
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.account_circle),
                  border: OutlineInputBorder(),
                  labelText: S.of(Get.context).book_name,
                  errorText: _addBookController.errorOfBookName.value,
                  hintText: S.of(Get.context).book_name));
        }));
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

  bool validateParameters() {
    if (_addBookController.validatorBookScore &&
        _addBookController.validatorBookPages &&
        _addBookController.validatorBookAuthorName &&
        _addBookController.validatorBookPrice &&
        _addBookController.validatorBookName &&
        _addBookController.validatorBookPublisher
    )
    {
      return false;
    }
    Get.snackbar(S.of(Get.context).error,S.of(Get.context).has_problem_wher_enter_the_info);
    return true;
  }

  void sendRequestAddBook() {
    _addBookController.requestForAddBook(_initBookParameters());
    _addBookController.requestForAddBook(_initBookParameters());
  }

  Book _initBookParameters() {
    List<Tags> listTag=[];
    _addBookController.listTags.forEach((tagItem) {
      listTag.add(Tags(tag: tagItem));
    });
    _addBookController.book.tags = listTag;
    _addBookController.book.category = _addBookController.category.value;
    _addBookController.book.releaseDate = "";
    _addBookController.book.createdAt = "";
    _addBookController.book.url = "";
    return _addBookController.book;
  }

  _validatePrice(String price) {
    if (price.isEmpty) {
      _addBookController.errorBookPrice.value = S.of(Get.context).should_not_empty;
      _addBookController.validatorBookPrice=false;
    } else {
      double priceDouble = double.parse(price).toPrecision(1);
      if (priceDouble < 5000 || priceDouble > 100000) {
        _addBookController.validatorBookPrice=false;
        return _addBookController.errorBookPrice.value =
            S.of(Get.context).price_100000until_5000;

      } else {
        _addBookController.errorBookPrice.value = null;
        _addBookController.validatorBookPrice=true;
      }
    }
  }

  _validatorAutherName(String authorName) {
    if (authorName.isEmpty) {
      _addBookController.errorBookAutherName.value =
          S.of(Get.context).authername_not_empty;
      _addBookController.validatorBookAuthorName=false;
    } else {
      _addBookController.errorBookAutherName.value = null;
      _addBookController.validatorBookAuthorName=true;
    }
  }

  _validateScore(String score) {
    if (score.isEmpty) {
      _addBookController.errorTextBookScore.value = S.of(Get.context).score_not_empty;
      _addBookController.validatorBookScore=false;
    } else {
      double scoreDouble = double.parse(score).toPrecision(1);
      if (scoreDouble > 5 || scoreDouble == 0) {
        _addBookController.errorTextBookScore.value =
            S.of(Get.context).score_betwwen_1_5;
        _addBookController.validatorBookScore=false;
      } else {
        _addBookController.errorTextBookScore.value = null;
        _addBookController.validatorBookScore=true;
      }
    }
  }

  void _validateBookName(String bookName) {
    if (bookName.isEmpty) {
      _addBookController.errorOfBookName.value = S.of(Get.context).bookname_not_empty;
      _addBookController.validatorBookName=false;
    } else {
      _addBookController.errorOfBookName.value = null;
      _addBookController.validatorBookName=true;
    }
  }

  void _validateCountPages(String pages) {
    if (pages.isEmpty) {
      _addBookController.errorTextBookPages.value = S.of(Get.context).should_not_empty;
      _addBookController.validatorBookPages=false;
    } else {
      _addBookController.errorTextBookPages.value = null;
      _addBookController.validatorBookPages=true;
    }
  }

  void _validatePublisher(String publisher) {
    if (publisher.isEmpty) {
      _addBookController.errorTextBookPublisher.value =
          S.of(Get.context).should_not_empty;
      _addBookController.validatorBookPublisher=false;
    } else {
      _addBookController.errorTextBookPublisher.value = null;
      _addBookController.validatorBookPublisher=true;
    }
  }


}
