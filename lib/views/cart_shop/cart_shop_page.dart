import 'package:adder_cart_shop/custom_adder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_shop_controller.dart';
import '../../generated/l10n.dart';
import '../../models/cart_shop.dart';

class CartShopPage extends GetView<CartShopController> {

  @override
  Widget build(final BuildContext context) {
    Get.lazyPut(() => CartShopController());

    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() {
            if (controller.loading.value == true) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (controller.listCartShop.isEmpty) {
                return _textNotExist();
              } else {
                return _listCartShop();
              }
            }
          }),
          _calculatePrice()
        ],
      ),
    );
  }

    Widget _textNotExist() => Expanded(
      child: Center(
        child: Text(S.of(Get.context!).not_exit_cases),
      ),
    );

    Container _calculatePrice() => Container(
      height: 80.0,
      child: Card(
        elevation: 5.0,
        color: Colors.blue[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_btnContinue(), _totalPrice()],
        ),
      ),
    );

    Padding _btnContinue() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () {
            controller
                .registerUserPurchase(controller.totalPrice.value);
          },
          child: Text(S.of(Get.context!).continue1)),
    );

    Expanded _totalPrice() => Expanded(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              if (controller.loading.value == false) {
                return Text(
                    '${controller.calculateTotalPrice()}'
                        ' ${S.of(Get.context!).toman} ',
                    textAlign: TextAlign.end,
                    style: const TextStyle(fontSize: 18.0));
              } else {
                return const CircularProgressIndicator();
              }
            })));

    Expanded _listCartShop() => Expanded(
      child: ListView.builder(
        itemBuilder: (final _, final index) =>
            _listItem(controller.listCartShop[index], index),
        itemCount: controller.listCartShop.length,
      ),
    );

    Widget _listItem(final CartShop cartShop, final int index) => Padding(
      padding: const EdgeInsets.all(12.0),
      child: _card(cartShop, index),
    );

    Card _card(final CartShop cartShop, final int index) => Card(
      elevation: 8.0,
      child: Container(
        height: 180.0,
        child: Row(
          children: [
            _imageAndCustomAdder(cartShop, index),
            _nameAndPrice(cartShop),
            _btnDelete(cartShop)
          ],
        ),
      ),
    );

    Widget _btnDelete(final CartShop cartShop) => Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
            onPressed: () {
              _removeItemLIst(cartShop);
            },
            icon: const Icon(Icons.delete),
            label: Text(S.of(Get.context!).delete))
      ],
    );

    void _removeItemLIst(final CartShop cartShop) {
      controller.loading(true);
      controller.listCartShop.remove(cartShop);
      if (cartShop.count != 0) {
      }
      controller.loading(false);
      requestForDelete(cartShop);
      controller.calculateTotalPrice();
    }

    Widget _nameAndPrice(final CartShop cartShop) => Expanded(
      child: Container(
        height: 180.0,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cartShop.book!.bookName!),
                Text('${S.of(Get.context!).price} : ${cartShop.book!.price!}'),
                Text('${S.of(Get.context!).author_name}  : '
                    '${cartShop.book!.autherName!.substring(0, 8)}...'),
              ],
            ),
          ],
        ),
      ),
    );

    Column _imageAndCustomAdder(final CartShop cartShop, final int index) =>
        Column(
          children: [
            _imageBook(cartShop),
            // _customAdder(cartShop, index),
          ],
        );

    Padding _customAdder(final CartShop cartShop, final int index) => Padding(
      padding: const EdgeInsets.all(4.0),
      child: CustomAdder(
        value: cartShop.count!,
        backgroundColor: Colors.red,
        textColor: Colors.black,
        onChangedAdd: (final count) {
          controller.listCartShop[index].count = count;
          controller.calculateTotalPrice();
          },
        onChangedRemove: (final count) {
          controller.listCartShop[index].count = count;
          if (count == 0) {
            controller.listCartShop.remove(cartShop);
            _removeItemLIst(cartShop);
          }
        },
      ),
    );

    FadeInImage _imageBook(final CartShop cartShop) => FadeInImage.assetNetwork(
      fadeInCurve: Curves.linearToEaseOut,
      image: cartShop.book!.url!,
      placeholder: '',
      height: 120.0,
      width: 80.0,
    );

    AppBar _appBar(final BuildContext context) => AppBar(
      backgroundColor: Colors.white,
      title: _title(context),
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.black),
    );

    Text _title(final BuildContext context) => Text(S.of(Get.context!).cart_shop,
        style: TextStyle(
            fontFamily: S.of(Get.context!).name_font_dana,
            color: Colors.black,
            fontSize: 17.0));

    void requestForDelete(final CartShop cartShop) {
      controller..removeItemOfShoppingCart(cartShop);
    }
  }

