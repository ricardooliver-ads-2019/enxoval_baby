
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enxoval_baby/app/core/failures/app_failure.dart';
import 'package:enxoval_baby/app/core/result/result.dart';
import 'package:enxoval_baby/app/core/utils/error_messages_enum.dart';
import 'package:enxoval_baby/app/data/models/user_model.dart';

class FirebaseUserDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Result<Map<String, dynamic>>> getUser(String id) async {
    try {
      final doc = await _firestore.collection('users').doc(id).get();
      if (!doc.exists) {
        log('Erro buscar dados do usuário: Registro não encontrado');
        return Result.error(FireStorageException(
            errorMessage: ErrorMessagesEnum.erroAoBuscarDadosDoUsuario.message));
      }
      return Result.ok(doc.data()!);

    } on Exception catch (e, stackTrace) {
      log('Erro register: $e\nStackTrace: $stackTrace');
      rethrow;
    } catch (e, stackTrace) {
      log('Erro inesperado: $e\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  Future<Result<bool>> checkUserExists(String id) async {
    try {
      final doc = await _firestore.collection('users').doc(id).get();

      if (!doc.exists) {
        log('Erro buscar dados do usuário: Registro não encontrado');
        return Result.ok(false);
      }
      return Result.ok(true);

    } on Exception catch (e, stackTrace) {
      log('Erro register: $e\nStackTrace: $stackTrace');
      rethrow;
    } catch (e, stackTrace) {
      log('Erro inesperado: $e\nStackTrace: $stackTrace');
      rethrow;
    }
  }


  Future<Result<void>> createUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toMap());
      return Result.ok(null);
    } on Exception catch (e, stackTrace) {
      log('Erro createUser: $e\nStackTrace: $stackTrace');
      rethrow;
    } catch (e, stackTrace) {
      log('Erro inesperado: $e\nStackTrace: $stackTrace');
      rethrow;
    }
  }


  Future<Result<void>> updateUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).update(user.toMap());
      return Result.ok(null);
    } on Exception catch (e, stackTrace) {
      log('Erro updateUser: $e\nStackTrace: $stackTrace');
      rethrow;
    } catch (e, stackTrace) {
      log('Erro inesperado: $e\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  Future<Result<void>> deleteUser(String id) async {
    try {
      await _firestore.collection('users').doc(id).delete();
      return Result.ok(null);
    } on Exception catch (e, stackTrace) {
      log('Erro deleteUser: $e\nStackTrace: $stackTrace');
      rethrow;
    } catch (e, stackTrace) {
      log('Erro inesperado: $e\nStackTrace: $stackTrace');
      rethrow;
    }
  }
  
}