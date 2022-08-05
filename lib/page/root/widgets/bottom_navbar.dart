import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/const/import_const.dart';
import '../root_controller.dart';

class AppBottomNavBar extends GetView<RootController> {
  const AppBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = controller.menuData
        .map(
          (e) => BottomNavigationBarItem(
            label: e.name.tr,
            icon: Obx(
              () => Container(
                width: 40,
                height: 40,
                padding: EdgeInsets.all(10.h),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: (e.idNav == controller.selectedNav.value)
                        ? [Styles.blue5, Styles.blue3]
                        : [Colors.transparent, Colors.transparent],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                  ),
                ),
                child: Image.asset(
                  e.icon,
                  width: 24,
                  height: 24,
                  color: (e.idNav == controller.selectedNav.value)
                      ? Colors.white
                      : Styles.grey10,
                ),
              ),
            ),
          ),
        )
        .toList();
    return Obx(
      () => BottomNavigationBar(
        items: items,
        elevation: 8,
        iconSize: 18,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: controller.onTapNav,
        currentIndex: controller.selectedNav.value,
        selectedItemColor: Styles.blue4,
        unselectedItemColor: Styles.grey10,
        unselectedLabelStyle: Styles.smallTextSemi(),
        selectedLabelStyle: Styles.smallTextSemi(),
      ),
    );
  }
}
