import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureUserStorage {
  static const _kUserId = 'current_user_id';
  static const _kEmail = 'current_user_email';
  static const _kName = 'current_user_name';
  static const _kPhoto = 'current_user_photo';
  static const _kTheme = 'current_user_theme';
  static const _kPremium = 'current_user_premium';
  static const _kNotificationsEnabled = 'current_user_notifications_enabled';

  final FlutterSecureStorage _secure = const FlutterSecureStorage();

  Future<void> saveCurrentUser({
    required String id,
    String? email,
    String? name,
    String? photoUrl,
    String? theme,
    bool? isPremium,
    bool? isNotificationsEnabled,
  }) async {
    await _secure.write(key: _kUserId, value: id);
    if (email != null) await _secure.write(key: _kEmail, value: email);
    if (name != null) await _secure.write(key: _kName, value: name);
    if (photoUrl != null) await _secure.write(key: _kPhoto, value: photoUrl);
    if (theme != null) await _secure.write(key: _kTheme, value: theme);
    if (isPremium != null) {
      await _secure.write(key: _kPremium, value: isPremium ? '1' : '0');
    }
    if (isNotificationsEnabled != null) {
      await _secure.write(key: _kNotificationsEnabled, value: isNotificationsEnabled ? '1' : '0');
    }
  }

  Future<String?> getCurrentUserId() => _secure.read(key: _kUserId);

  Future<bool> hasActiveSession() async => (await _secure.read(key: _kUserId)) != null;

  Future<void> clear() async {
    await _secure.delete(key: _kUserId);
    await _secure.delete(key: _kEmail);
    await _secure.delete(key: _kName);
    await _secure.delete(key: _kPhoto);
    await _secure.delete(key: _kPremium);
    await _secure.delete(key: _kNotificationsEnabled);
    await _secure.delete(key: _kTheme);
  }
}
