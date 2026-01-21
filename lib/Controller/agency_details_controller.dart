import 'package:get/get.dart';
import '../Models/agency_model.dart';

class AgencyDetailsController extends GetxController {
  late AgencyModel agency;

  @override
  void onInit() {
    super.onInit();
    agency = Get.arguments as AgencyModel;
  }
}
