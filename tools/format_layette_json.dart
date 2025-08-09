// tools/format_layette_json.dart

// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

void main(List<String> args) {
  if (args.length != 2) {
    print('Uso: dart run tools/format_layette_json.dart <input.json> <output.dart>');
    exit(1);
  }

  final inputPath = args[0];
  final outputPath = args[1];

  // 1. Ler e calcular progresso
  final raw = File(inputPath).readAsStringSync();
  final Map<String, dynamic> data = jsonDecode(raw);

  int totalNeededAll = 0;
  int totalPurchasedAll = 0;
  double totalSpentAll = 0;

  if (data['categories'] is List) {
    for (var cat in data['categories'] as List) {
      final items = cat['items'] as List<dynamic>;
      int totalNeeded = 0;
      int totalPurchased = 0;
      double totalSpent = 0;

      for (var item in items) {
        final needed = item['quantityNeeded'] as int? ?? 0;
        final purchased = item['quantityPurchased'] as int? ?? 0;
        final value = (item['value'] as num?)?.toDouble() ?? 0.0;
        
        totalNeeded += needed;
        totalPurchased += purchased;
        totalSpent += value * purchased;
      }

      final progress = totalNeeded > 0
          ? totalPurchased / totalNeeded
          : 0.0;

      cat['totalNeeded'] = totalNeeded;
      cat['totalPurchased'] = totalPurchased;
      cat['totalSpent'] = totalSpent;
      cat['progress'] = double.parse(progress.toStringAsFixed(4));

      totalNeededAll += totalNeeded;
      totalPurchasedAll += totalPurchased;
      totalSpentAll += totalSpent;
    }
  }

  data['totalNeededAll'] = totalNeededAll;
  data['totalPurchasedAll'] = totalPurchasedAll;
  data['totalSpentAll'] = totalSpentAll;
  data['globalProgress'] = totalNeededAll > 0
      ? double.parse((totalPurchasedAll / totalNeededAll).toStringAsFixed(4))
      : 0.0;

  // 2. Formatar para Dart
  final buffer = StringBuffer();
  buffer.writeln('{');

  void writeSimple(String key, Object? value, {int indent = 2}) {
    final indentStr = ' ' * indent;
    final encoded = json.encode(value);
    buffer.writeln('$indentStr"$key": $encoded,');
  }

  // Campos de nível superior
  writeSimple('layetteId', data['layetteId']);
  writeSimple('userId', data['userId']);
  writeSimple('nameBaby', data['nameBaby']);
  
  // Objeto layetteProfile
  buffer.writeln('  "layetteProfile": {');
  final profile = data['layetteProfile'] as Map<String, dynamic>;
  writeSimple('dueDate', profile['dueDate'], indent: 4);
  writeSimple('totalBudget', profile['totalBudget'], indent: 4);
  writeSimple('climate', profile['climate'], indent: 4);
  writeSimple('sexBaby', profile['sexBaby'], indent: 4);
  writeSimple('numberOfBabies', profile['numberOfBabies'], indent: 4);
  writeSimple('familyProfile', profile['familyProfile'], indent: 4);
  writeSimple('layetteDurationInMonths', profile['layetteDurationInMonths'], indent: 4);
  writeSimple('expectedBabySize', profile['expectedBabySize'], indent: 4);
  buffer.writeln('  },');

  // Campos calculados
  writeSimple('globalProgress', data['globalProgress']);
  writeSimple('totalSpentAll', data['totalSpentAll']);
  writeSimple('totalNeededAll', data['totalNeededAll']);
  writeSimple('totalPurchasedAll', data['totalPurchasedAll']);

  // Categorias
  buffer.writeln('  "categories": [');
  final categories = data['categories'] as List;
  for (int ci = 0; ci < categories.length; ci++) {
    final cat = categories[ci] as Map<String, dynamic>;
    buffer.writeln('    {');
    
    // Campos da categoria (exceto items)
    final catKeys = [
      'categoryId', 'name', 'icon', 'progress', 
      'isCustom', 'isDicarte', 'totalNeeded', 
      'totalPurchased', 'totalSpent'
    ];
    
    for (int i = 0; i < catKeys.length; i++) {
      final key = catKeys[i];
      if (cat.containsKey(key)) {
        final value = cat[key];
        final encoded = json.encode(value);
        buffer.writeln('      "$key": $encoded${','}');
      }
    }
    
    // Items em linha única
    buffer.writeln('      "items": [');
    final items = cat['items'] as List;
    for (int ii = 0; ii < items.length; ii++) {
      final item = items[ii];
      final oneLine = json.encode(item);
      final comma = ii < items.length - 1 ? ',' : '';
      buffer.writeln('        $oneLine$comma');
    }
    buffer.writeln('      ]');
    
    // Fechar categoria
    buffer.write('    }');
    if (ci < categories.length - 1) buffer.write(',');
    buffer.writeln();
  }
  buffer.writeln('  ]');
  
  // Fechar JSON
  buffer.writeln('}');

  // Garante que o diretório de saída existe
  final outFile = File(outputPath);
  outFile.parent.createSync(recursive: true);
  outFile.writeAsStringSync(buffer.toString());

  print('Arquivo gerado em: $outputPath');
}