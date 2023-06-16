import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/admin_home_controller.dart';
import '../../generated/l10n.dart';
import '../../models/book_view_model.dart';
import '../add_book/add_book_page.dart';
import '../admin_report/admin_report.dart';
import '../details_book/details_book.dart';
import '../edit_books/edit_book_page.dart';
import '../proflie/profile.dart';

class AdminHomePage extends StatelessWidget {
  final adminHomeController = Get.put(AdminHomeController());

  @override
  Widget build(final BuildContext context) {

    adminHomeController.listAllBooks.clear();
    adminHomeController.getAllBooks();

    return Scaffold(
      appBar: _appBar(context),
      body: Obx(() {
        if (adminHomeController.loading.value == true) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (adminHomeController.listAllBooks.isEmpty) {
            return Center(child: Text(S
                .of(Get.context!)
                .not_exit_cases));
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

    Widget _listBooks() => Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (final _, final index) =>
                _listItem(adminHomeController.listAllBooks[index]),
            itemCount: adminHomeController.listAllBooks.length,
          ),
        )
      ],
    );

    Widget _listItem(final BookViewModel book) => Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () {
          Get.to(() => DetailsBook(bookId: book.id!));
        },
        child: _card(book),
      ),
    );

    Widget _card(final BookViewModel book) => Card(
      elevation: 8.0,
      child: Container(
        height: 180.0,
        child: Row(
          children: [_image(book), _otherDetails(book), _btnEdit(book)],
        ),
      ),
    );

    Widget _otherDetails(final BookViewModel book) => Expanded(
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

    Widget _bookDetails(final BookViewModel book) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(book.bookName!),
        Text('${S.of(Get.context!).price} : ${book.price}'),
        Text('${S.of(Get.context!).author_name} : ${_getBookName(book)}'),
        Text('${S.of(Get.context!).category} : ${book.category}'),
        Text('${S.of(Get.context!).score} : ${book.score}'),
      ],
    );

    String _getBookName(final BookViewModel book) => book.autherName!;

    Widget _image(final BookViewModel book) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: _cardImage(book),
    );

    Widget _cardImage(final BookViewModel book) => Card(
      elevation: 7.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FadeInImage.assetNetwork(
          fadeInCurve: Curves.linearToEaseOut,
          image: book.url!,
          placeholder: 'assets/images/noImage.jpg',
          height: 120.0,
          width: 80.0,
        ),
      ),
    );

    Widget _btnEdit(final BookViewModel book) => Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
            onPressed: () {
              Get.to(() => EditBookPage(book))!.then((final value) {
                adminHomeController.getAllBooks();
              });
            },
            icon: const Icon(Icons.edit),
            label: Text(S.of(Get.context!).edit))
      ],
    );

    AppBar _appBar(final BuildContext context) => AppBar(
      backgroundColor: Colors.white,
      title: _title(context),
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.black),
    );

    Widget _title(final BuildContext context) => Text(S.of(Get.context!).managment,
        style: TextStyle(
            fontFamily: S.of(Get.context!).name_font_dana,
            color: Colors.black,
            fontSize: 17.0));

    FloatingActionButton _floatingActionButton() => FloatingActionButton(
      onPressed: () {
        Get.to(() => AddBookPage())!.then((final value) {
          adminHomeController.getAllBooks();
        });
      },
      child: const Icon(Icons.add),
    );

    AnimatedBottomNavigationBar _bottomNavigationBar() =>
        AnimatedBottomNavigationBar(
            activeIndex: 2,
            icons: const [
              Icons.insert_chart,
              Icons.account_circle,
            ],
            elevation: 20.0,
            backgroundColor: Colors.white,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.softEdge,
            splashRadius: 10.0,
            activeColor: Colors.blue,
            onTap: (final index) {
              switch (index) {
                case 0:
                  {
                    Get.to(() => AdminReport())!.then((final value) {
                      adminHomeController.getAllBooks();
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

