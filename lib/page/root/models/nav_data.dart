import 'package:app_demo/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../page.dart';

class NavKeys {
  static const int contract = 0;
  static const int home = 1;
  static const int setting = 2;
}

class NavItem {
  final int navKey;
  final GetPage getPage;

  NavItem({required this.navKey, required this.getPage});

  PageRoute generateRoute(RouteSettings settings) {
    return GetPageRoute(
      page: getPage.page,
      routeName: getPage.name,
      binding: getPage.binding,
    );
  }
}

class NavItemData {
  final String name;
  final String icon;
  final String route;
  final int idNav;
  final NavItem navItem;

  NavItemData({
    required this.name,
    required this.icon,
    required this.navItem,
    required this.route,
    required this.idNav,
  });
}

class NavData {
  final List<NavItemData> myData = [
    NavItemData(
      name: 'navbar_contract',
      route: Routes.contract,
      icon: 'assets/icons/ic_contract.png',
      idNav: NavKeys.contract,
      navItem: NavItem(
        navKey: NavKeys.contract,
        getPage: GetPage(
          name: Routes.contract,
          page: () => const ContractView(),
          binding: BindingsBuilder.put(() => ContractController()),
        ),
      ),
    ),
    NavItemData(
      name: 'navbar_home',
      route: Routes.home,
      icon: 'assets/icons/ic_home.png',
      idNav: NavKeys.home,
      navItem: NavItem(
        navKey: NavKeys.home,
        getPage: GetPage(
          name: Routes.home,
          page: () => const HomeView(),
          binding: BindingsBuilder.put(() => HomeController()),
        ),
      ),
    ),
    NavItemData(
      name: 'navbar_setting',
      icon: 'assets/icons/ic_setting.png',
      route: Routes.setting,
      idNav: NavKeys.setting,
      navItem: NavItem(
        navKey: NavKeys.setting,
        getPage: GetPage(
          name: Routes.setting,
          page: () => const SettingView(),
          binding: BindingsBuilder.put(() => SettingController()),
        ),
      ),
    ),
  ];
}
