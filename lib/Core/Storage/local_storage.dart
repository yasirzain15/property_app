import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static final _box = GetStorage();

  static const _tokenKey = 'auth_token';

  static void saveToken(String token) {
    _box.write(_tokenKey, token);
  }

  static String? getToken() {
    return _box.read(_tokenKey);
  }

  static void clearToken() {
    _box.remove(_tokenKey);
  }

  static bool get isLoggedIn => getToken() != null;
}
