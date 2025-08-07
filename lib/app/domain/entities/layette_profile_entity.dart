import 'package:enxoval_baby/app/core/utils/enums/climate_enum.dart';
import 'package:enxoval_baby/app/core/utils/enums/expected_baby_size_enum.dart';
import 'package:enxoval_baby/app/core/utils/enums/sex_baby_enum.dart';
import 'package:equatable/equatable.dart';

class LayetteProfileEntity extends Equatable {
  final DateTime dueDate;
  final double totalBudget;
  final ClimateEnum climate;
  final SexBabyEnum sexBaby;
  final int numberOfBabies;
  final String familyProfile; // Ex: "minimalista", "tradicional", "moderno"
  final int layetteDurationInMonths;
  final double totalNeededAll;
  final ExpectedBabySizeEnum expectedBabySize;

  const LayetteProfileEntity({
    required this.dueDate,
    required this.totalBudget,
    required this.climate,
    required this.sexBaby,
    required this.numberOfBabies,
    required this.familyProfile,
    required this.layetteDurationInMonths,
    required this.totalNeededAll,
    required this.expectedBabySize,
  });

  @override
  List<Object?> get props => [
        dueDate,
        totalBudget,
        climate,
        sexBaby,
        numberOfBabies,
        familyProfile,
        layetteDurationInMonths,
        totalNeededAll,
        expectedBabySize,
      ];
}

