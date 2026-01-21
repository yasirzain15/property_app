import 'package:get/get.dart';
import '../../Controller/agency_details_controller.dart';

class AgencyDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AgencyDetailsController());
  }
}
