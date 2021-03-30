

import 'package:adder_cart_shop/custom_adder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartShopPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, int index) {
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Card(
                      elevation: 8.0,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  //Get.to(()=>DetailsBook(_homeController.listPopularBook[index].id));
                                },
                                child: FadeInImage.assetNetwork(
                                  fadeInCurve: Curves.linearToEaseOut,
                                  image: "https://imgcdn.taaghche.com/frontCover/4096.jpg?w=400",
                                  placeholder: "",
                                  height: 120.0,
                                  width: 100.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomAdder(
                                  value: 2,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.black,
                                  onChanged: (value) {
                                    print(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 200.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 10.0,),
                                Text("شوهر آهو خانم"),
                                Text("قیمت : ${20000000}"),
                              ],
                            ),
                          ),
                          //SizedBox(width: 70.0,),
                          Padding(
                            padding: const EdgeInsets.only(right:20.0),
                            child: Container(
                              height: 200.0,
                              child: Column(
                                children: [
                                  ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.delete), label: Text("حذف"))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: 20,
            ),
          ),
          Container(
            child: Card(
              elevation: 5.0,
              child: Row(

                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: (){}, child: Text("ادامه فرایند")),
                  ),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${50000000} تومان ",textAlign: TextAlign.end,style: TextStyle(fontSize: 18.0),),
                  ))
                ],
              ),
              color: Colors.blue[100],
            ),
            height: 80.0,

          )
        ],
      )
      ,
    );
    throw UnimplementedError();
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
    return Text("سبد خرید",
        style: TextStyle(
            fontFamily: 'Dana', color: Colors.black, fontSize: 17.0));
  }
}