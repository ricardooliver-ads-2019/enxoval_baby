
import 'package:enxoval_baby/app/core/commands/command.dart';
import 'package:enxoval_baby/app/core/failures/app_failure.dart';
import 'package:enxoval_baby/app/domain/entities/layette_profile_entity.dart';
import 'package:enxoval_baby/app/domain/repositories/layttes_repository.dart';
import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';

class OnboardingLayetteCustomizationPageViewModel extends ChangeNotifier {
  final LayettesRepository _layettesRepository;

  OnboardingLayetteCustomizationPageViewModel({required LayettesRepository layettesRepository})
      : _layettesRepository = layettesRepository{
        fetchPersonalizedLayette = Command1<Unit, LayetteProfileEntity>(_fetchPersonalizedLayette);
      }

  late Command1<Unit, LayetteProfileEntity> fetchPersonalizedLayette;
  String? erroMensage;

  Future<Result<Unit>> _fetchPersonalizedLayette(LayetteProfileEntity layetteProfile) async {
    final result = await _layettesRepository.fetchPersonalizedLayette(layetteProfile);
    result.fold((onSuccess){}, (onError){
      erroMensage = (onError as AppFailure).errorMessage;
    });
    notifyListeners();
    return result.map((_) => unit);
  }

}