
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enxoval_baby/app/core/failures/app_failure.dart';
import 'package:enxoval_baby/app/core/utils/error_messages_enum.dart';
import 'package:enxoval_baby/app/data/models/user_model.dart';
import 'package:result_dart/result_dart.dart';

class FirebaseUserDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AsyncResult<Map<String, dynamic>> getUser(String id) async {
    try {
      final doc = await _firestore.collection('users').doc(id).get();
      if (!doc.exists) {
        log('Erro buscar dados do usuário: Registro não encontrado');
        return Failure(FireStorageException(
            errorMessage: ErrorMessagesEnum.erroAoBuscarDadosDoUsuario.message));
      }
        return Success(doc.data()!);
      
    } on Exception catch (e, stackTrace) {
      log('Erro register: $e\nStackTrace: $stackTrace');
      rethrow;
    } catch (e, stackTrace) {
      log('Erro inesperado: $e\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  AsyncResult<bool> checkUserExists(String id) async {
    try {
      final doc = await _firestore.collection('users').doc(id).get();

      if (!doc.exists) {
        log('Erro buscar dados do usuário: Registro não encontrado');
        return const Success(false);
      }
        return const Success(true);
      
    } on Exception catch (e, stackTrace) {
      log('Erro register: $e\nStackTrace: $stackTrace');
      rethrow;
    } catch (e, stackTrace) {
      log('Erro inesperado: $e\nStackTrace: $stackTrace');
      rethrow;
    }
  }


  AsyncResult<Unit> createUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toMap());
      return const Success(unit);
    } on Exception catch (e, stackTrace) {
      log('Erro createUser: $e\nStackTrace: $stackTrace');
      rethrow;
    } catch (e, stackTrace) {
      log('Erro inesperado: $e\nStackTrace: $stackTrace');
      rethrow;
    }
  }


  AsyncResult<Unit> updateUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).update(user.toMap());
      return const Success(unit);
    } on Exception catch (e, stackTrace) {
      log('Erro updateUser: $e\nStackTrace: $stackTrace');
      rethrow;
    } catch (e, stackTrace) {
      log('Erro inesperado: $e\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  AsyncResult<Unit> deleteUser(String id) async {
    try {
      await _firestore.collection('users').doc(id).delete();
      return const Success(unit);
    } on Exception catch (e, stackTrace) {
      log('Erro deleteUser: $e\nStackTrace: $stackTrace');
      rethrow;
    } catch (e, stackTrace) {
      log('Erro inesperado: $e\nStackTrace: $stackTrace');
      rethrow;
    }
  }
  
}