import 'package:enxoval_baby/app/domain/entities/user_credential_entity.dart';
import 'package:enxoval_baby/app/domain/entities/user_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract class UserRepository {
  Future<UserCredentialEntity> getUser(String id);
  AsyncResult<bool> checkUserExists(String id);
  AsyncResult<Unit> createUser(UserEntity user);
  AsyncResult<Unit> updateUser(UserEntity user);
  AsyncResult<Unit> deleteUser(String id);
}