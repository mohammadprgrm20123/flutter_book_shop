import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailsBook extends StatelessWidget {

  List<String> _tags=[
    'ketab','ereerererre','ererrecxxc','yyyyy','uyyu','dfdfdd'
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(S.of(context).details,
            style: TextStyle(
                fontFamily: 'Dana', color: Colors.black, fontSize: 17.0)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                //photo of book
                Center(
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
                              'https://imgcdn.taaghche.com/frontCover/90938.jpg?w=200',
                          placeholder: 'assets/images/1.jpg',
                        ),
                      ),
                    ),
                  ),
                ),

                //name book
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'کوه نور',
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                ),
                //name authers
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'محمد کاظمی نژاد / اسکات ریچارد سون',
                    style: TextStyle(color: Colors.black38, fontSize: 14.0),
                  ),
                ),

                //stars
                Row(
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
                    Expanded(child: Text('4.1/5',textAlign: TextAlign.end,style: TextStyle(fontSize: 14.0),)),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: RatingBar.builder(
                        initialRating: 2.1,
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
                ),

                //add to cart shop
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:30.0),
                  child: SizedBox(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(onPressed: (){},
                          child: Text('اضافه کردن به سبد خرید    160000 تومان '),
                      )),
                ),

                //add to favorite
                Padding(
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
                ),


                //divider
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 20.0),
                  child: Divider(
                    thickness: 1.0,
                    color: Colors.black12,
                  ),
                ),

                //indroduction
                Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(S.of(context).book_introduction,style: TextStyle(fontWeight: FontWeight.bold)),
                    )),

                //description
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(S.of(context).sd,style: TextStyle(fontSize: 13.0,color: Colors.black45)),
                ),

                Divider(
                  height: 10.0,
                  thickness: 1.0,
                  color: Colors.black,
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right:8.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Text('دسته بندی'),
                                Text("رمان",style: TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Text('قیمت'),
                              Text("160000",style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ),

                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(

                            children: [
                              Text('ناشر'),
                              Text("محمد کاظمی نژاد",style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Column(

                                  children: [
                                    Text('تعداد صفحات'),
                                    Text("120",style: TextStyle(fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

                Divider(
                  height: 10.0,
                  thickness: 1.0,
                  color: Colors.black,
                ),



                Wrap(
                  direction: Axis.horizontal,
                  children:[
                    for ( var i in _tags ) Container(
                      margin: const EdgeInsets.only(right: 8.0, bottom: 15.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(i.toString(),style: TextStyle(color: Colors.white),),
                      ),
                    )

                     ]
                ),
              ],
            )
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}
