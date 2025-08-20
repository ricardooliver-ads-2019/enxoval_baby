// layette_model.dart
import 'package:enxoval_baby/app/core/utils/generate_id.dart';
import 'package:enxoval_baby/app/data/models/category_model.dart';
import 'package:enxoval_baby/app/data/models/layette_profile_model.dart';
import 'package:enxoval_baby/app/domain/entities/layette_entity.dart';


class LayetteModel extends LayetteEntity {
  const LayetteModel({
    required super.id,
    required super.userId,
    super.nameBaby,
    required super.layetteProfile,
    // required super.globalProgress,
    // required super.totalSpentAll,
    // required super.totalNeededAll,
    // required super.totalPurchasedAll,
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
      userId: json['userId'],
      nameBaby: json['nameBaby'],
      layetteProfile: LayetteProfileModel.fromJson(json['layetteProfile']),
      updatedAt: now,
      categories: CategoryModel.listMapCategories(json['categories'], id),
      syncStatus: 1,
    );
  }

  factory LayetteModel.fromDbMap(Map<String, dynamic> m) => LayetteModel(
        id: m['id'] as String,
        userId: m['userId'] as String,
        nameBaby: m['nameBaby'] as String?,
        layetteProfile: LayetteProfileModel.fromJson(m['layetteProfile']),
        updatedAt: (m['updatedAt'] ?? 0) as int,
        syncStatus: (m['syncStatus'] ?? 1) as int,
        categories: CategoryModel.listMapCategoriesDb(m['categories'] ?? []),
      );

  Map<String, dynamic> toDbMap() => {
        'id': id,
        'userId': userId,
        'nameBaby': nameBaby,
        'layetteProfile': (layetteProfile as LayetteProfileModel).toMap(),
        'globalProgress': globalProgress,
        'totalSpentAll': totalSpentAll,
        'totalNeededAll': totalNeededAll,
        'totalPurchasedAll': totalPurchasedAll,
        'updatedAt': updatedAt,
        'syncStatus': syncStatus,
        'categories': categories.map((category) => (category as CategoryModel).toDbMap()).toList(),
      };
      
  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'nameBaby': nameBaby,
        'layetteProfile': (layetteProfile as LayetteProfileModel).toMap(),
        'globalProgress': globalProgress,
        'totalSpentAll': totalSpentAll,
        'totalNeededAll': totalNeededAll,
        'totalPurchasedAll': totalPurchasedAll,
        'updatedAt': updatedAt,
        'syncStatus': syncStatus,
        'categories': categories.map((category) => (category as CategoryModel).toMap()).toList(),
      };
}
