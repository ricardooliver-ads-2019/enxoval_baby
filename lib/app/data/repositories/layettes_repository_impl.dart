import 'package:enxoval_baby/app/core/handler/exception_handler.dart';
import 'package:enxoval_baby/app/core/result/result.dart';
import 'package:enxoval_baby/app/core/result/result_extensions.dart';
import 'package:enxoval_baby/app/data/datasources/local/secure_user_storage.dart';
import 'package:enxoval_baby/app/data/datasources/local/local_layettes_datasource.dart';
import 'package:enxoval_baby/app/data/datasources/remote/firebase_layettes_datasource.dart';
import 'package:enxoval_baby/app/data/datasources/remote/generic_layettes_datasource.dart';
import 'package:enxoval_baby/app/data/models/category_model.dart';
import 'package:enxoval_baby/app/data/models/item_model.dart';
import 'package:enxoval_baby/app/data/models/layette_model.dart';
import 'package:enxoval_baby/app/domain/entities/layette_entity.dart';
import 'package:enxoval_baby/app/domain/entities/layette_profile_entity.dart';
import 'package:enxoval_baby/app/domain/repositories/layttes_repository.dart';

class LayettesRepositoryImpl implements LayettesRepository {
  final GenericLayettesDatasource _genericLayettesDatasource;
  final FirebaseLayettesDatasource _firebaseLayettesDatasource;
  final LocalLayettesDatasource _localLayettesDatasource;
  final SecureUserStorage _session;
  final ExceptionHandler _handler;

  LayettesRepositoryImpl({
    required ExceptionHandler handler,
    required GenericLayettesDatasource genericLayettesdataSource,
    required FirebaseLayettesDatasource firebaseLayettesDatasource,
    required LocalLayettesDatasource localLayettesDatasource,
    required SecureUserStorage session,
  })  : _genericLayettesDatasource = genericLayettesdataSource,
        _firebaseLayettesDatasource = firebaseLayettesDatasource,
        _localLayettesDatasource = localLayettesDatasource,
        _session = session,
        _handler = handler;

  @override
Future<Result<LayetteEntity>> fetchPersonalizedLayette(
  LayetteProfileEntity profile,
) async {
  try {
    final userId = await _session.getCurrentUserId();
    if (userId == null) {
      return Result.error(
        _handler.handle(
          Exception('Sessão inválida: usuário não logado'),
          StackTrace.current,
        ),
      );
    }

    final genericRes =
        await _genericLayettesDatasource.fetchGenericLayette(profile);

    return await genericRes.fold(
      // OK
      (json) async {
        try {
          // monta o layette base
          final layette = LayetteModel.fromRemoteJsonT(
            json: json,
            layetteProfile: profile,
            userId: userId,
          );

          // pegue as categorias do próprio layette
          final categories = layette.categories.cast<CategoryModel>();

          // “achate” os itens garantindo que cada um já tem categoryId correto
          final items = <ItemModel>[
            for (final c in categories) ...c.items.cast<ItemModel>(),
          ];

          // 1) Salva no Firebase
          final upsertRemote = await _firebaseLayettesDatasource.upsertLayette(layette);
          if (upsertRemote.isError) {
            final err = upsertRemote.asError.error;
            return Result.error(
              _handler.handle( err, StackTrace.current),
            );
          }

          // salva normalizado (transação db local)
          await _localLayettesDatasource.upsertAggregate(
            layette: layette,
            categories: categories,
            items: items,
          );

          return Result.ok(layette);
        } catch (e, st) {
          return Result.error(
            _handler.handle( Exception('$e'), st),
          );
        }
      },
      // ERRO remoto
      (err) async => Result.error(
        _handler.handle(err, StackTrace.current),
      ),
    );
  } catch (e, st) {
    // Nunca lance String; normalize pelo handler
    return Result.error(
      _handler.handle(e is Exception ? e : Exception('$e'), st),
    );
  }
}

  /// Estratégia: LOCAL → REMOTO (fallback) → cache no LOCAL
  @override
Future<Result<List<LayetteEntity>>> getUserLayettes() async {
  try {
    final userId = await _session.getCurrentUserId();
    if (userId == null) {
      return Result.error(
        _handler.handle(
          Exception('Sessão inválida: usuário não logado'),
          StackTrace.current,
        ),
      );
    }

    // 1) Local agregado (com categorias/itens)
    try {
      final local = await _localLayettesDatasource
          .fetchUserLayettesWithChildren(userId); // <-- use o AGREGADO
      if (local.isNotEmpty) return Result.ok(local);
    } on Exception catch (e, st) {
    return Result.error(_handler.handle(e, st));
  } catch (e, st) {
    return Result.error(_handler.handle(e is Exception ? e : Exception('$e'), st));
  }

    // 2) Fallback remoto (se aplicável)
    final remoteRes = await _firebaseLayettesDatasource.fetchUserLayettes(userId);

    return await remoteRes.fold(
      (remote) async {
        // se precisar cachear, faça aqui (agregado ou base, conforme retorno)
        return Result.ok(remote);
      },
      (err) async => Result.error(_handler.handle(err, StackTrace.current)),
    );
  } on Exception catch (e, st) {
    return Result.error(_handler.handle(e, st));
  } catch (e, st) {
    return Result.error(_handler.handle(e is Exception ? e : Exception('$e'), st));
  }
}

  // Future<Result<String>> _getUserId() async {
  //   try {
  //     final userId = await _session.getCurrentUserId();
  //     if (userId == null) {
  //       return Result.error(
  //         _handler.handle(
  //           Exception('Sessão inválida: usuário não logado'),
  //           StackTrace.current,
  //         ),
  //       );
  //     }
  //     return Result.ok(userId);
  //   } catch (e, st) {
  //     return Result.error(
  //       _handler.handle(e is Exception ? e : Exception('$e'), st),
  //     );
  //   }
  // }
}
