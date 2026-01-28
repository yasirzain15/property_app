import 'package:get/get.dart';
import '../Models/agency_model.dart';
import '../Models/project_property_model.dart';
import '../Core/Constants/app_assets.dart';
import '../Core/Routes/app_routes.dart';

class ProjectPropertiesController extends GetxController {
  late PropertyProjectModel project;

  final properties = <ProjectPropertyModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    /// ✅ RECEIVE PROJECT MODEL (NOT MAP)
    project = Get.arguments as PropertyProjectModel;

    _loadDummyProperties();
  }

  /// 🔹 Dummy apartments / flats inside a project
  void _loadDummyProperties() {
    properties.assignAll([
      ProjectPropertyModel(
        id: '1',
        title: '${project.title} - Apartment 101',
        price: '\$120,000',
        image: AppAssets.house1,
      ),
      ProjectPropertyModel(
        id: '2',
        title: '${project.title} - Apartment 102',
        price: '\$135,000',
        image: AppAssets.house2,
      ),
      ProjectPropertyModel(
        id: '3',
        title: '${project.title} - Apartment 103',
        price: '\$150,000',
        image: AppAssets.house3,
      ),
    ]);
  }

  /// 🔹 Navigate to property detail
  void openPropertyDetail(ProjectPropertyModel property) {
    Get.toNamed(
      AppRoutes.propertyDetail,
      arguments: {
        'title': property.title,
        'price': property.price,
        'images': [property.image],
      },
    );
  }
}
