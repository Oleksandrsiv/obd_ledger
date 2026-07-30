import 'package:drift/drift.dart';

/// Cache for specific manufacturer errors (to avoid making API requests twice)
class DtcCache extends Table {
  TextColumn get code => text()(); // Example: "P0700"
  TextColumn get description => text()();

  @override
  Set<Column> get primaryKey => {code}; // Code is a unique key
}