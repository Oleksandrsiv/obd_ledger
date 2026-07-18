import 'package:drift/drift.dart';
import 'package:obd_ledger/data/database/tables/dtc_cache.dart';
import '../database.dart';

part 'dtc_dao.g.dart';

@DriftAccessor(tables: [DtcCache])
class DtcDao extends DatabaseAccessor<AppDatabase> with _$DtcDaoMixin {
  DtcDao(AppDatabase db) : super(db);

  /// Search for the description of an error in the local SQLite cache
  Future<String?> getDescription(String code) async {
    final result = await (select(dtcCache)..where((t) => t.code.equals(code))).getSingleOrNull();
    return result?.description;
  }

  ///Save a specific error to the cache after a successful API request (Upsert)
  Future<void> saveCode(String code, String description) async {
    await into(dtcCache).insertOnConflictUpdate(
      DtcCacheCompanion(
        code: Value(code),
        description: Value(description),
      ),
    );
  }
}