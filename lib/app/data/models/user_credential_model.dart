import 'package:enxoval_baby/app/domain/entities/user_credential_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserCredentialModel extends UserCredentialEntity {
  const UserCredentialModel({
    required super.id,
    required super.name,
    required super.email,
    super.image,
  });

  factory UserCredentialModel.fromFirebase(User user) {
    return UserCredentialModel(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      image: user.photoURL,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image': image,
    };
  }
}
