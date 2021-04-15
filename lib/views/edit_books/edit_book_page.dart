import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/controllers/add_book_controller.dart';
import 'package:flutter_booki_shop/controllers/edit_book_controller.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/views/admin_home/admin_home.dart';
import 'package:get/get.dart';
import 'package:tag_editor/tag_editor.dart';

@immutable
class EditBookPage extends StatelessWidget {
  List<String> spinnerList = [
    S.of(Get.context).category_stoy,
    S.of(Get.context).novel,
    S.of(Get.context).philosophy,
    S.of(Get.context).epic,
    S.of(Get.context).psychology,
  ];
  AddBookController _editBookController = Get.put(AddBookController());
  Book book;
  TextEditingController _bookNameCtr;
  TextEditingController _priceCtr;
  TextEditingController _authorNameCtr;
  TextEditingController _translatorNameCtr;
  TextEditingController _scoreCtr;
  TextEditingController _categoryCtr;
  TextEditingController _pagesCtr;
  TextEditingController _publisherCtr;
  TextEditingController _descBookCtr ;

  EditBookPage(this.book);



  @override
  Widget build(BuildContext context) {
     _bookNameCtr =new TextEditingController();
     _priceCtr =new TextEditingController();
     _authorNameCtr =new TextEditingController();
     _translatorNameCtr =new TextEditingController();
     _scoreCtr =new TextEditingController();
     _categoryCtr =new TextEditingController();
     _pagesCtr =new TextEditingController();
     _publisherCtr =new TextEditingController();
     _descBookCtr =new TextEditingController();
     _initFirstValues(book);

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
      TagEditor(addTags: (tag){
          _editBookController.listTags.add(tag);
      },
        removeTags: (tag){
          _editBookController.listTags.remove(tag);
        },
        firstValueListTag:  _editBookController.listTags,
      ),
      _btnAddProduct(context)
    ];
  }

  Widget _btnAddProduct(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(onPressed: () {
              if (!validateParameters()) {
                sendRequestAddBook();
                Get.offAll(()=>AdminHome());
              }
            }, child: Text(S.of(context).record)
            )));
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
    return Obx((){
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
            controller: _publisherCtr,
            onChanged: (publisher) {
              _editBookController.book.publisherName = publisher;
              _validatePublisher(publisher);
            },
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.account_circle),
                border: OutlineInputBorder(),
                errorText: _editBookController.errorTextBookPublisher.value,
                labelText: S.of(Get.context).publisher,
                hintText: S.of(Get.context).publisher)),
      );
    });
  }

  Widget _countPages() {
    return Obx((){
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
            keyboardType: TextInputType.number,
            controller: _pagesCtr,
            onChanged: (countPages) {
              _editBookController.book.pages = countPages;
              _validateCountPages(countPages);
            },
            decoration: _decorationCountPages(_editBookController.errorTextBookPages.value)),
      );
    });
  }

  InputDecoration _decorationCountPages(String errorText) {
    return InputDecoration(
            prefixIcon: Icon(Icons.pages),
            border: OutlineInputBorder(),
            labelText: S.of(Get.context).count_pages,
            errorText: errorText,
            hintText: S.of(Get.context).count_pages);
  }

  Widget _score() {
    return Obx((){
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
            keyboardType: TextInputType.number,
            controller: _scoreCtr,
            onChanged: (score) {
              _editBookController.book.score = double.parse(score).toPrecision(1);
              _validateScore(score);
            },
            decoration: _decorationScore(_editBookController.errorTextBookScore.value)),
      );
    });
  }

  InputDecoration _decorationScore(String errorText) {
    return InputDecoration(
          //   errorText: _scoreCtr.isEmpty?"لظفا فیلد مورد نظر را پر کنید":null,
            prefixIcon: Icon(Icons.score),
            border: OutlineInputBorder(),
            errorText: errorText,
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
          controller: _authorNameCtr,
          onChanged: (authorName) {
            _editBookController.book.autherName = authorName;
            _validatorAutherName(authorName);
          },
          decoration: _authorDecoration(_editBookController.errorBookAutherName.value)),
    );
  }

  InputDecoration _authorDecoration(String errorText) {
    return InputDecoration(
            prefixIcon: Icon(Icons.account_circle),
            border: OutlineInputBorder(),
            labelText: S.of(Get.context).author_name,
            errorText: errorText,
            hintText: S.of(Get.context).author_name);
  }

  Widget _price() {
    return Obx((){
        return  Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
              keyboardType: TextInputType.number,
              controller: _priceCtr,
              onChanged: (price) {
                _editBookController.book.price = price;
                _validatePrice(price);
              },
              decoration: _decorationPrice(_editBookController.errorBookPrice.value)),
        );
      });

  }

  InputDecoration _decorationPrice(String errorText) {
    return InputDecoration(
            prefixIcon: Icon(Icons.account_circle),
            border: OutlineInputBorder(),
            labelText: S.of(Get.context).price,
            errorText: errorText,
            hintText: S.of(Get.context).price);
  }


  Widget _bookName() {
    return Obx((){
     return Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
            controller: _bookNameCtr,
            onChanged: (bookName) {
              _editBookController.book.bookName = bookName;
              _validateBookName(bookName);
            },
            decoration: _decorationBookName(_editBookController.errorOfBookName.value)),
      );
    });
  }

  InputDecoration _decorationBookName(String errorText) {
    return InputDecoration(
            prefixIcon: Icon(Icons.account_circle),
            border: OutlineInputBorder(),
            labelText: S.of(Get.context).book_name,
            errorText: errorText,
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

  bool validateParameters() {
    if (_editBookController.validatorBookName &&
        _editBookController.validatorBookAuthorName &&
        _editBookController.validatorBookPublisher &&
        _editBookController.validatorBookPrice &&
        _editBookController.validatorBookPages&&
        _editBookController.validatorBookScore
    ) {
      return false;
    }
    else
      {
        Get.snackbar(S.of(Get.context).error, S.of(Get.context).please_fill_parameters);
        return true;
      }
  }

  void sendRequestAddBook() {
    _editBookController.book.tags.clear();
    _editBookController.listTags.forEach((element) {
      _editBookController.book.tags.add(Tags(tag:element));
    });
    _editBookController.editBook(_editBookController.book);
  }
  void _initFirstValues(Book book) {
    _editBookController.book = book;
    _bookNameCtr.text =book.bookName;
    _priceCtr.text =book.price;
    _authorNameCtr.text =book.autherName;
    _translatorNameCtr.text =book.translator;
    _scoreCtr.text =book.score.toString();
    _categoryCtr.text =book.category;
    _pagesCtr.text =book.pages;
    _publisherCtr.text =book.publisherName;
    _descBookCtr.text =book.desc;
    book.tags.forEach((element) {
      _editBookController.listTags.add(element.tag);
    });
    _editBookController.category.value = book.category;
    _validatePublisher(book.publisherName);
    _validateCountPages(book.pages);
    _validateScore(book.score.toString());
    _validatorAutherName(book.autherName);
    _validatePrice(book.price);
    _validateBookName(book.bookName);
  }
  _validatePrice(String price) {
    if (price.isEmpty) {
      _editBookController.errorBookPrice.value = "این مقدار نباید خالی باشد";
      _editBookController.validatorBookPrice=false;
    } else {
      double priceDouble = double.parse(price).toPrecision(1);
      if (priceDouble < 5000 || priceDouble > 100000) {
        _editBookController.validatorBookPrice=false;
        return _editBookController.errorBookPrice.value =
        "قیمت باید از 5000 بیشتر و از 100000 کم تر باشد ";

      } else {
        _editBookController.errorBookPrice.value = null;
        _editBookController.validatorBookPrice=true;
      }
    }
  }

  _validatorAutherName(String authorName) {
    if (authorName.isEmpty) {
      _editBookController.errorBookAutherName.value =
      "نام نویسنده نمیتواند خالی باشد";
      _editBookController.validatorBookAuthorName=false;
    } else {
      _editBookController.errorBookAutherName.value = null;
      _editBookController.validatorBookAuthorName=true;
    }
  }

  _validateScore(String score) {
    if (score.isEmpty) {
      _editBookController.errorTextBookScore.value = "امتیاز نباید خالی باشد";
      _editBookController.validatorBookScore=false;
    } else {
      double scoreDouble = double.parse(score).toPrecision(1);
      if (scoreDouble > 5 || scoreDouble == 0) {
        _editBookController.errorTextBookScore.value =
        "امتیاز باید بین 1 تا 5 باشد ";
        _editBookController.validatorBookScore=false;
      } else {
        _editBookController.errorTextBookScore.value = null;
        _editBookController.validatorBookScore=true;
        _editBookController.book.score=scoreDouble;
      }
    }
  }

  void _validateBookName(String bookName) {
    if (bookName.isEmpty) {
      _editBookController.errorOfBookName.value = "نام کتاب نباید خالی باشد";
      _editBookController.validatorBookName=false;
    } else {
      _editBookController.errorOfBookName.value = null;
      _editBookController.validatorBookName=true;
    }
  }

  void _validateCountPages(String pages) {
    if (pages.isEmpty) {
      _editBookController.errorTextBookPages.value = "این فیلد نباید خالی باشد ";
      _editBookController.validatorBookPages=false;
    } else {
      _editBookController.errorTextBookPages.value = null;
      _editBookController.validatorBookPages=true;
    }
  }

  void _validatePublisher(String publisher) {
    if (publisher.isEmpty) {
      _editBookController.errorTextBookPublisher.value =
      "این فیلد نباید خالی باشد ";
      _editBookController.validatorBookPublisher=false;
    } else {
      _editBookController.errorTextBookPublisher.value = null;
      _editBookController.validatorBookPublisher=true;
    }
  }
}
