import 'package:enxoval_baby/app/core/command/command.dart';
import 'package:enxoval_baby/app/core/failures/app_failure.dart';
import 'package:enxoval_baby/app/core/result/result.dart';
import 'package:enxoval_baby/app/core/result/result_extensions.dart';
import 'package:enxoval_baby/app/domain/entities/layette_entity.dart';
import 'package:enxoval_baby/app/domain/repositories/layttes_repository.dart';
import 'package:flutter/material.dart';

class HomeEnxovalViewModel extends ChangeNotifier {
  final LayettesRepository _layettesRepository;

  HomeEnxovalViewModel({
    required LayettesRepository layettesRepository,
  }) : _layettesRepository = layettesRepository {
    getUserLayettes = Command0(_getUserLayettes);
  }

  final layettes = <LayetteEntity>[];
  String? errorMessages;

  late Command0<List<LayetteEntity>> getUserLayettes;

  Future<Result<List<LayetteEntity>>> _getUserLayettes() async {
    final result = await _layettesRepository.getUserLayettes();
    result.fold(
      (lay) {
        layettes.clear();
        layettes.addAll(lay);
      },
      (error) {
        errorMessages = (error as AppFailure).errorMessage;
      },
    );
    notifyListeners();
    return result;
  }
}
