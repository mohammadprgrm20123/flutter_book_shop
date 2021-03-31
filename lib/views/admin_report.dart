import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/controllers/admin_report_controller.dart';
import 'package:flutter_booki_shop/models/purches.dart';
import 'package:get/get.dart';
import 'package:shamsi_date/shamsi_date.dart';

class AdminReport extends StatelessWidget {
  AdminReportController _adminReportController = Get.put(AdminReportController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: _appBar(context),
      body: Obx(() {
        print(_adminReportController.loading.value.toString());
        if (_adminReportController.loading.value == true) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (_adminReportController.listPurches.length == 0) {
            return Center(child: Text("موردی وجود ندارد"));
          } else {
            return _listPurches();
          }
        }
      })
    );
  }

  Widget _listPurches() {
    return ListView.builder(
            itemBuilder: ( _ ,int index) {
              return _itemList(_adminReportController.listPurches[index]);
            },
            itemCount: _adminReportController.listPurches.length,
          );
  }

  Padding _itemList(Purches purches) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green[200],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("خرید موفق"),
              Text("تاریخ    :  ${_getDate(purches)}"),
              Text(" قیمت    :${purches.price}"),
            ],
          ),
        ),
      ),
    );
  }

  String _getDate(Purches purches) {

   // String date = "${jalali.year}/${jalali.month}/${jalali.day}";
    return purches.date;
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
    return Text("گزارش خرید ها",
        style:
            TextStyle(fontFamily: 'Dana', color: Colors.black, fontSize: 17.0));
  }
}
