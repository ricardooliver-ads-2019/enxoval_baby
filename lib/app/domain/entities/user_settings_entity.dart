import 'package:equatable/equatable.dart';

class UserSettingsEntity extends Equatable {
  final String theme;
  final bool notificationsEnabled;
  final bool isPremium;

  const UserSettingsEntity({
    required this.theme,
    required this.notificationsEnabled,
    required this.isPremium,
  });

  @override
  List<Object> get props => [theme, notificationsEnabled, isPremium];
}