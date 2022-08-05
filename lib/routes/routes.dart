import 'package:get/get.dart';
import '../page/page.dart';

abstract class Routes {
  static const login = '/login';
  static const loginOutSide = '/login_outside';
  static const changePassword = '/change_password';

  static const contract = '/eContract/contract';
  static const home = '/eContract/home';
  static const setting = '/eContract/setting';
}

abstract class AppPages {
  static String initial = Routes.login;

  static final routes = [
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
  ];
}
