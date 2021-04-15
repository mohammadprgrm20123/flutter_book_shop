import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/controllers/admin_report_controller.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/CartShop.dart';
import 'package:flutter_booki_shop/models/purches.dart';
import 'package:get/get.dart';
class AdminReport extends StatelessWidget {
  AdminReportController _adminReportController = Get.put(AdminReportController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: _appBar(context),
      body: Obx(() {
        if (_adminReportController.loading.value == true) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (_adminReportController.listPurches.length == 0) {
            return Center(child: Text(S.of(Get.context).not_exit_cases));
          } else {
            return _lisPurchase();
          }
        }
      })
    );
  }

  Widget _lisPurchase() {
    return ListView.builder(
            itemBuilder: ( _ ,int index) {
              return _itemList(_adminReportController.listPurches[index]);
            },
            itemCount: _adminReportController.listPurches.length,
          );
  }

  Padding _itemList(Purchase purchase) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: _decorationItems(),
        child: _itemPurchase(purchase),
      ),
    );
  }

  Padding _itemPurchase(Purchase purchase) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.of(Get.context).success_purchase),
            Text("${S.of(Get.context).date}     :  ${_getDate(purchase)}"),
            expanded(purchase),
            Text("مجموع هزینه   ${calcutePrice(purchase) }   تومان"),
          ],
        ),
      );
  }

  Widget expanded(Purchase purchase) {
    return Column(
      children:listBooks(purchase),
    );
  }

  BoxDecoration _decorationItems() {
    return BoxDecoration(
        color: Colors.green[200],
        borderRadius: BorderRadius.circular(10.0),
      );
  }

  String _getDate(Purchase purchase) {
    return purchase.date;
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: _title(context),
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
    );
  }

  Text _title(BuildContext context) {
    return Text(S.of(Get.context).report_purchase,
        style:
            TextStyle(fontFamily: S.of(Get.context).name_font_dana, color: Colors.black, fontSize: 17.0));
  }

 List<Widget> listBooks(Purchase purchase) {
    if(purchase.cartShop==null){
      return [];
    }
    else{
      return purchase.cartShop.map((CartShop e) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(" تعداد : ${e.count.toString()}"),

            Text("نام کتاب : ${e.book.bookName}"),
          ],
        );
      }).toList();
    }

  }

  String calcutePrice(Purchase purchase) {

    double price =0;
    purchase.cartShop.forEach((element) {
    price+=element.count*double.parse(element.book.price);
    });
    return price.toString();
  }
}
