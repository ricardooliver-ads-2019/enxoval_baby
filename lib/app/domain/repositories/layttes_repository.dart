import 'package:enxoval_baby/app/domain/entities/layette_entity.dart';
import 'package:enxoval_baby/app/domain/entities/layette_profile_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class LayettesRepository {
  AsyncResult<LayetteEntity> fetchPersonalizedLayette(LayetteProfileEntity profile);
  
}