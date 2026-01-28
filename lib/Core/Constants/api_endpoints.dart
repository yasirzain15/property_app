class ApiEndpoints {
  static const String login = "/login";
  static const String logout = "/customer/logout";
  static const String customerProperties = "/customer/property";

  static const String profile = "/customer/profile";
  static const String updateProfile = "/customer/update";
  static const String changePassword = "/customer/change-password";

  static const String projects = "/projects";
  static String projectDetail(String id) => "/projects/detail/$id";
  static String projectProperties(String id) => "/projects/properties/$id";

  static const String properties = "/properties";
}
