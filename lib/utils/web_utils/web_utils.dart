import 'impl_web.dart' if (dart.library.io) 'impl_default.dart';

abstract class WebUtils {
  static void removeLoader() => WebUtilsImpl.removeLoader();

  static bool get isSimulator => WebUtilsImpl.isSimulator();
}
