import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/controllers/admin_home_controller.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/views/add_book/add_book_page.dart';
import 'package:flutter_booki_shop/views/details_book/details_book.dart';
import 'package:flutter_booki_shop/views/admin_report/admin_report.dart';
import 'package:flutter_booki_shop/views/edit_books/edit_book_page.dart';
import 'package:flutter_booki_shop/views/proflie/profile.dart';
import 'package:get/get.dart';

class AdminHome extends StatelessWidget {
  AdminHomeController _adminHomeController = Get.put(AdminHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Obx(() {
        if (_adminHomeController.loading.value == true) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (_adminHomeController.listAllBooks.length == 0) {
            return Center(child: Text(S.of(Get.context).not_exit_cases));
          } else {
            return _listBooks();
          }
        }
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _floatingActionButton(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _listBooks() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (_, int index) {
              return _listItem(_adminHomeController.listAllBooks[index]);
            },
            itemCount: _adminHomeController.listAllBooks.length,
          ),
        )
      ],
    );
  }

  Widget _listItem(Book book) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () {
          Get.to(() => DetailsBook(book.id));
        },
        child: _card(book),
      ),
    );
  }

  Widget _card(Book book) {
    return Card(
      elevation: 8.0,
      child: Container(
        height: 180.0,
        child: Row(
          children: [_image(book), _otherDetails(book), _btnEdit(book)],
        ),
      ),
    );
  }

  Widget _otherDetails(Book book) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          height: 180.0,
          child: Row(
            children: [
              Expanded(
                child: _bookDetails(book),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bookDetails(Book book) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${book.bookName}"),
        Text("${S.of(Get.context).price} : ${book.price}"),
        Text("${S.of(Get.context).author_name} : ${_getBookName(book)}"),
        Text("${S.of(Get.context).category} : ${book.category}"),
        Text("${S.of(Get.context).score} : ${book.score}"),
      ],
    );
  }

  String _getBookName(Book book) {
    return book.autherName;
  }

  Widget _image(Book book) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _cardImage(book),
    );
  }

  Widget _cardImage(Book book) {
    return Card(
      elevation: 7.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FadeInImage.assetNetwork(
              fadeInCurve: Curves.linearToEaseOut,
              image: "${book.url}",
              placeholder: 'assets/images/noImage.jpg',
              height: 120.0,
              width: 80.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _btnEdit(Book book) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
            onPressed: () {
              Get.to(() => EditBookPage(book)).then((value) {
                _adminHomeController.getAllBooks();
              });
            },
            icon: Icon(Icons.edit),
            label: Text(S.of(Get.context).edit))
      ],
    );
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
    return Text(S.of(Get.context).managment,
        style: TextStyle(
            fontFamily: S.of(Get.context).name_font_dana,
            color: Colors.black,
            fontSize: 17.0));
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Get.to(() => AddBookPage()).then((value) {
          _adminHomeController.getAllBooks();
        });
      },
      child: Icon(Icons.add),
    );
  }

  AnimatedBottomNavigationBar _bottomNavigationBar() {
    return AnimatedBottomNavigationBar(
        activeIndex: null,
        icons: [
          Icons.insert_chart,
          Icons.account_circle,
        ],
        elevation: 20.0,
        backgroundColor: Colors.white,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        splashRadius: 10.0,
        activeColor: Colors.blue,
        onTap: (int index) {
          switch (index) {
            case 0:
              {
                Get.to(() => AdminReport()).then((value) {
                  _adminHomeController.getAllBooks();
                });
              }
              break;

            case 1:
              {
                Get.to(() => Profile());
              }
              break;
          }
        });
  }
}
