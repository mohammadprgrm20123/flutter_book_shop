import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/controllers/favorite_controller.dart';
import 'package:flutter_booki_shop/custom_widgets/custom_bottomNavigation.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/FavoriteItem.dart';
import 'package:flutter_booki_shop/shareprefrence.dart';
import 'package:flutter_booki_shop/views/details_book/details_book.dart';
import 'package:flutter_booki_shop/views/user_home/user_home.dart';
import 'package:get/get.dart';
@immutable
class Favorite extends StatelessWidget{

  static const int CROSS_AXIS_COUNT =2;
  FavoriteController _favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {

    MySharePrefrence().getId().then((value) {
      _favoriteController.getFavoriteBooks(value);
    });

    return Scaffold(
      appBar: _appBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomBtnNavigation().floatingActionButton(),
      bottomNavigationBar: CustomBtnNavigation().bottomNavigationBar(),
      body: _listBooks()
    );
  }

  Widget _listBooks() {
    return Obx((){
      if(_favoriteController.loading.value==true){
        return Center(child: CircularProgressIndicator());
      }
      else{
        if(_favoriteController.listFavorite.length==0){
          return Center(child: Text(S.of(Get.context).not_exit_cases));
        }
        else{
          return _gridView();
        }
      }
    });


  }

  Widget _gridView() {
    return GridView.builder(
      itemCount: _favoriteController.listFavorite.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: CROSS_AXIS_COUNT),
      itemBuilder: (BuildContext context, int index) {
        return _itemList(_favoriteController.listFavorite.elementAt(index));
      },
    );
  }

  Widget _itemList(FavoriteItem listFavorite) {
    return GestureDetector(
            onTap: (){
              Get.to(DetailsBook(listFavorite.book.id));
            },
            child: _card(listFavorite),
          );
  }

  Widget _card(FavoriteItem item) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        elevation: 10.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _imageBook(item),
            _textBookName(item),
            Row(children:
            [
              Expanded(child: ElevatedButton(onPressed: (){
                _favoriteController.listFavorite.remove(item);
                _favoriteController.removeFavoriteItem(item.id);
              }, child: Text("حذف",overflow: TextOverflow.fade,)))

            ]),

          ],
        ),
      ),
    );
  }

  Widget _textBookName(FavoriteItem listFavorite) {
    return Center(
                  child: Text(
                    listFavorite.book.bookName,
                  ),
                );
  }

  Widget _imageBook(FavoriteItem listFavorite) {
    return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(4.0),
                    child: Image.network(
                      listFavorite.book.url,
                      height: 100,
                      width: 100,
                    ),
                  ),
                );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: _title(context),
      backgroundColor: Colors.white,
      centerTitle: true,
    );
  }

  Widget _title(BuildContext context) {
    return Text(
      S.of(context).favorite,
      style:
      TextStyle(fontFamily: S.of(Get.context).name_font_dana, color: Colors.black, fontSize: 17.0),
    );
  }


}