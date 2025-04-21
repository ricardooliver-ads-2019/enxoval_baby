import 'package:equatable/equatable.dart';

class UserCredentialDto extends Equatable {
  final String email;
  final String password;

  const UserCredentialDto({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}
