import 'package:enxoval_baby/app/domain/entities/user_settings_entity.dart';

class UserSettingsModel extends UserSettingsEntity {
  const UserSettingsModel({
    required super.theme,
    required super.notificationsEnabled,
    required super.isPremium,
  });

  factory UserSettingsModel.fromMap(Map<String, dynamic> map) {
    return UserSettingsModel(
      theme: map['theme'] as String,
      notificationsEnabled: map['notificationsEnabled'] as bool,
      isPremium: map['isPremium'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'theme': theme,
      'notificationsEnabled': notificationsEnabled,
      'isPremium': isPremium,
    };
  }
}


