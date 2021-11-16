import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/search_controller.dart';
import '../../generated/l10n.dart';
import '../../models/book_view_model.dart';
import '../details_book/details_book.dart';

@immutable
class Search extends StatelessWidget {
  static const double minValuePrice = 5000;
  static const double maxValuePrice = 1000000;
  static const int divisions = 50;
  final searchController = Get.put(SearchController());
  final TextEditingController _searchCtr = TextEditingController();

  final Rx<RangeValues> _currentRangeValues =
      const RangeValues(minValuePrice, maxValuePrice).obs;

  @override
  Widget build(final BuildContext context) {
    searchController.getAllBooks();

    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _searchView(context),
          Obx(() {
            if (searchController.loadingSearch.value == true) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (searchController.searchList.isEmpty) {
                return Center(child: Text(S.of(context).not_exit_cases));
              } else {
                return _listBooks(searchController.searchList);
              }
            }
          })
        ],
      ),
    );
  }

  Widget _listBooks(final List<BookViewModel> searchList) => Expanded(
        child: GridView.builder(
          itemCount: searchList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (final context, final index) =>
              _itemBook(searchList[index]),
        ),
      );

  Widget _itemBook(final BookViewModel book) => GestureDetector(
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

  Widget _searchView(final BuildContext context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: _textFieldSearchView(context),
      );

  Widget _textFieldSearchView(final BuildContext context) => TextField(
        controller: _searchCtr,
        onChanged: (final text) {
          searchController.searchInList(text);
        },
        decoration: _inputDecorationSearchFiled(context),
      );

  InputDecoration _inputDecorationSearchFiled(final BuildContext context) =>
      InputDecoration(
          prefixIconConstraints: const BoxConstraints(),
          suffixIcon: _iconFilter(),
          labelText: S.of(context).search,
          hintText: S.of(context).search,
          prefixIcon: const Icon(Icons.search),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))));

  Widget _iconFilter() => IconButton(
      icon: const Icon(
        Icons.filter_alt,
        color: Colors.blue,
      ),
      onPressed: () {
        _showBottomSheet();
      },
    );

  AppBar _appBar() => AppBar(
      title: _title(),
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      centerTitle: true,
    );

  Widget _title() => Text(
      S.of(Get.context).search,
      style: TextStyle(
          fontFamily: S.of(Get.context).name_font_dana,
          color: Colors.black,
          fontSize: 17.0),
    );

  void _showBottomSheet() {
    showModalBottomSheet(
        context: Get.context,
        builder: (final builder) => Container(
              decoration: _boxDecorationBottomSheet(),
              child: _scrollableBottomSheet()));
  }

  Widget _scrollableBottomSheet() => SingleChildScrollView(
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

  Widget _textFilterByCategory() => Text(
      S.of(Get.context).filter_by_category,
      style: const TextStyle(fontSize: 23.0),
    );

  Widget _textFilterPrice() => Text(
      S.of(Get.context).filter_price,
      style: const TextStyle(fontSize: 23.0),
    );

  BoxDecoration _boxDecorationBottomSheet() => const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0)));

  Widget _btnFilter() => SizedBox(
      width: MediaQuery.of(Get.context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
            onPressed: () {
              searchController.filterInList(_currentRangeValues.value);
              Get.back();
            },
            child: Text(S.of(Get.context).set_filter)),
      ),
    );

  Widget _minAndMaxPrice() => Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _textMinPrice(),
          _textMaxPrice(),
        ],
      ));

  Widget _textMaxPrice() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(_currentRangeValues.value.end.round().toString() +
          S.of(Get.context).toman),
    );

  Widget _textMinPrice() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(_currentRangeValues.value.start.round().toString() +
          S.of(Get.context).toman),
    );

  Widget _rangeSlider() => Obx(() => RangeSlider(
        values: _currentRangeValues.value,
        min: minValuePrice,
        max: maxValuePrice,
        divisions: divisions,
        labels: RangeLabels(
          _currentRangeValues.value.start.round().toString() +
              S.of(Get.context).toman,
          _currentRangeValues.value.end.round().toString() +
              S.of(Get.context).toman,
        ),
        onChanged: _currentRangeValues,
      ));

  Widget _listCategory() => Obx(() => Padding(
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
      ));

  Widget _itemEpic() => Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
          onTap: () {
            changeColorChips(5);
          },
          child: Chip(
            label: Text(S.of(Get.context).epic),
            backgroundColor: searchController.mapColor[5],
          )),
    );

  Widget _itemPsychology() => Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
          onTap: () {
            changeColorChips(4);
          },
          child: Chip(
            label: Text(S.of(Get.context).psychology),
            backgroundColor: searchController.mapColor[4],
          )),
    );

  Widget _itemPhilosophy() => Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
          onTap: () {
            changeColorChips(3);
          },
          child: Chip(
            label: Text(S.of(Get.context).philosophy),
            backgroundColor: searchController.mapColor[3],
          )),
    );

  Widget _itemNovel() => Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
          onTap: () {
            changeColorChips(2);
          },
          child: Chip(
            label: Text(S.of(Get.context).novel),
            backgroundColor: searchController.mapColor[2],
          )),
    );

  Widget _itemStory() => Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
          onTap: () {
            changeColorChips(1);
          },
          child: Chip(
            label: Text(S.of(Get.context).category_stoy),
            backgroundColor: searchController.mapColor[1],
          )),
    );

  void changeColorChips(final int i) {
    for (int j = 1; j <= searchController.mapColor.length; j++) {
      searchController.mapColor[j] = Colors.grey;
    }
    searchController.mapColor[i] = Colors.blue;
  }
}
