import '/lang/lang_controller.dart';
import 'package:get/get.dart';
import 'api/common_api.dart';
import 'firebase/firebase_service.dart';
import 'storage/storage_service.dart';

abstract class AppServices {
  static Future<void> init() async {
    /// order matters.
    await Get.put(StorageService()).init();
    //await Get.put(FirebaseService()).init();
    await Get.put(CommonService()).init();
    Get.put(LangController());

    /// request for notifications permissions.
    //await FirebaseService.get().initFCM();

    /// request for DynamicLink.
    //await FirebaseService.get().initDynamicLink();
  }
}

abstract class BaseService {
  Future<void> init() async {}
}
