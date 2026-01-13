import 'package:get/get.dart';
import 'package:rent_pay/Controller/global_loader_controller.dart';

class GlobalLoader {
  static final GlobalLoaderController _controller =
      Get.find<GlobalLoaderController>();

  static void show() => _controller.show();
  static void hide() => _controller.hide();
}
