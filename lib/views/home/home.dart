
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/controllers/HomeController.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:get/get.dart';

import 'page_slider.dart';

@immutable
class Home extends StatelessWidget{

  HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title:Text(S.of(context).app_name,style: TextStyle(fontFamily: 'Dana',color: Colors.black,fontSize: 17.0),),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          //badge shop
          Padding(
            padding: const EdgeInsets.only(left:25.0,top: 12.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(Icons.shopping_cart_outlined,color: Colors.black,size: 30.0,),
                Positioned(
                  left:20.0,
                  bottom: 27.0,
                  child: Container(
                    height: 20.0,
                      width: 20.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red
                      ),
                      child: Center(child: Text('1')))
                  ),
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          CarouselSlider(
            items: [
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Container(
                  width:  MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image(
                      image: AssetImage(
                          S.of(context).assetsimages1jpg),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image(
                      image: AssetImage(
                          S.of(context).assetsimages2jpg),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(11.0),
                    child: Image(
                      image: AssetImage(
                          S.of(context).assetsimages3jpg),
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
              onPageChanged: (int index,CarouselPageChangedReason reason){
                print(index.toString());
                _homeController.indexIndicator(index.toDouble());
              },
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.decelerate,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
          ),

          ObxValue((data){
            double data = _homeController.indexIndicator.value;
            return DotsIndicator(
              dotsCount: 3,
              position: data,
              decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            );

          },
            false.obs,
          ),
        ],
      ),
    );
  }

  double getCurrentIndex(){
    double b= 0.0;
    _homeController.indexIndicator.listen((double index) {
      b= index;
    });
    return b;
  }

}