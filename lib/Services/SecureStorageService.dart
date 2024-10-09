import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<void> writeKey(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }

  Future<String?> readKey(String key) async {
    return await secureStorage.read(key: key);
  }

  Future<void> deleteKey(String key) async {
    await secureStorage.delete(key: key);
  }

  Future<void> deleteAllKeys() async {
    await secureStorage.deleteAll();
  }
}
