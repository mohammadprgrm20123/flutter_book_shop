import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/admin_report_controller.dart';
import '../../generated/l10n.dart';
import '../../models/cart_shop.dart';
import '../../models/purches_view_model.dart';

class AdminReport extends StatelessWidget {
  final adminReportController = Get.put(AdminReportController());

  @override
  Widget build(final BuildContext context) => Scaffold(
      appBar: _appBar(context),
      body: Obx(() {
        if (adminReportController.loading.value == true) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (adminReportController.listPurchase.isEmpty) {
            return Center(child: Text(S.of(Get.context!).not_exit_cases));
          } else {
            return _lisPurchase();
          }
        }
      }));

  Widget _lisPurchase() => ListView.builder(
        itemBuilder: (final _, final int index) =>
            _itemList(adminReportController.listPurchase[index]),
        itemCount: adminReportController.listPurchase.length,
      );

  Widget _itemList(final Purchase purchase) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: _decorationItems(),
          child: _itemPurchase(purchase),
        ),
      );

  Widget _itemPurchase(final Purchase purchase) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.of(Get.context!).success_purchase),
            Text('${S.of(Get.context!).date}     :  ${_getDate(purchase)}'),
            expanded(purchase),
            Text('مجموع هزینه   ${calcutePrice(purchase)}   تومان'),
          ],
        ),
      );

  Widget expanded(final Purchase purchase) => Column(
        children: listBooks(purchase),
      );

  BoxDecoration _decorationItems() => BoxDecoration(
        color: Colors.green[200],
        borderRadius: BorderRadius.circular(10.0),
      );

  String _getDate(final Purchase purchase) => purchase.date!;

  AppBar _appBar(final BuildContext context) => AppBar(
        backgroundColor: Colors.white,
        title: _title(context),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      );

  Text _title(final BuildContext context) => Text(
      S.of(Get.context!).report_purchase,
      style: TextStyle(
          fontFamily: S.of(Get.context!).name_font_dana,
          color: Colors.black,
          fontSize: 17.0));

  List<Widget> listBooks(final Purchase purchase) {
    if (purchase.cartShop == null) {
      return [];
    } else {
      return purchase.cartShop!.map((final CartShop e) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(' تعداد : ${e.count.toString()}'),
            Text('نام کتاب : ${e.book!.bookName}'),
          ],
        )).toList();
    }
  }

  String calcutePrice(final Purchase purchase) {
    double price = 0;
    for (final element in purchase.cartShop!) {
      price += element.count! * double.parse(element.book!.price!);
    }
    return price.toString();
  }
}
