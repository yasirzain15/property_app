import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ApiService extends GetConnect {
  final GetStorage _storage = GetStorage();

  @override
  void onInit() {
    httpClient.baseUrl = "http://go.swiftbytes.io/api/v1"; // base URL only

    httpClient.timeout = const Duration(seconds: 30);

    httpClient.addRequestModifier<dynamic>((request) {
      final token = _storage.read('auth_token');

      if (token != null && token.toString().isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      request.headers['Accept'] = 'application/json';
      return request;
    });

    httpClient.addResponseModifier((request, response) {
      if (response.statusCode == 401) {
        _storage.remove('auth_token'); // make sure key matches token save
        Get.offAllNamed('/login');
      }
      return response;
    });

    super.onInit();
  }

  Future<Response> getRequest(String endpoint) async {
    return await get(endpoint);
  }

  Future<Response> postRequest(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    return await post(endpoint, body);
  }
}
