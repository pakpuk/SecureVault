import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PasswordService {
  static final _storage = const FlutterSecureStorage();
  static const _keyStorageKey = 'encryption_key';

  static Future<String> _getKey() async {
    String? storedKey = await _storage.read(key: _keyStorageKey);

    if (storedKey == null) {
      final key = Key.fromSecureRandom(32); // 256-bit
      final base64Key = key.base64;
      await _storage.write(key: _keyStorageKey, value: base64Key);
      return base64Key;
    }

    return storedKey;
  }

  static Future<String> encrypt(String plainText) async {
    final keyString = await _getKey();
    final key = Key.fromBase64(keyString);
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(plainText, iv: iv);

    return encrypted.base64;
  }

  static Future<String> decrypt(String encryptedText) async {
    final keyString = await _getKey();
    final key = Key.fromBase64(keyString);
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));
    final decrypted = encrypter.decrypt64(encryptedText, iv: iv);

    return decrypted;
  }
}
