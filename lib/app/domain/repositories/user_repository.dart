import 'package:enxoval_baby/app/core/result/result.dart';
import 'package:enxoval_baby/app/domain/entities/user_credential_entity.dart';
import 'package:enxoval_baby/app/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Result<UserCredentialEntity>> getUser(String id);
  Future<Result<bool>> checkUserExists(String id);
  Future<Result<void>> createUser(UserEntity user);
  Future<Result<void>> updateUser(UserEntity user);
  Future<Result<void>> deleteUser(String id);
}