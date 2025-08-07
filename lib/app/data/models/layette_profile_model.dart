import 'package:enxoval_baby/app/core/utils/enums/climate_enum.dart';
import 'package:enxoval_baby/app/core/utils/enums/expected_baby_size_enum.dart';
import 'package:enxoval_baby/app/core/utils/enums/sex_baby_enum.dart';
import 'package:enxoval_baby/app/domain/entities/layette_profile_entity.dart';

class LayetteProfileModel  extends LayetteProfileEntity{

  const LayetteProfileModel({
    required super.dueDate,
    required super.totalBudget,
    required super.climate,
    required super.sexBaby,
    required super.numberOfBabies,
    required super.familyProfile,
    required super.layetteDurationInMonths,
    required super.totalNeededAll,
    required super.expectedBabySize,
  });

  factory LayetteProfileModel.fromJson(Map<String, dynamic> json) {
    return LayetteProfileModel(
      dueDate: DateTime.parse(json['dueDate']),
      totalBudget: (json['totalBudget'] as num).toDouble(),
      climate: ClimateEnum.fromString(json['climate']),
      sexBaby: SexBabyEnum.fromString(json['sexBaby']),
      numberOfBabies: json['numberOfBabies'] as int,
      familyProfile: json['familyProfile'] as String,
      layetteDurationInMonths: json['layetteDurationInMonths'] as int,
      totalNeededAll: (json['totalNeededAll'] as num).toDouble(),
      expectedBabySize: ExpectedBabySizeEnum.fromString(json['expectedBabySize']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dueDate': dueDate.toIso8601String(),
      'totalBudget': totalBudget,
      'climate': climate.name,
      'sexBaby': sexBaby.name,
      'numberOfBabies': numberOfBabies,
      'familyProfile': familyProfile,
      'layetteDurationInMonths': layetteDurationInMonths,
      'totalNeededAll': totalNeededAll,
      'expectedBabySize': expectedBabySize.name,
    };
  }
}

