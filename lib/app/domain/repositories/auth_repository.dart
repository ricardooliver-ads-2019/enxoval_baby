import 'package:enxoval_baby/app/domain/entities/user_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class AuthRepository {
  Stream<UserEntity?> get authStateChanges;
  AsyncResult<UserEntity> login({
    required String email,
    required String password,
  });
}
