class AgencyModel {
  final String name;
  final String image;
  final List<PropertyProjectModel> projects;

  AgencyModel({
    required this.name,
    required this.image,
    required this.projects,
  });
}

class PropertyProjectModel {
  final String image;
  final String title;
  final String beds;
  final String price;

  PropertyProjectModel({
    required this.image,
    required this.title,
    required this.beds,
    required this.price,
  });
}
