// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dtc_dao.dart';

// ignore_for_file: type=lint
mixin _$DtcDaoMixin on DatabaseAccessor<AppDatabase> {
  $DtcCacheTable get dtcCache => attachedDatabase.dtcCache;
  DtcDaoManager get managers => DtcDaoManager(this);
}

class DtcDaoManager {
  final _$DtcDaoMixin _db;
  DtcDaoManager(this._db);
  $$DtcCacheTableTableManager get dtcCache =>
      $$DtcCacheTableTableManager(_db.attachedDatabase, _db.dtcCache);
}
