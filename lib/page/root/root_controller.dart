import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/widgets/dialogs/exit_dialog.dart';
import '/services/storage/storage_service.dart';
import 'models/nav_data.dart';

class RootController extends GetxController {
  final _navData = NavData();
  final storageService = Get.find<StorageService>();

  List<NavItemData> get menuData => List<NavItemData>.from(_navData.myData);

  RxInt selectedNav = 1.obs;
  final _pages = <Widget>[];
  late NavItemData _currentModel;

  @override
  void onInit() {
    super.onInit();
    _currentModel = menuData.first;
  }

  List<Widget> getPages() {
    if (_pages.isEmpty) {
      _pages.addAll(menuData.map(
        (e) {
          return Navigator(
            key: Get.nestedKey(e.navItem.navKey),
            onGenerateRoute: e.navItem.generateRoute,
          );
        },
      ));
    }
    return _pages;
  }

  void onTapNav(int idx) async {
    _currentModel = menuData[idx];

    //check reload tab when sign success.
    // final isReload = storageService.signSuccess;
    // if (isReload != null) {
    //   if (idx == 0 && isReload) {
    //     final _contractController = Get.find<ContractController>();
    //     _contractController.resetData();
    //     await _contractController.getContract();
    //     storageService.signSuccess = false;
    //   }
    //   if (idx == 1 && isReload) {
    //     final _homeController = Get.find<HomeController>();
    //     _homeController.resetData();
    //     storageService.signSuccess = false;
    //   }
    // }
    selectedNav(idx);
  }

  Future<bool> canPop() async {
    final navKey = Get.nestedKey(_currentModel.navItem.navKey);
    if (navKey!.currentState!.canPop()) {
      navKey.currentState!.pop();
      return Future.value(false);
    } else {
      final result = await Get.dialog(const ExitDialog(title: 'msg_close_app'));
      if (result) return Future.value(true);
    }
    return Future.value(false);
  }
}
