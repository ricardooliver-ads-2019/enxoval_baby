import 'package:enxoval_baby/app/core/handler/exception_handler.dart';
import 'package:enxoval_baby/app/core/utils/error_messages_enum.dart';
import 'package:enxoval_baby/app/data/datasources/remote/firebase_user_datasource.dart';
import 'package:enxoval_baby/app/data/models/user_model.dart';
import 'package:enxoval_baby/app/domain/entities/user_credential_entity.dart';
import 'package:enxoval_baby/app/domain/entities/user_entity.dart';
import 'package:enxoval_baby/app/domain/repositories/user_repository.dart';
import 'package:result_dart/result_dart.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseUserDatasource _dataSource;
  final ExceptionHandler _handler;
  UserRepositoryImpl({
    required ExceptionHandler handler,
    required FirebaseUserDatasource dataSource,
  })  : _dataSource = dataSource,
        _handler = handler;

  @override
  AsyncResult<bool> checkUserExists(String id) async {
    try {
      return await _dataSource.checkUserExists(id);
    } on Exception catch (e, stack) {
      return Failure(_handler.handle(e, stack));
    } catch (e) {
      throw ErrorMessagesEnum.erroDesconhecido.message;
    }
  }

  @override
  AsyncResult<Unit> createUser(UserEntity user) async {
    try {
      return await _dataSource.createUser(UserModel.fromEntity(user));
    } on Exception catch (e, stack) {
      return Failure(_handler.handle(e, stack));
    } catch (e) {
      throw ErrorMessagesEnum.erroDesconhecido.message;
    }
  }

  @override
  Future<UserCredentialEntity> getUser(String id) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  AsyncResult<Unit> updateUser(UserEntity user) async {
    try {
      return await _dataSource.updateUser(UserModel.fromEntity(user));
    } on Exception catch (e, stack) {
      return Failure(_handler.handle(e, stack));
    } catch (e) {
      throw ErrorMessagesEnum.erroDesconhecido.message;
    }
  }

  @override
  AsyncResult<Unit> deleteUser(String id) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }
}
