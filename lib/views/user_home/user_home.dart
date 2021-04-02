import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/controllers/home_controller.dart';
import 'package:flutter_booki_shop/custom_widgets/custom_bottomNavigation.dart';
import 'package:flutter_booki_shop/custom_widgets/horisental_card_pager.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/views/details_book/details_book.dart';
import 'package:get/get.dart';

@immutable
class UserHome extends GetView<HomeController> {
  HomeController _homeController = Get.put(HomeController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _scrollView(context),
      floatingActionButton: CustomBtnNavigation().floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBtnNavigation().bottomNavigationBar(),
    );
  }

  SingleChildScrollView _scrollView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _bannerList(context),
          _circleIndicator(),
          _theBestBooksList(context),
          _theMostPopularBooksList(context),
          _audioBooksList(context),
        ],
      ),
    );
  }




  Container _audioBooksList(BuildContext context) {
    return Container(
      decoration: _backgroundBoxDecoration(),
      child: Column(
        children: [
          _titleOfList(context,S.of(context).audio_books),
          _listAudioBooks(),
        ],
      ),
    );
  }

  BoxDecoration _backgroundBoxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white,
          Colors.white38,
          Colors.black12,
        ],
      ),
    );
  }

  Text _textMore(BuildContext context) => Text(S.of(context).more);

  Expanded _textTitleList(BuildContext context, String popular) {
    return Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(popular),
            ));
  }

  Widget _listAudioBooks()  {
    return ObxValue((data){
      if(_homeController.loading.value==true){
        return CircularProgressIndicator();
      }
      else{
        return  _itemListAudioBooks();
      }
    },false.obs);


  }

  Padding _itemListAudioBooks() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: HorizontalCardPager(
          initialPage: _homeController.itemsAudioBook.length~/2,
          onPageChanged: (page) => {},
          onSelectedItem: (page)  {
            Get.to(() => DetailsBook(_homeController.listAudioBook[page].id));
          },
          items: _homeController.itemsAudioBook,
          // set ImageCardItem or IconTitleCardItem class
        ),
      );
  }

  Padding _iconArrow() {
    return Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: null,
                icon: Icon(Icons.arrow_forward_ios),
              ),
            );
  }

  Container _theBestBooksList(BuildContext context) => _bestBooks(context);

  Container _theMostPopularBooksList(BuildContext context) {
    return Container(
      decoration: _backgroundBoxDecoration(),
      child: Column(
        children: [
          _titleOfList(context,S.of(context).popular),
          _listPopularBooks()
        ],
      ),
    );
  }

  Row _titleOfList(BuildContext context, String text) {
    return Row(
          children: [
            _textTitleList(context,text),
            _textMore(context),
            _iconArrow()
          ],
        );
  }

  Widget _listPopularBooks() {
    return ObxValue((data){
      if(_homeController.loading.value==true){
        return CircularProgressIndicator();
      }
      else{
        return Container(
          height: 200.0,
          child: ListView.builder(
            itemBuilder: (BuildContext _, int index) {
              return _itemListPopularBooks(index);
            },
            itemCount: _homeController.listPopularBook.length,
            scrollDirection: Axis.horizontal,
          ),
        );
      }
    },false.obs);

  }

  Padding _itemListPopularBooks(int index) {
    return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: GestureDetector(
                  onTap: (){
                    Get.to(()=>DetailsBook(_homeController.listPopularBook[index].id));
                  },
                  child: FadeInImage.assetNetwork(
                    fadeInCurve: Curves.linearToEaseOut,
                    image: '${_homeController.listPopularBook[index].url}',
                    placeholder: 'assets/images/noImage.png',
                  ),
                ),
              ),
            );
  }

  Container _bestBooks(BuildContext context) {
    return Container(
      decoration: _backgroundBoxDecoration(),
      child: Column(
        children: [
         _titleOfList(context, S.of(context).the_best),
          _listBestBooks()
        ],
      ),
    );
  }

  Widget _listBestBooks() {

      return ObxValue((date){

        if(_homeController.loading.value==true){
          return CircularProgressIndicator();
        }else
       return Container(
          height: 200.0,
          child: ListView.builder(
            itemBuilder: (BuildContext _, int index) {
              return _itemListBestBooks(index);
            },
            itemCount: _homeController.listBestBook.length,
            scrollDirection: Axis.horizontal,
          ),
        );
      },
      false.obs);

  }

  Padding _itemListBestBooks(int index) {
    return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  Get.to(DetailsBook(_homeController.listBestBook[index].id));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: FadeInImage.assetNetwork(
                    fadeInCurve: Curves.linearToEaseOut,
                    image: '${_homeController.listBestBook[index].url}',
                    placeholder: 'assets/images/noImage.png' ,
                  ),
                ),
              ),
            );
  }

  ObxValue<RxBool> _circleIndicator() {
    return ObxValue(
      (data) {
        double data = _homeController.indexIndicator.value;
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: DotsIndicator(
            dotsCount: 3,
            position: data,
            decorator: _dotsDecorator(),
          ),
        );
      },
      false.obs,
    );
  }

  DotsDecorator _dotsDecorator() {
    return DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          );
  }

  CarouselSlider _bannerList(BuildContext context) {
    return CarouselSlider(
      items: _itemsBanner(context),
      options: _bannerListOptions(),
    );
  }

  List<Widget> _itemsBanner(BuildContext context) {
    return [
      _itemBannerFirst(context),
      _itemBannerSecond(context),
      _itemBannerThird(context),
    ];
  }

  Padding _itemBannerThird(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(11.0),
          child: Image(
            image: AssetImage(S.of(context).assetsimages3jpg),
          ),
        ),
      ),
    );
  }

  Padding _itemBannerSecond(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image(
            image: AssetImage(S.of(context).assetsimages2jpg),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }

  Padding _itemBannerFirst(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image(
            image: AssetImage(S.of(context).assetsimages1jpg),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }

  CarouselOptions _bannerListOptions() {
    return CarouselOptions(
      pageSnapping: true,
      height: 200,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      onPageChanged: (int index, CarouselPageChangedReason reason) {
        _homeController.indexIndicator(index.toDouble());
      },
      autoPlayInterval: Duration(seconds: 3),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      autoPlayCurve: Curves.decelerate,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: _title(context),
      backgroundColor: Colors.white,
      centerTitle: true,
      actions: [
        _badgeShop()
      ],
    );
  }

  Padding _badgeShop() {
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 12.0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _iconShop(),
            _circleBadge(),
          ],
        ),
      );
  }

  Widget _circleBadge() {
    return Positioned(
              left: 20.0,
              bottom: 27.0,
              child: Container(
                  height: 20.0,
                  width: 20.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.red),
                  child: Center(child: Obx(()=>Text('${_homeController.countCartShop}')))));
  }
  Icon _iconShop() {
    return Icon(
            Icons.shopping_cart_outlined,
            color: Colors.black,
            size: 30.0,
          );
  }

  Text _title(BuildContext context) {
    return Text(
      S.of(context).app_name,
      style:
          TextStyle(fontFamily: 'Dana', color: Colors.black, fontSize: 17.0),
    );
  }

}