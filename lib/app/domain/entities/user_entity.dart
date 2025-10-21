import 'package:enxoval_baby/app/domain/entities/user_settings_entity.dart';
import 'package:equatable/equatable.dart';
class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? profilePhoto; // opcional
  final UserSettingsEntity settings;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.profilePhoto,
    required this.settings,
    required this.createdAt,
    required this.updatedAt,
  });
  
  @override
  List<Object?> get props => [
        id,
        name,
        email,
        profilePhoto,
        settings,
        createdAt,
        updatedAt,
      ];
}


