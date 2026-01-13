import 'package:get/get.dart';

class GlobalLoaderController extends GetxController {
  RxBool isLoading = false.obs;

  void show() => isLoading.value = true;
  void hide() => isLoading.value = false;
}
