// category_model.dart
import 'package:enxoval_baby/app/core/utils/generate_id.dart';
import 'package:enxoval_baby/app/data/models/item_model.dart';
import 'package:enxoval_baby/app/domain/entities/category_entity.dart';


class CategoryModel extends CategoryEntity {
  const CategoryModel({required super.id,
    required super.layetteId,
    required super.name,
    super.icon,
    super.isCustom,
    required super.updatedAt,
    super.syncStatus,
    required super.items,
  });

  factory CategoryModel.fromRemoteJson(Map<String, dynamic> json, String layetteId) {
    final uuid = GenerateId.newId();
    final now = DateTime.now().millisecondsSinceEpoch;
    return CategoryModel(
      id: json['categoryId'] ?? uuid,
      layetteId: layetteId,
      name: json['name'],
      icon: json['icon'],
      isCustom: json['isCustom'] as bool,
      updatedAt: now,
      syncStatus: 1,
      items: ItemModel.listMapItems(json['items'], uuid),
    );
  }

  factory CategoryModel.fromDbMap(Map<String, dynamic> m) => CategoryModel(
        id: m['id'] as String,
        layetteId: m['layetteId'] as String,
        name: m['name'] as String,
        icon: m['icon'] as String?,
        isCustom: (m['isCustom'] ?? 0) == 1,
        updatedAt: (m['updatedAt'] ?? 0) as int,
        syncStatus: (m['syncStatus'] ?? 1) as int,
        items: const [],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'layetteId': layetteId,
        'name': name,
        'icon': icon,
        'progress': progress,
        'isCustom': isCustom,
        'totalNeeded': totalNeeded,
        'totalPurchased': totalPurchased,
        'totalSpent': totalSpent,
        'updatedAt': updatedAt,
        'syncStatus': syncStatus,
        'items': items.map((item) => (ItemModel(
              categoryId: item.categoryId,
              id: item.id,
              name: item.name,
              priority: item.priority,
              quantityNeeded: item.quantityNeeded,
              quantityPurchased: item.quantityPurchased,
              icon: item.icon,
              isCustom: item.isCustom,
              isPresente: item.isPresente,
              value: item.value,
              notesItems: item.notesItems,
              notesUser: item.notesUser,
              purchaseLink: item.purchaseLink,
              syncStatus: item.syncStatus,
              updatedAt: item.updatedAt,
            )).toMap()).toList(),
      };

  Map<String, dynamic> toDbMap() => {
        'id': id,
        'layetteId': layetteId,
        'name': name,
        'icon': icon,
        'progress': progress,
        'isCustom': isCustom ? 1 : 0,
        'totalNeeded': totalNeeded,
        'totalPurchased': totalPurchased,
        'totalSpent': totalSpent,
        'updatedAt': updatedAt,
        'syncStatus': syncStatus,
      };

  static List<CategoryEntity> listMapCategories(List<dynamic> lista, String layetteId) {
    return lista
        .cast<Map<String, dynamic>>()
        .map(
          (json) => CategoryModel.fromRemoteJson(json, layetteId),
        )
        .toList();
  }

  static List<CategoryEntity> listMapCategoriesDb(List<dynamic> lista) {
    return lista
        .cast<Map<String, dynamic>>()
        .map(
          (map) => CategoryModel.fromDbMap(map),
        )
        .toList();
  }
}
