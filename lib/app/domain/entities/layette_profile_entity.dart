import 'package:enxoval_baby/app/core/utils/enums/climate_enum.dart';
import 'package:enxoval_baby/app/core/utils/enums/sex_baby_enum.dart';
import 'package:equatable/equatable.dart';

class LayetteProfileEntity extends Equatable {
  final DateTime? dueDate;
  final ClimateEnum climate;
  final SexBabyEnum sexBaby;
  final String? nameBaby;
  final String? familyProfile; // Ex: "minimalista", "tradicional", "moderno"
  final int layetteDurationInMonths;


  const LayetteProfileEntity({
    this.dueDate,
    required this.climate,
    required this.sexBaby,
    this.nameBaby,
    this.familyProfile,
    required this.layetteDurationInMonths,
  });

  @override
  List<Object?> get props => [
        dueDate,
        climate,
        sexBaby,
        familyProfile,
        layetteDurationInMonths,
        nameBaby,
      ];
}

