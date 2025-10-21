import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enxoval_baby/app/data/models/user_settings_model.dart';
import 'package:enxoval_baby/app/domain/entities/user_entity.dart';
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.profilePhoto,
    required super.settings,
    required super.createdAt,
    required super.updatedAt,
  });

  /// Converte de Map/JSON para Model
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      profilePhoto: map['profilePhoto'] as String?,
      settings: UserSettingsModel.fromMap(map['settings'] as Map<String, dynamic>),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }

  /// Converte de DocumentSnapshot do Firestore
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel.fromMap(data);
  }

  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      profilePhoto: user.profilePhoto,
      settings: user.settings,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
  }

  /// Converte para Map/JSON
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profilePhoto': profilePhoto,
      'settings': (settings as UserSettingsModel).toMap(),
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}