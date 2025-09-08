
import 'package:enxoval_baby/app/core/result/result.dart';
import 'package:enxoval_baby/app/core/result/result_extensions.dart';
import 'package:enxoval_baby/app/domain/repositories/layttes_repository.dart';

class HasCompletedOnboardingLayetteCustomizationUsecase {
  final LayettesRepository _layettesRepository;

  HasCompletedOnboardingLayetteCustomizationUsecase({
    required LayettesRepository layettesRepository,
  }) : _layettesRepository = layettesRepository;

  Future<Result<bool>> call() async {
    final result = await _layettesRepository.getUserLayettes();
    return result.fold(
      (layettes) => Result.ok(layettes.isNotEmpty),
      (failure) => Result.error(failure),
    );

  }
}