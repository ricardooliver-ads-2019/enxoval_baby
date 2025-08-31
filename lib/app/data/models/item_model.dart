

import 'package:enxoval_baby/app/core/utils/generate_id.dart';
import 'package:enxoval_baby/app/domain/entities/item_entity.dart';

class ItemModel extends ItemEntity {
  const ItemModel({
    required super.id,
    required super.categoryId,
    required super.name,
    super.icon,
    required super.quantityNeeded,
    super.quantityPurchased,
    required super.priority,
    super.notesItems,
    super.notesUser,
    super.purchaseLink,
    super.isPresente,
    super.value,
    super.isCustom,
    required super.updatedAt,
    super.syncStatus,
  });

  factory ItemModel.fromRemoteJson(Map<String, dynamic> json, String categoryId) {
    final now = DateTime.now().millisecondsSinceEpoch;
    return ItemModel(
      id: json['itemId'] ?? GenerateId.newId(),
      categoryId: categoryId,
      name: json['name'] ?? '',
      icon: json['icon'],
      quantityNeeded: json['quantityNeeded'],
      quantityPurchased: json['quantityPurchased'],
      priority: json['priority'],
      notesItems: json['notesItems'],
      notesUser: json['notesUser'],
      purchaseLink: json['purchaseLink'],
      isPresente: json['isPresente'] ?? false,
      value: (json['value'] != null) ? ( (json['value'] as num).toInt() * 100 ) : 0,
      isCustom: json['isCustom'] ?? false,
      updatedAt: now,
      syncStatus: 1,
    );
  }

  factory ItemModel.fromDbMap(Map<String, dynamic> m) => ItemModel(
        id: m['id'] as String,
        categoryId: m['categoryId'] as String,
        name: m['name'] as String,
        icon: m['icon'] as String?,
        quantityNeeded: m['quantityNeeded'] as int,
        quantityPurchased: m['quantityPurchased']as int,
        priority: m['priority'] as String,
        notesItems: m['notesItems'] as String?,
        notesUser: m['notesUser'] as String?,
        purchaseLink: m['purchaseLink'] as String?,
        isPresente: (m['isPresente'] ?? 0) == 1,
        value: m['value'] as double?,
        isCustom: (m['isCustom'] ?? 0) == 1,
        updatedAt: (m['updatedAt'] ?? 0) as int,
        syncStatus: (m['syncStatus'] ?? 1) as int,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'categoryId': categoryId,
        'name': name,
        'icon': icon,
        'quantityNeeded': quantityNeeded,
        'quantityPurchased': quantityPurchased,
        'priority': priority,
        'notesItems': notesItems,
        'notesUser': notesUser,
        'purchaseLink': purchaseLink,
        'isPresente': isPresente,
        'value': value ?? 0,
        'isCustom': isCustom,
        'updatedAt': updatedAt,
        'syncStatus': syncStatus,
      };

  Map<String, dynamic> toDbMap() => {
        'id': id,
        'categoryId': categoryId,
        'name': name,
        'icon': icon,
        'quantityNeeded': quantityNeeded,
        'quantityPurchased': quantityPurchased,
        'priority': priority,
        'notesItems': notesItems,
        'notesUser': notesUser,
        'purchaseLink': purchaseLink,
        'isPresente': isPresente ? 1 : 0,
        'value': value ?? 0,
        'isCustom': isCustom ? 1 : 0,
        'updatedAt': updatedAt,
        'syncStatus': syncStatus,
      };

  static List<ItemModel> listMapItems(List<dynamic> lista, String categoryId) {
    return lista
        .cast<Map<String, dynamic>>()
        .map(
          (json) => ItemModel.fromRemoteJson(json, categoryId),
        )
        .toList();
  }
  static List<ItemModel> listMapItemsDd(List<dynamic> lista,) {
    return lista
        .cast<Map<String, dynamic>>()
        .map(
          (json) => ItemModel.fromDbMap(json),
        )
        .toList();
  }
}

  
