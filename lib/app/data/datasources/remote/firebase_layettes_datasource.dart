import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enxoval_baby/app/core/failures/app_failure.dart';
import 'package:enxoval_baby/app/core/result/result.dart';
import 'package:enxoval_baby/app/core/utils/error_messages_enum.dart';
import 'package:enxoval_baby/app/data/models/layette_model.dart';

class FirebaseLayettesDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseLayettesDatasource();

  Future<Result<Map<String, dynamic>>> getUserLayettes(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('layettes')
          .where('userId', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        log('Erro buscar dados do usuário: Registro não encontrado');
        return Result.error(FireStorageException(
            errorMessage:
                ErrorMessagesEnum.erroAoBuscarDadosDoUsuario.message));
      }

      final allDocs = querySnapshot.docs.map((d) => d.data()).toList();
      return Result.ok({'layettes': allDocs});
    } on Exception catch (e, stackTrace) {
      log('Erro loginGoogle: $e\nStackTrace: $stackTrace');
      rethrow;
    } catch (e, stackTrace) {
      log('Erro inesperado: $e\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  Future<Result<List<LayetteModel>>> fetchUserLayettes(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('layettes')
          .where('userId', isEqualTo: userId)
          .get();

      return Result.ok(snapshot.docs
          .map((doc) => LayetteModel.fromRemoteJson(doc.data()))
          .toList());
    } on Exception catch (e, stackTrace) {
      log('Erro fetchUserLayettes: $e\nStackTrace: $stackTrace');
      rethrow;
    } catch (e, stackTrace) {
      log('Erro inesperado: $e\nStackTrace: $stackTrace');
      rethrow;
    }
  }
    Future<Result<void>> upsertLayette(LayetteModel layette) async {
    try {
      final docRef = _firestore.collection('layettes').doc(layette.id);

      final data = {
        ...layette.toMap(), // inclui layetteProfile, categories, items
        'layetteId': layette.id,
        'userId': layette.userId,
        'remoteUpdatedAt': FieldValue.serverTimestamp(),
      };

      await docRef.set(data, SetOptions(merge: true));
      return  Result.ok(null);
    } on Exception catch (e, stackTrace) {
      log('Erro fetchUserLayettes: $e\nStackTrace: $stackTrace');
      rethrow;
    } catch (e, stackTrace) {
      log('Erro inesperado: $e\nStackTrace: $stackTrace');
      rethrow;
    }
  }
}

