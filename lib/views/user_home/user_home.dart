import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import 'widgets/back_ground.dart';
import 'widgets/list_audio_book.dart';
import 'widgets/list_best_book.dart';
import 'widgets/list_popular_book.dart';

class UserHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StateUserHome();
}

class StateUserHome extends State<UserHomePage> {
  final homeController = Get.put(HomeController());

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: _body(context),
      );

  Widget _body(final BuildContext context) => SafeArea(
        child: Column(
          children: [
            BackGround(),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                children: [
                  ListBestBook(),
                  ListPopularBook(),
                  ListAudioBook(),
                ],
              ),
            ),
          ],
        ),
      );

}
