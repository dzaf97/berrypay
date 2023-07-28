import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
// final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  // Create storage
  final storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      ));

  final String _keyUserName = 'username';
  final String _keyPassWord = 'password';
  final String _keyIslogin = 'false';
  final String _keyName = 'name';
  final String _refreshToken = 'refreshToken';
  final String _fcmToken = 'fcmToken';

  Future setRefreshToken(String refreshToken) async {
    await storage.write(key: _refreshToken, value: refreshToken);
  }

  Future<String?> getRefreshToken() async {
    return await storage.read(key: _refreshToken);
  }

  Future setUserName(String username) async {
    await storage.write(key: _keyUserName, value: username);
  }

  Future<String?> getUserName() async {
    return await storage.read(key: _keyUserName);
  }

  Future setPassWord(String password) async {
    await storage.write(key: _keyPassWord, value: password);
  }

  Future<String?> getPassWord() async {
    return await storage.read(key: _keyPassWord);
  }

  Future setIslogin(String islogin) async {
    await storage.write(key: _keyIslogin, value: islogin);
  }

  Future<String?> getIslogin() async {
    return await storage.read(key: _keyIslogin);
  }

  Future setName(String name) async {
    await storage.write(key: _keyName, value: name);
  }

  Future<String?> getName() async {
    return await storage.read(key: _keyName);
  }

  Future setFcmToken(String fcmToken) async {
    await storage.write(key: _fcmToken, value: fcmToken);
  }

  Future<String?> getFcmToken() async {
    return await storage.read(key: _fcmToken);
  }

  Future deleteFcmToken() async {
    await storage.delete(key: _fcmToken);
  }

  Future<void> deleteAll() async {
    await storage.deleteAll();
  }
}
