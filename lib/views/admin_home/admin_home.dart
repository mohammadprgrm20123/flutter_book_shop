
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/controllers/admin_home_controller.dart';
import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/views/addBook/add_book_page.dart';
import 'package:flutter_booki_shop/views/admin_report.dart';
import 'package:flutter_booki_shop/views/editbook/edit_book_page.dart';
import 'package:get/get.dart';

class AdminHome extends StatelessWidget{


  AdminHomeController _adminHomeController =Get.put(AdminHomeController());





  @override
  Widget build(BuildContext context) {
    print("build");
    // TODO: implement build
    return Scaffold(
        appBar: _appBar(context),
        body: Obx((){
          if(_adminHomeController.loading.value==true){
            return Center(child: CircularProgressIndicator());
          }
          else{
            if(_adminHomeController.listAllBooks.length==0){
              return Center(child: Text("موردی وجود ندارد"));
            }else{
              return _listBooks();
            }
          }
        }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _floatingActionButton(),
      bottomNavigationBar: _bottomNavigationBar(),

    );
    throw UnimplementedError();
  }

  Column _listBooks() {
    return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, int index) {
                return  _listItem(_adminHomeController.listAllBooks[index]);
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
      child: Card(
        elevation: 8.0,
        child: Container(
          height: 180.0,
          child: Row(
            children: [_image(book), _nameAndPrice(book), _btnEdit(book)],
          ),
        ),
      ),
    );
  }

  Widget _nameAndPrice(Book book) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          height: 180.0,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${book.bookName}"),
                    Text("قیمت : ${book.price}"),
                    Text("نویسنده : ${_getBookName(book)}"),
                    Text("دسته بندی : ${book.category}"),
                    Text("امتیاز : ${book.score}"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getBookName(Book book) {
   /* if(book.autherName.length>14){
      return book.autherName.substring(0,14);
    }*/
  return book.autherName;
  }

  Widget _image(Book book) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 7.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  //Get.to(()=>DetailsBook(_homeController.listPopularBook[index].id));
                },
                child: FadeInImage.assetNetwork(
                  fadeInCurve: Curves.linearToEaseOut,
                  image: "${book.url}",
                  placeholder: "assets/images/noImage.jpg",

                  height: 120.0,
                  width: 80.0,
                ),
              ),
            ],
          ),
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
              Get.to(()=>EditBookPage(book));
            }, icon: Icon(Icons.edit),label: Text("ویرایش"))
      ],
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
    return Text("مدیریت",
        style:
            TextStyle(fontFamily: 'Dana', color: Colors.black, fontSize: 17.0));
  }



  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      onPressed: (){
        Get.to(()=>AddBookPage());
      },
      child: Icon(Icons.add),
    );
  }
  AnimatedBottomNavigationBar _bottomNavigationBar() {
    return AnimatedBottomNavigationBar(
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
          switch(index){
            case 0:{
              Get.to(()=>AdminReport());
            }break;

            case 1:{
            }break;

          }
        });
  }
}