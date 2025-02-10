import 'package:enxoval_baby/app/core/utils/failures/failure.dart' as app;
import 'package:enxoval_baby/app/data/datasources/remote/firebase_auth_datasource.dart';
import 'package:enxoval_baby/app/data/models/user_model.dart';
import 'package:enxoval_baby/app/domain/entities/user_entity.dart';
import 'package:enxoval_baby/app/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:result_dart/result_dart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDatasource _authDataSource;
  AuthRepositoryImpl({
    required FirebaseAuthDatasource auth,
  })  : _authDataSource = auth,
        super();

  @override
  Stream<UserEntity?> get authStateChanges =>
      _authDataSource.authStateChanges.map((user) {
        return user != null ? UserModel.fromFirebase(user) : null;
      });

  @override
  AsyncResult<UserEntity> login({
    required String email,
    required String password,
  }) async {
    try {
      final result =
          await _authDataSource.login(email: email, password: password);
      return result.map(UserModel.fromFirebase);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Failure(
            app.AuthException(errorMessage: 'Email não encontrado!'));
      } else if (e.code == 'wrong-password') {
        return Failure(app.AuthException(errorMessage: 'Senha incorreta!'));
      } else {
        throw ('Senha incorreta!');
      }
    } catch (e) {
      throw ('Senha incorreta!');
    }
  }
}
