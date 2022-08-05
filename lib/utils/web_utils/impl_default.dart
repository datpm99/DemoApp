import 'dart:io';

abstract class WebUtilsImpl {
  static void removeLoader() {}

  static bool isSimulator() {
    return !Platform.resolvedExecutable.startsWith('/private/var/');
  }
}
