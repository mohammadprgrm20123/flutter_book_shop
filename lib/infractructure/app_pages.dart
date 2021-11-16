import 'package:get/get.dart';

import '../views/admin_home/admin_home.dart';
import '../views/login/login.dart';
import '../views/management_user_home.dart';
import 'my_routes.dart';

List<GetPage> appPages = [
  GetPage(name: AppRoutes.userHome, page: () => ManagementUserHome()),
  GetPage(name: AppRoutes.adminHome, page: () => AdminHomePage()),
  GetPage(name: AppRoutes.login, page: () => LoginPage()),

];
