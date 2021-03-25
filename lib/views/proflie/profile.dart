import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/customwidgets/custom_bottomNavigation.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  List<String> _spinnerItems = ['فارسی', 'انگلیسی'];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          S.of(context).profile,
          style: TextStyle(
              fontFamily: 'Dana', color: Colors.black, fontSize: 17.0),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ]
              ),
              height: 200.0,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: 120.0,
                      width: 120.0,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage("https://imgcdn.taaghche.com/frontCover/90938.jpg?w=200",scale: 10.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('9309103564'),
              ),
              title: new TextField(
                decoration: new InputDecoration(
                  hintText: "شماره تلفن",
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.supervisor_account_rounded),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('mohammadprime'),
              ),
              title: new TextField(
                decoration: new InputDecoration(
                  hintText: "نام کاربری",
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('***********'),
              ),
              title: new TextField(
                decoration: new InputDecoration(
                  hintText: "رمز عبور ",
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.today),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('فارسی'),
              ),
              title: DropdownButton<String>(
                value: _spinnerItems[0],
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(
                    color: Colors.black, fontSize: 18, fontFamily: 'Dana'),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String data) {

                  //Get.updateLocale(Locale('en'));
                },
                items:
                    _spinnerItems.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: ElevatedButton(onPressed: () {}, child: Text("خروج ")),
                ))
          ],
        ),
      ),
      floatingActionButton: CustomBtnNavigation().floatingActionButton(),
      bottomNavigationBar: CustomBtnNavigation().bottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
    throw UnimplementedError();
  }
}
