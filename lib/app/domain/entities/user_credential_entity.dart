import 'package:equatable/equatable.dart';

class UserCredentialEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? image;

  const UserCredentialEntity({
    required this.id,
    required this.name,
    required this.email,
    this.image,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        image,
      ];
}
