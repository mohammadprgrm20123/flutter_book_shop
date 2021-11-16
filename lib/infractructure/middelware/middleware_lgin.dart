import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../my_routes.dart';

class MiddleWareLogin extends GetMiddleware {

  String role = 'none';

  MiddleWareLogin({final this.role});


  @override
  RouteSettings redirect(final String route) {

    switch(role){
      case 'none':return RouteSettings(name: AppRoutes.login);
      case 'admin':return RouteSettings(name: AppRoutes.adminHome);
      case 'user':return RouteSettings(name: AppRoutes.userHome);
    }

    return super.redirect(route);
  }
}
