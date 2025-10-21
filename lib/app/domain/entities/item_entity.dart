// lib/app/domain/entities/item_entity.dart
import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable {
  final String id;
  final String categoryId;
  final String name;
  final String? icon;
  final int quantityNeeded;
  final int quantityPurchased;
  final String priority;
  final String? notesItems;
  final String? notesUser;
  final String? purchaseLink;
  final bool isPresente;
  final double? value;
  final bool isDicarte;
  final bool isCustom;
  final int updatedAt;
  final int syncStatus;

  const ItemEntity({
    required this.id,
    required this.categoryId,
    required this.name,
    this.icon,
    required this.quantityNeeded,
    this.quantityPurchased = 0,
    required this.priority,
    this.notesItems,
    this.notesUser,
    this.purchaseLink,
    this.isPresente = false,
    this.value,
    this.isDicarte = false,
    this.isCustom = false,
    required this.updatedAt,
    this.syncStatus = 1,
  });

  /// Item está completo?
  bool get isCompleted => quantityPurchased >= quantityNeeded;

  /// Quanto foi gasto nesse item
  double get totalSpent => (value ?? 0) * quantityPurchased;

  double get progress {
    if (isCompleted) return 100.0;

    if (quantityNeeded == 0) return 0.0;

    return (quantityPurchased / quantityNeeded) * 100;
  }
  
  @override
  List<Object?> get props => [
        id,
        categoryId,
        name,
        icon,
        quantityNeeded,
        quantityPurchased,
        priority,
        notesItems,
        notesUser,
        purchaseLink,
        isPresente,
        value,
        isDicarte,
        isCustom,
        totalSpent,
        progress,
        isCompleted,
        updatedAt,
        syncStatus,
      ];
}


