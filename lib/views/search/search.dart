import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/controllers/search_controller.dart';
import 'package:flutter_booki_shop/custom_widgets/custom_bottomNavigation.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/views/details_book/details_book.dart';
import 'package:flutter_booki_shop/views/details_book/details_book.dart';
import 'package:get/get.dart';

class Search extends StatelessWidget {
  SearchController _searchController = Get.put(SearchController());
  TextEditingController _searchCtr = new TextEditingController();
  Rx<RangeValues> _currentRangeValues = RangeValues(10000, 50000).obs;

  @override
  Widget build(BuildContext context) {
    _searchController.getAllBooks();

    // TODO: implement build
    return Scaffold(
      appBar: _appBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomBtnNavigation().floatingActionButton(),
      bottomNavigationBar: CustomBtnNavigation().bottomNavigationBar(),
      body: Container(
        child: Column(
          children: [
            //search view
            _serachView(context),

            Obx(() {
              if (_searchController.loading.value == true) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (_searchController.searchList.length == 0) {
                  return Center(child: Text("موردی وجود ندارد"));
                } else {
                  return _listBooks(_searchController.searchList);
                }
              }
            })
          ],
        ),
      ),
    );
  }

  Expanded _listBooks(List<Book> searchList) {
    return Expanded(
      child: GridView.builder(
        itemCount: searchList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return _itemBook(searchList[index]);
        },
      ),
    );
  }

  Widget _itemBook(Book book) {
    return GestureDetector(
      onTap: () {
        Get.to(DetailsBook(book.id));
      },
      child: Card(
        elevation: 7.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: FadeInImage.assetNetwork(
            fadeInCurve: Curves.bounceIn,
            image: book.url,
            placeholder: 'assets/images/1.jpg',
          ),
        ),
      ),
    );
  }

  Padding _serachView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: _searchCtr,
        onChanged: (text) {
          print(_searchCtr.text);
          _searchController.searchInList(text);
          // print(_searchController.listAll.toString());
        },
        decoration: InputDecoration(
            prefixIconConstraints: BoxConstraints(),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.filter_alt,
                color: Colors.blue,
              ),
              onPressed: () {
                _showBottomSheet();
              },
            ),
            labelText: S.of(context).search,
            hintText: S.of(context).search,
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)))),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: _title(),
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      centerTitle: true,
    );
  }

  Text _title() {
    return Text(
      'جستوجو',
      style: TextStyle(fontFamily: 'Dana', color: Colors.black, fontSize: 17.0),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: Get.context,
        builder: (builder) {
          return new Container(
              decoration: _boxDecorationBottomSheet(),
              child: _scrollableBottomSheet());
        });
  }

  SingleChildScrollView _scrollableBottomSheet() {
    return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "فیلتر بر اساس دسته بندی",
                      style: TextStyle(fontSize: 23.0),
                    ),
                  ),
                  _listCategory(),
                  Text(
                    "فیلتر  قیمت",
                    style: TextStyle(fontSize: 23.0),
                  ),
                  _rangeSlider(),
                  _minAndMaxPrice(),
                  _btnFilter(),
                ],
              ),
            );
  }

  BoxDecoration _boxDecorationBottomSheet() {
    return new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0)));
  }

  SizedBox _btnFilter() {
    return SizedBox(
                      width: MediaQuery.of(Get.context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ElevatedButton(
                            onPressed: (){
                              _searchController.filterInList(_currentRangeValues.value);
                              Get.back();
                        }, child: Text("اعمال فیلتر")),
                      ),
                    );
  }

  Obx _minAndMaxPrice() {
    return Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                _currentRangeValues.value.start.round().toString() +
                                    "تومان"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                _currentRangeValues.value.end.round().toString() +
                                    "تومان"),
                          ),
                        ],
                      );
                    });
  }

  Obx _rangeSlider() {
    return Obx(() {
                      return RangeSlider(
                        values: _currentRangeValues.value,
                        min: 5000,
                        max: 100000,
                        divisions: 50,
                        labels: RangeLabels(
                          _currentRangeValues.value.start.round().toString() +
                              "تومان",
                          _currentRangeValues.value.end.round().toString() +
                              "تومان",
                        ),
                        onChanged: (value) {
                          print(value.start.toString() +
                              "    " +
                              value.end.toString());
                          _currentRangeValues(value);
                        },
                      );
                    });
  }

  Obx _listCategory() {
    return Obx(() {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                  onTap: () {
                                    changeColorChips(1);
                                    print(_searchController.mapColor[1]);
                                  },
                                  child: Chip(
                                    label: Text('داستانی'),
                                    backgroundColor:
                                        _searchController.mapColor[1],
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                  onTap: () {
                                    changeColorChips(2);
                                    print(_searchController.mapColor[2]);
                                  },
                                  child: Chip(
                                    label: Text('رمان'),
                                    backgroundColor:
                                        _searchController.mapColor[2],
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                  onTap: () {
                                    changeColorChips(3);
                                    print(_searchController.mapColor[3]);
                                  },
                                  child: Chip(
                                    label: Text('فلسفه'),
                                    backgroundColor:
                                        _searchController.mapColor[3],
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                  onTap: () {
                                    changeColorChips(4);
                                    print(_searchController.mapColor[4]);
                                  },
                                  child: Chip(
                                    label: Text('روانشناسی'),
                                    backgroundColor:
                                        _searchController.mapColor[4],
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                  onTap: () {
                                    changeColorChips(5);
                                    print(_searchController.mapColor[5]);
                                  },
                                  child: Chip(
                                    label: Text('حماسی'),
                                    backgroundColor:
                                        _searchController.mapColor[5],
                                  )),
                            ),
                          ],
                        ),
                      );
                    });
  }

  void changeColorChips(int i) {
    for (int j = 1; j <= _searchController.mapColor.length; j++) {
      _searchController.mapColor[j] = Colors.grey;
    }
    _searchController.mapColor[i] = Colors.blue;
  }
}