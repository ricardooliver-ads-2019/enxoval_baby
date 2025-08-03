// dart run tools/format_layette_json.dart input.json output.dart

// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

void main(List<String> args) {
  if (args.length != 2) {
    print('Uso: dart run tools/format_layette_mock.dart <input.json> <output.dart>');
    exit(1);
  }

  final inputPath = args[0];
  final outputPath = args[1];

  // 1. Ler e calcular progresso (parte do primeiro script)
  final raw = File(inputPath).readAsStringSync();
  final Map<String, dynamic> data = jsonDecode(raw);

  int totalNeededAll = 0;
  int totalPurchasedAll = 0;

  if (data['categories'] is List) {
    for (var cat in data['categories'] as List) {
      final items = cat['items'] as List<dynamic>;
      final totalNeeded = items.fold<int>(
          0, (sum, it) => sum + (it['quantityNeeded'] as int? ?? 0));
      final totalPurchased = items.fold<int>(
          0, (sum, it) => sum + (it['quantityPurchased'] as int? ?? 0));

      final progress = totalNeeded > 0
          ? totalPurchased / totalNeeded
          : 0.0;

      cat['totalNeeded'] = totalNeeded;
      cat['totalPurchased'] = totalPurchased;
      cat['progress'] = double.parse(progress.toStringAsFixed(4));

      totalNeededAll += totalNeeded;
      totalPurchasedAll += totalPurchased;
    }
  }

  data['totalNeededAll'] = totalNeededAll;
  data['totalPurchasedAll'] = totalPurchasedAll;
  data['globalProgress'] = totalNeededAll > 0
      ? double.parse((totalPurchasedAll / totalNeededAll).toStringAsFixed(4))
      : 0.0;

  // 2. Formatar para Dart (parte do segundo script)
  final buffer = StringBuffer();
  buffer.writeln('const Map<String, dynamic> layetteMock = {');

  void writeSimple(String key, Object? value, {int indent = 2}) {
    final indentStr = ' ' * indent;
    final encoded = json.encode(value);
    buffer.writeln('$indentStr"$key": $encoded,');
  }

  // Escreve campos principais
  writeSimple('layetteId', data['layetteId']);
  writeSimple('userId', data['userId']);
  writeSimple('nameBaby', data['nameBaby']);
  writeSimple('dueDate', data['dueDate']);
  writeSimple('totalBudget', data['totalBudget']);
  writeSimple('climate', data['climate']);
  writeSimple('sexBaby', data['sexBaby']);
  writeSimple('numberOfBabies', data['numberOfBabies']);
  writeSimple('familyProfile', data['familyProfile']);
  writeSimple('globalProgress', data['globalProgress']);
  writeSimple('totalNeededAll', data['totalNeededAll']);
  writeSimple('totalPurchasedAll', data['totalPurchasedAll']);

  // Escreve categorias
  buffer.writeln('  "categories": [');
  for (final cat in data['categories'] as List) {
    buffer.writeln('    {');
    for (final entry in (cat as Map<String, dynamic>).entries) {
      if (entry.key == 'items') continue;
      final encoded = json.encode(entry.value);
      buffer.writeln('      "${entry.key}": $encoded,');
    }

    // Items em linha única
    buffer.writeln('      "items": [');
    for (final item in cat['items'] as List) {
      final oneLine = const JsonEncoder().convert(item);
      buffer.writeln('        $oneLine,');
    }
    buffer.writeln('      ]');
    buffer.writeln('    },');
  }
  buffer.writeln('  ]');
  buffer.writeln('};');

  // Garante que o diretório de saída existe
  final outFile = File(outputPath);
  outFile.parent.createSync(recursive: true);
  outFile.writeAsStringSync(buffer.toString());

  print('Arquivo gerado em: $outputPath');
}