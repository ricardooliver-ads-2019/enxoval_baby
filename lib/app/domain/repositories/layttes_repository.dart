import 'package:enxoval_baby/app/core/result/result.dart';
import 'package:enxoval_baby/app/domain/entities/layette_entity.dart';
import 'package:enxoval_baby/app/domain/entities/layette_profile_entity.dart';

abstract interface class LayettesRepository {
  Future<Result<LayetteEntity>> fetchPersonalizedLayette(LayetteProfileEntity profile);
  Future<Result<List<LayetteEntity>>> getUserLayettes();
}