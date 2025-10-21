import 'package:enxoval_baby/app/core/utils/enums/climate_enum.dart';
import 'package:enxoval_baby/app/core/utils/enums/sex_baby_enum.dart';
import 'package:enxoval_baby/app/core/utils/generate_id.dart';
import 'package:enxoval_baby/app/data/models/category_model.dart';
import 'package:enxoval_baby/app/data/models/layette_profile_model.dart';
import 'package:enxoval_baby/app/domain/entities/layette_entity.dart';
import 'package:enxoval_baby/app/domain/entities/layette_profile_entity.dart';

class LayetteModel extends LayetteEntity {
  const LayetteModel({
    required super.id,
    required super.userId,
    required super.layetteProfile,
    required super.updatedAt,
    super.syncStatus,
    required super.categories,
  });

  factory LayetteModel.fromRemoteJson(Map<String, dynamic> json) {
    final uuid = GenerateId.newId();
    final now = DateTime.now().millisecondsSinceEpoch;
    final id = json['layetteId'] ?? uuid;
    return LayetteModel(
      id: json['layetteId'] ?? uuid,
      userId: json['userId'] ?? '',
      //TODO: pensar em uma solução melhor para o userId quando não estiver presente
      layetteProfile: LayetteProfileModel.fromJson(json['layetteProfile']),
      updatedAt: now,
      categories: CategoryModel.listMapCategories(json['categories'], id),
      syncStatus: 1,
    );
  }
  factory LayetteModel.fromRemoteJsonT({
    required Map<String, dynamic> json,
    required LayetteProfileEntity layetteProfile,
    required String userId,
  }) {
    final uuid = GenerateId.newId();
    final now = DateTime.now().millisecondsSinceEpoch;
    final id = json['layetteId'] ?? uuid;
    return LayetteModel(
      id: json['layetteId'] ?? uuid,
      userId: userId,
      layetteProfile: layetteProfile,
      updatedAt: now,
      categories: CategoryModel.listMapCategories(json['categories'], id),
      syncStatus: 1,
    );
  }

  // LENDO do DB (reconstrói o profile a partir das colunas planas)
  factory LayetteModel.fromDbMap(Map<String, dynamic> m) {
    final profile = LayetteProfileModel(
      dueDate: (m['dueDate'] as int?) != null
          ? DateTime.fromMillisecondsSinceEpoch(m['dueDate'] as int)
          : null,
      climate: ClimateEnum.fromString(m['climate'] as String? ?? 'mild'),
      sexBaby: SexBabyEnum.fromString(m['sexBaby'] as String? ?? 'unknown'),
      nameBaby: m['nameBaby'] as String?,
      familyProfile: m['familyProfile'] as String?,
      layetteDurationInMonths:
          (m['layetteDurationInMonths'] as num?)?.toInt() ?? 0,
    );

    return LayetteModel(
      id: m['id'] as String,
      userId: m['userId'] as String,
      layetteProfile: profile,
      updatedAt: (m['updatedAt'] as num?)?.toInt() ?? 0,
      syncStatus: (m['syncStatus'] as num?)?.toInt() ?? 1,
      categories: const [], // itens/categorias via DAOs
    );
  }

  /// ESCREVENDO no banco (serializa Map/List para String JSON)
  Map<String, Object?> toDbMap() => {
        'id': id,
        'userId': userId,
        'nameBaby': layetteProfile.nameBaby,
        'sexBaby': layetteProfile.sexBaby.name,
        'dueDate': layetteProfile.dueDate?.millisecondsSinceEpoch,
        'climate': layetteProfile.climate.name,
        'familyProfile': layetteProfile.familyProfile,
        'layetteDurationInMonths': layetteProfile.layetteDurationInMonths,
        'globalProgress': globalProgress,
        'totalSpentAll': totalSpentAll,
        'totalNeededAll': totalNeededAll,
        'totalPurchasedAll': totalPurchasedAll,
        'updatedAt': updatedAt, // int epoch OK
        'syncStatus': syncStatus,
      }..removeWhere((_, v) => v == null);

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'layetteProfile': LayetteProfileModel(
          climate: layetteProfile.climate,
          dueDate: layetteProfile.dueDate,
          sexBaby: layetteProfile.sexBaby,
          nameBaby: layetteProfile.nameBaby,
          familyProfile: layetteProfile.familyProfile,
          layetteDurationInMonths: layetteProfile.layetteDurationInMonths,
        ).toMap(),
        'globalProgress': globalProgress,
        'totalSpentAll': totalSpentAll,
        'totalNeededAll': totalNeededAll,
        'totalPurchasedAll': totalPurchasedAll,
        'updatedAt': updatedAt,
        'syncStatus': syncStatus,
        'categories': categories
            .map((category) => (CategoryModel(
                  id: category.id,
                  layetteId: category.layetteId,
                  name: category.name,
                  icon: category.icon,
                  isCustom: category.isCustom,
                  updatedAt: category.updatedAt,
                  syncStatus: category.syncStatus,
                  items: category.items,
                )).toMap())
            .toList(),
      };
}
