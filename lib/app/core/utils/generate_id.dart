import 'package:uuid/uuid.dart';
class GenerateId {
  static String newId() {
    return const Uuid().v4();
  }
}