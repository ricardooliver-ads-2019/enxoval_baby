import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? image;

  const UserEntity({
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
