import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/controllers/details_controller.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class DetailsBook extends StatelessWidget {

  final int _bookId;


  DetailController _detailController = Get.put(DetailController());

  DetailsBook(this._bookId);

  @override
  Widget build(BuildContext context) {
    _detailController.getDeatilsBook(_bookId);
    return Scaffold(
      appBar: _appBar(context),
      body: _scrollView(context),
    );
  }

  SingleChildScrollView _scrollView(BuildContext context) {
    return SingleChildScrollView(
      child: _detailsOfBooks(context),
    );
  }

  Widget _detailsOfBooks(BuildContext context) {
    return Obx((){
      if(_detailController.loading.value==true){
        return Center(child: CircularProgressIndicator());
      }
      else{
      return  Column(
          children: [
            _image(_detailController.book.url),
            _bookName(_detailController.book.bookName),
            _autherName(_detailController.book.autherName,_detailController.book.translator),
            _score(_detailController.book.score),
            _btnAddToShop(context,_detailController.book.price),
            _btnAddFavorite(context),
            _divider(),
            _introduction(context),
            _description(context,_detailController.book.desc),
            _dividerThikness10(),
            _otherPropertiesOfBook(_detailController.book),
            _dividerThikness10(),
            _listTags(_detailController.book.tags)
          ],
        );
      }
    });
  }

  Wrap _listTags(Tags tags) {
    return Wrap(
              direction: Axis.horizontal,
              children:[
                 _itemTag(tags.tag0),
                 _itemTag(tags.tag1),
                 _itemTag(tags.tag2),
                 _itemTag(tags.tag3),
                 _itemTag(tags.tag4)
                 ]
            );
  }

  Container _itemTag(String tag) {
    return Container(
                margin: const EdgeInsets.only(right: 8.0, bottom: 15.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(tag,style: TextStyle(color: Colors.white),),
                ),
              );
  }

  SingleChildScrollView _otherPropertiesOfBook(Book book) {
    return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _category(book.category),
                  _price(book.price),
                  _publisher(book.publisherName),
                  _coutPages(book.pages),
                ],
              ),
            );
  }

  Padding _coutPages(String countPage) {
    return Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Column(

                            children: [
                              Text('تعداد صفحات'),
                              Text(countPage,style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
  }

  Card _publisher(String pulisher) {
    return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Text('ناشر'),
                        Text(pulisher,style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                );
  }

  Card _price(String price) {
    return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Text('قیمت'),
                        Text(price,style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                );
  }

  Padding _category(String catagory) {
    return Padding(
                  padding: const EdgeInsets.only(right:8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Text('دسته بندی'),
                          Text(catagory,style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ),
                );
  }

  Divider _dividerThikness10() {
    return Divider(
              height: 10.0,
              thickness: 1.0,
              color: Colors.black,
            );
  }

  Padding _description(BuildContext context, String desc) {
    return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(desc,style: TextStyle(fontSize: 13.0,color: Colors.black45)),
            );
  }

  Align _introduction(BuildContext context) {
    return Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(S.of(context).book_introduction,style: TextStyle(fontWeight: FontWeight.bold)),
                ));
  }

  Padding _divider() {
    return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 20.0),
              child: Divider(
                thickness: 1.0,
                color: Colors.black12,
              ),
            );
  }

  Padding _btnAddFavorite(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.symmetric(horizontal:30.0,vertical: 10.0),
              child: SizedBox(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                child: OutlineButton(
                    child: new Text(S.of(context).add_to_favorite),
                    onPressed: null,
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(4.0))
                ),
              ),
            );
  }

  Padding _btnAddToShop(BuildContext context, String price) {
    return Padding(
              padding: const EdgeInsets.symmetric(horizontal:30.0),
              child: SizedBox(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(onPressed: (){},
                      child: Text('اضافه کردن به سبد خرید    $price تومان '),
                  )),
            );
  }

  Row _score(double score) {
    return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IconButton(
                  icon: Icon(
                    Icons.share_outlined,
                    size: 30.0,
                  ),
                  onPressed: () {}),
                ),
                Expanded(child: Text('$score/5',textAlign: TextAlign.end,style: TextStyle(fontSize: 14.0),)),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RatingBar.builder(
                    initialRating: score,
                    minRating: 1,
                    wrapAlignment: WrapAlignment.start,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 20.0,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    )
                  ),
                ),
              ],
            );
  }

  Padding _autherName(String autherName, String translator) {
    return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                '$autherName/$translator',
                style: TextStyle(color: Colors.black38, fontSize: 14.0),
              ),
            );
  }

  Padding _bookName(String bookName) {
    return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                bookName,
                style:
                    TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
            );
  }

  Center _image(String url) {
    return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Card(
                  elevation: 10.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: FadeInImage.assetNetwork(
                      fadeInCurve: Curves.bounceIn,
                      height: 240.0,
                      image:
                          url,
                      placeholder: 'assets/images/1.jpg',
                    ),
                  ),
                ),
              ),
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
    return Text(S.of(context).details,
        style: TextStyle(
            fontFamily: 'Dana', color: Colors.black, fontSize: 17.0));
  }
}
