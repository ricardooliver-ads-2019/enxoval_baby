
import 'package:enxoval_baby/app/core/command/command.dart';
import 'package:enxoval_baby/app/core/result/result.dart';
import 'package:enxoval_baby/app/domain/entities/layette_profile_entity.dart';
import 'package:enxoval_baby/app/domain/repositories/layttes_repository.dart';
import 'package:flutter/material.dart';

class OnboardingLayetteCustomizationPageViewModel extends ChangeNotifier {
  final LayettesRepository _layettesRepository;

  OnboardingLayetteCustomizationPageViewModel({required LayettesRepository layettesRepository})
      : _layettesRepository = layettesRepository{
        fetchPersonalizedLayette = Command1<void, LayetteProfileEntity>(_fetchPersonalizedLayette);
      }

  late Command1<void, LayetteProfileEntity> fetchPersonalizedLayette;

  Future<Result<void>> _fetchPersonalizedLayette(LayetteProfileEntity layetteProfile) async {
   return await _layettesRepository.fetchPersonalizedLayette(layetteProfile);
  }

}