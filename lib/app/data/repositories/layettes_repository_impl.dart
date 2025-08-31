import 'package:enxoval_baby/app/core/handler/exception_handler.dart';
import 'package:enxoval_baby/app/core/utils/error_messages_enum.dart';
import 'package:enxoval_baby/app/data/datasources/remote/generic_layettes_datasource.dart';
import 'package:enxoval_baby/app/data/models/layette_model.dart';
import 'package:enxoval_baby/app/domain/entities/layette_entity.dart';
import 'package:enxoval_baby/app/domain/entities/layette_profile_entity.dart';
import 'package:enxoval_baby/app/domain/repositories/layttes_repository.dart';
import 'package:result_dart/result_dart.dart';

class LayettesRepositoryImpl implements LayettesRepository {
  final GenericLayettesDatasource _genericLayettesDatasource;
  final ExceptionHandler _handler;
  LayettesRepositoryImpl({
    required ExceptionHandler handler,
    required GenericLayettesDatasource dataSource,
  })  : _genericLayettesDatasource = dataSource,
        _handler = handler;

  @override
  AsyncResult<LayetteEntity> fetchPersonalizedLayette(LayetteProfileEntity profile) async {
    try {
      final result = await _genericLayettesDatasource.fetchGenericLayette(profile);
      final layette = LayetteModel.fromRemoteJsonT(result.getOrThrow(), profile);
      return Success(layette);
    } on Exception catch (e, stack) {
      return Failure(_handler.handle(e, stack));
    } catch (e) {
      throw ErrorMessagesEnum.erroDesconhecido.message;
    }
  }
}
