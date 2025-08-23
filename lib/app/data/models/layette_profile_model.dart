import 'package:enxoval_baby/app/core/utils/enums/climate_enum.dart';
import 'package:enxoval_baby/app/core/utils/enums/sex_baby_enum.dart';
import 'package:enxoval_baby/app/domain/entities/layette_profile_entity.dart';

class LayetteProfileModel  extends LayetteProfileEntity{

  const LayetteProfileModel({
    required super.dueDate,
    required super.climate,
    required super.sexBaby,
    required super.nameBaby,
    required super.familyProfile,
    required super.layetteDurationInMonths,
  });

  factory LayetteProfileModel.fromJson(Map<String, dynamic> json) {
    return LayetteProfileModel(
      dueDate: DateTime.parse(json['dueDate']),
      climate: ClimateEnum.fromString(json['climate']),
      sexBaby: SexBabyEnum.fromString(json['sexBaby']),
      familyProfile: json['familyProfile'] as String,
      nameBaby: json['nameBaby'] as String?,
      layetteDurationInMonths: json['layetteDurationInMonths'] as int,
      
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dueDate': dueDate?.toIso8601String(),
      'climate': climate.name,
      'sexBaby': sexBaby.name,
      'nameBaby': nameBaby,
      'familyProfile': familyProfile,
      'layetteDurationInMonths': layetteDurationInMonths,

    };
  }
}

