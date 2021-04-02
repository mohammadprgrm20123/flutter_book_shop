import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/controllers/search_controller.dart';
import 'package:flutter_booki_shop/custom_widgets/custom_bottomNavigation.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/views/details_book/details_book.dart';
import 'package:get/get.dart';

class Search extends StatelessWidget {
  static const double MIN_VALUE_PRICE = 5000;
  static const double MAX_VALUE_PRICE = 1000000;
  static const int DIVISIONS = 50;
  SearchController _searchController = Get.put(SearchController());
  TextEditingController _searchCtr = new TextEditingController();

  Rx<RangeValues> _currentRangeValues =
      RangeValues(MIN_VALUE_PRICE, MAX_VALUE_PRICE).obs;

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
                  return Center(child: Text(S.of(context).not_exit_cases));
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

  Widget _listBooks(List<Book> searchList) {
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

  Widget _serachView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: _textFieldSearchView(context),
    );
  }

  Widget _textFieldSearchView(BuildContext context) {
    return TextField(
      controller: _searchCtr,
      onChanged: (text) {
        _searchController.searchInList(text);
      },
      decoration: _inputDecorationSeachFiled(context),
    );
  }

  InputDecoration _inputDecorationSeachFiled(BuildContext context) {
    return InputDecoration(
        prefixIconConstraints: BoxConstraints(),
        suffixIcon: _iconFilter(),
        labelText: S.of(context).search,
        hintText: S.of(context).search,
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))));
  }

  Widget _iconFilter() {
    return IconButton(
      icon: Icon(
        Icons.filter_alt,
        color: Colors.blue,
      ),
      onPressed: () {
        _showBottomSheet();
      },
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

  Widget _title() {
    return Text(
      S.of(Get.context).search,
      style: TextStyle(
          fontFamily: S.of(Get.context).name_font_dana,
          color: Colors.black,
          fontSize: 17.0),
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

  Widget _scrollableBottomSheet() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _textFilterByCategory(),
          ),
          _listCategory(),
          _textFilterPrice(),
          _rangeSlider(),
          _minAndMaxPrice(),
          _btnFilter(),
        ],
      ),
    );
  }

  Widget _textFilterByCategory() {
    return Text(
      S.of(Get.context).filter_by_category,
      style: TextStyle(fontSize: 23.0),
    );
  }

  Widget _textFilterPrice() {
    return Text(
      S.of(Get.context).filter_price,
      style: TextStyle(fontSize: 23.0),
    );
  }

  BoxDecoration _boxDecorationBottomSheet() {
    return new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(10.0),
            topRight: const Radius.circular(10.0)));
  }

  Widget _btnFilter() {
    return SizedBox(
      width: MediaQuery.of(Get.context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
            onPressed: () {
              _searchController.filterInList(_currentRangeValues.value);
              Get.back();
            },
            child: Text(S.of(Get.context).set_filter)),
      ),
    );
  }

  Widget _minAndMaxPrice() {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _textMinPrice(),
          _textMaxPrice(),
        ],
      );
    });
  }

  Widget _textMaxPrice() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(_currentRangeValues.value.end.round().toString() +
          S.of(Get.context).toman),
    );
  }

  Widget _textMinPrice() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(_currentRangeValues.value.start.round().toString() +
          S.of(Get.context).toman),
    );
  }

  Widget _rangeSlider() {
    return Obx(() {
      return RangeSlider(
        values: _currentRangeValues.value,
        min: MIN_VALUE_PRICE,
        max: MAX_VALUE_PRICE,
        divisions: DIVISIONS,
        labels: RangeLabels(
          _currentRangeValues.value.start.round().toString() +
              S.of(Get.context).toman,
          _currentRangeValues.value.end.round().toString() +
              S.of(Get.context).toman,
        ),
        onChanged: (value) {
          print(value.start.toString() + "    " + value.end.toString());
          _currentRangeValues(value);
        },
      );
    });
  }

  Widget _listCategory() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          children: [
            _itemStory(),
            _itemNovel(),
            _itemPhilosophy(),
            _itemPsychology(),
            _itemEpic(),
          ],
        ),
      );
    });
  }

  Widget _itemEpic() {
    return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
                onTap: () {
                  changeColorChips(5);
                  print(_searchController.mapColor[5]);
                },
                child: Chip(
                  label: Text(S.of(Get.context).epic),
                  backgroundColor:
                  _searchController.mapColor[5],
                )),
          );
  }

  Widget _itemPsychology() {
    return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
                onTap: () {
                  changeColorChips(4);
                  print(_searchController.mapColor[4]);
                },
                child: Chip(
                  label: Text(S.of(Get.context).psychology),
                  backgroundColor:
                  _searchController.mapColor[4],
                )),
          );
  }

  Widget _itemPhilosophy() {
    return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
                onTap: () {
                  changeColorChips(3);
                  print(_searchController.mapColor[3]);
                },
                child: Chip(
                  label: Text(S.of(Get.context).philosophy),
                  backgroundColor:
                  _searchController.mapColor[3],
                )),
          );
  }

  Widget _itemNovel() {
    return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
                onTap: () {
                  changeColorChips(2);
                  print(_searchController.mapColor[2]);
                },
                child: Chip(
                  label: Text(S.of(Get.context).novel),
                  backgroundColor:
                  _searchController.mapColor[2],
                )),
          );
  }

  Widget _itemStory() {
    return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
                onTap: () {
                  changeColorChips(1);
                  print(_searchController.mapColor[1]);
                },
                child: Chip(
                  label: Text(S.of(Get.context).category_stoy),
                  backgroundColor:
                  _searchController.mapColor[1],
                )),
          );
  }

  void changeColorChips(int i) {
    for (int j = 1; j <= _searchController.mapColor.length; j++) {
      _searchController.mapColor[j] = Colors.grey;
    }
    _searchController.mapColor[i] = Colors.blue;
  }
}