import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/controllers/home_controller.dart';
import 'package:flutter_booki_shop/customwidgets/card_item.dart';
import 'package:flutter_booki_shop/customwidgets/horisental_card_pager.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/views/details_book.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  HomeController _homeController = Get.put(HomeController());
  List<ImageCarditem> items = [
    ImageCarditem(
        image: Image.network(
            'https://img.taaghche.com/audioCover/88738.jpg?w=150',fit: BoxFit.cover,),

    ),
    ImageCarditem(
      image: Image.network(
        'https://img.taaghche.com/audioCover/88738.jpg?w=150'),

    ),
    ImageCarditem(
      image: Image.network(
        'https://img.taaghche.com/audioCover/88738.jpg?w=150'),

    ),
    ImageCarditem(
      image: Image.network(
        'https://img.taaghche.com/audioCover/88738.jpg?w=150'),

    ),
    ImageCarditem(
      image: Image.network(
        'https://img.taaghche.com/audioCover/88738.jpg?w=150'),

    ),

  ];
  final iconList = <IconData>[
    Icons.brightness_5,
    Icons.brightness_4,
    Icons.brightness_6,
    Icons.brightness_7,
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _scrollView(context),
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _bottomNavigationBar(),
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

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.home_outlined),
    );
  }

  AnimatedBottomNavigationBar _bottomNavigationBar() {
    return AnimatedBottomNavigationBar(
        icons: [
          Icons.shopping_bag_outlined,
          Icons.favorite_border,
          Icons.search,
          Icons.account_circle_outlined,
        ],
        elevation: 20.0,
        backgroundColor: Colors.white,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        splashRadius: 10.0,
        activeColor: Colors.blue,
        onTap: (index) {
          print(index.toString());
        });
  }

  Container _audioBooksList(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white38,
            Colors.black12,
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(S.of(context).the_best),
              )),
              Text(S.of(context).more),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: HorizontalCardPager(
              initialPage: 2,
              // default value is 2
              onPageChanged: (page) => print("page : $page"),
              onSelectedItem: (page) => print("selected : $page"),
              items: items,
              // set ImageCardItem or IconTitleCardItem class
            ),
          ),
        ],
      ),
    );
  }

  Container _theBestBooksList(BuildContext context) => _bestBooks(context);

  Container _theMostPopularBooksList(BuildContext context) {
    HomeController _homeController = Get.find();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white38,
            Colors.black12,
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(S.of(context).the_best),
              )),
              Text(S.of(context).more),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              )
            ],
          ),

          Container(
            height: 200.0,
            child: ListView.builder(

              itemBuilder: (BuildContext _, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: GestureDetector(
                      onTap: (){
                        print('aldadsadlskdjakls');
                        Get.to(DetailsBook());
                      },
                      child: FadeInImage.assetNetwork(
                      fadeInCurve: Curves.bounceIn,
                      image:
                          'https://imgcdn.taaghche.com/frontCover/90938.jpg?w=200',
                      placeholder: 'assets/images/1.jpg',
                      ),
                    ),


                  ),
                );
              },
              itemCount: 20,
              scrollDirection: Axis.horizontal,
            ),
          )
          // ignore: missing_return
          /*
*/
        ],
      ),
    );
  }

  Container _bestBooks(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white38,
            Colors.black12,
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(S.of(context).the_most_famous_books),
              )),
              Text(S.of(context).more),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              )
            ],
          ),
          Container(
            height: 200.0,
            child: ListView.builder(
              itemBuilder: (BuildContext _, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: FadeInImage.assetNetwork(
                      fadeInCurve: Curves.bounceIn,
                      image:
                          'https://imgcdn.taaghche.com/frontCover/90938.jpg?w=200',
                      placeholder: 'assets/images/1.jpg',
                    ),
                  ),
                );
              },
              itemCount: 20,
              scrollDirection: Axis.horizontal,
            ),
          )
          // ignore: missing_return
          /*
*/
        ],
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
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          ),
        );
      },
      false.obs,
    );
  }

  CarouselSlider _bannerList(BuildContext context) {
    return CarouselSlider(
      items: [
        Padding(
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
        ),
        Padding(
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
        ),
        Padding(
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
        ),
      ],
      options: CarouselOptions(
        pageSnapping: true,
        height: 200,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        onPageChanged: (int index, CarouselPageChangedReason reason) {
          print(index.toString());
          _homeController.indexIndicator(index.toDouble());
        },
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.decelerate,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        S.of(context).app_name,
        style:
            TextStyle(fontFamily: 'Dana', color: Colors.black, fontSize: 17.0),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      actions: [
        //badge shop
        Padding(
          padding: const EdgeInsets.only(left: 25.0, top: 12.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black,
                size: 30.0,
              ),
              Positioned(
                  left: 20.0,
                  bottom: 27.0,
                  child: Container(
                      height: 20.0,
                      width: 20.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                      child: Center(child: Text('1')))),
            ],
          ),
        )
      ],
    );
  }

}