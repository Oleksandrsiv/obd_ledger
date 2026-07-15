// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CarsTable extends Cars with TableInfo<$CarsTable, Car> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CarsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _vinMeta = const VerificationMeta('vin');
  @override
  late final GeneratedColumn<String> vin = GeneratedColumn<String>(
    'vin',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _savedTotalDistanceMeta =
      const VerificationMeta('savedTotalDistance');
  @override
  late final GeneratedColumn<int> savedTotalDistance = GeneratedColumn<int>(
    'saved_total_distance',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastObdReadingMeta = const VerificationMeta(
    'lastObdReading',
  );
  @override
  late final GeneratedColumn<int> lastObdReading = GeneratedColumn<int>(
    'last_obd_reading',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isAccuracyWarningMeta = const VerificationMeta(
    'isAccuracyWarning',
  );
  @override
  late final GeneratedColumn<bool> isAccuracyWarning = GeneratedColumn<bool>(
    'is_accuracy_warning',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_accuracy_warning" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _oilIntervalMeta = const VerificationMeta(
    'oilInterval',
  );
  @override
  late final GeneratedColumn<int> oilInterval = GeneratedColumn<int>(
    'oil_interval',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _oilLastChangeDistanceMeta =
      const VerificationMeta('oilLastChangeDistance');
  @override
  late final GeneratedColumn<int> oilLastChangeDistance = GeneratedColumn<int>(
    'oil_last_change_distance',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _airFilterIntervalMeta = const VerificationMeta(
    'airFilterInterval',
  );
  @override
  late final GeneratedColumn<int> airFilterInterval = GeneratedColumn<int>(
    'air_filter_interval',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _airFilterLastChangeDistanceMeta =
      const VerificationMeta('airFilterLastChangeDistance');
  @override
  late final GeneratedColumn<int> airFilterLastChangeDistance =
      GeneratedColumn<int>(
        'air_filter_last_change_distance',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _cabinFilterIntervalMeta =
      const VerificationMeta('cabinFilterInterval');
  @override
  late final GeneratedColumn<int> cabinFilterInterval = GeneratedColumn<int>(
    'cabin_filter_interval',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cabinFilterLastChangeDistanceMeta =
      const VerificationMeta('cabinFilterLastChangeDistance');
  @override
  late final GeneratedColumn<int> cabinFilterLastChangeDistance =
      GeneratedColumn<int>(
        'cabin_filter_last_change_distance',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vin,
    name,
    savedTotalDistance,
    lastObdReading,
    isAccuracyWarning,
    oilInterval,
    oilLastChangeDistance,
    airFilterInterval,
    airFilterLastChangeDistance,
    cabinFilterInterval,
    cabinFilterLastChangeDistance,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cars';
  @override
  VerificationContext validateIntegrity(
    Insertable<Car> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vin')) {
      context.handle(
        _vinMeta,
        vin.isAcceptableOrUnknown(data['vin']!, _vinMeta),
      );
    } else if (isInserting) {
      context.missing(_vinMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('saved_total_distance')) {
      context.handle(
        _savedTotalDistanceMeta,
        savedTotalDistance.isAcceptableOrUnknown(
          data['saved_total_distance']!,
          _savedTotalDistanceMeta,
        ),
      );
    }
    if (data.containsKey('last_obd_reading')) {
      context.handle(
        _lastObdReadingMeta,
        lastObdReading.isAcceptableOrUnknown(
          data['last_obd_reading']!,
          _lastObdReadingMeta,
        ),
      );
    }
    if (data.containsKey('is_accuracy_warning')) {
      context.handle(
        _isAccuracyWarningMeta,
        isAccuracyWarning.isAcceptableOrUnknown(
          data['is_accuracy_warning']!,
          _isAccuracyWarningMeta,
        ),
      );
    }
    if (data.containsKey('oil_interval')) {
      context.handle(
        _oilIntervalMeta,
        oilInterval.isAcceptableOrUnknown(
          data['oil_interval']!,
          _oilIntervalMeta,
        ),
      );
    }
    if (data.containsKey('oil_last_change_distance')) {
      context.handle(
        _oilLastChangeDistanceMeta,
        oilLastChangeDistance.isAcceptableOrUnknown(
          data['oil_last_change_distance']!,
          _oilLastChangeDistanceMeta,
        ),
      );
    }
    if (data.containsKey('air_filter_interval')) {
      context.handle(
        _airFilterIntervalMeta,
        airFilterInterval.isAcceptableOrUnknown(
          data['air_filter_interval']!,
          _airFilterIntervalMeta,
        ),
      );
    }
    if (data.containsKey('air_filter_last_change_distance')) {
      context.handle(
        _airFilterLastChangeDistanceMeta,
        airFilterLastChangeDistance.isAcceptableOrUnknown(
          data['air_filter_last_change_distance']!,
          _airFilterLastChangeDistanceMeta,
        ),
      );
    }
    if (data.containsKey('cabin_filter_interval')) {
      context.handle(
        _cabinFilterIntervalMeta,
        cabinFilterInterval.isAcceptableOrUnknown(
          data['cabin_filter_interval']!,
          _cabinFilterIntervalMeta,
        ),
      );
    }
    if (data.containsKey('cabin_filter_last_change_distance')) {
      context.handle(
        _cabinFilterLastChangeDistanceMeta,
        cabinFilterLastChangeDistance.isAcceptableOrUnknown(
          data['cabin_filter_last_change_distance']!,
          _cabinFilterLastChangeDistanceMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Car map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Car(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      vin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vin'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      savedTotalDistance: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}saved_total_distance'],
      )!,
      lastObdReading: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_obd_reading'],
      )!,
      isAccuracyWarning: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_accuracy_warning'],
      )!,
      oilInterval: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}oil_interval'],
      ),
      oilLastChangeDistance: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}oil_last_change_distance'],
      )!,
      airFilterInterval: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}air_filter_interval'],
      ),
      airFilterLastChangeDistance: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}air_filter_last_change_distance'],
      )!,
      cabinFilterInterval: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cabin_filter_interval'],
      ),
      cabinFilterLastChangeDistance: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cabin_filter_last_change_distance'],
      )!,
    );
  }

  @override
  $CarsTable createAlias(String alias) {
    return $CarsTable(attachedDatabase, alias);
  }
}

class Car extends DataClass implements Insertable<Car> {
  final int id;
  final String vin;
  final String? name;
  final int savedTotalDistance;
  final int lastObdReading;
  final bool isAccuracyWarning;
  final int? oilInterval;
  final int oilLastChangeDistance;
  final int? airFilterInterval;
  final int airFilterLastChangeDistance;
  final int? cabinFilterInterval;
  final int cabinFilterLastChangeDistance;
  const Car({
    required this.id,
    required this.vin,
    this.name,
    required this.savedTotalDistance,
    required this.lastObdReading,
    required this.isAccuracyWarning,
    this.oilInterval,
    required this.oilLastChangeDistance,
    this.airFilterInterval,
    required this.airFilterLastChangeDistance,
    this.cabinFilterInterval,
    required this.cabinFilterLastChangeDistance,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vin'] = Variable<String>(vin);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['saved_total_distance'] = Variable<int>(savedTotalDistance);
    map['last_obd_reading'] = Variable<int>(lastObdReading);
    map['is_accuracy_warning'] = Variable<bool>(isAccuracyWarning);
    if (!nullToAbsent || oilInterval != null) {
      map['oil_interval'] = Variable<int>(oilInterval);
    }
    map['oil_last_change_distance'] = Variable<int>(oilLastChangeDistance);
    if (!nullToAbsent || airFilterInterval != null) {
      map['air_filter_interval'] = Variable<int>(airFilterInterval);
    }
    map['air_filter_last_change_distance'] = Variable<int>(
      airFilterLastChangeDistance,
    );
    if (!nullToAbsent || cabinFilterInterval != null) {
      map['cabin_filter_interval'] = Variable<int>(cabinFilterInterval);
    }
    map['cabin_filter_last_change_distance'] = Variable<int>(
      cabinFilterLastChangeDistance,
    );
    return map;
  }

  CarsCompanion toCompanion(bool nullToAbsent) {
    return CarsCompanion(
      id: Value(id),
      vin: Value(vin),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      savedTotalDistance: Value(savedTotalDistance),
      lastObdReading: Value(lastObdReading),
      isAccuracyWarning: Value(isAccuracyWarning),
      oilInterval: oilInterval == null && nullToAbsent
          ? const Value.absent()
          : Value(oilInterval),
      oilLastChangeDistance: Value(oilLastChangeDistance),
      airFilterInterval: airFilterInterval == null && nullToAbsent
          ? const Value.absent()
          : Value(airFilterInterval),
      airFilterLastChangeDistance: Value(airFilterLastChangeDistance),
      cabinFilterInterval: cabinFilterInterval == null && nullToAbsent
          ? const Value.absent()
          : Value(cabinFilterInterval),
      cabinFilterLastChangeDistance: Value(cabinFilterLastChangeDistance),
    );
  }

  factory Car.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Car(
      id: serializer.fromJson<int>(json['id']),
      vin: serializer.fromJson<String>(json['vin']),
      name: serializer.fromJson<String?>(json['name']),
      savedTotalDistance: serializer.fromJson<int>(json['savedTotalDistance']),
      lastObdReading: serializer.fromJson<int>(json['lastObdReading']),
      isAccuracyWarning: serializer.fromJson<bool>(json['isAccuracyWarning']),
      oilInterval: serializer.fromJson<int?>(json['oilInterval']),
      oilLastChangeDistance: serializer.fromJson<int>(
        json['oilLastChangeDistance'],
      ),
      airFilterInterval: serializer.fromJson<int?>(json['airFilterInterval']),
      airFilterLastChangeDistance: serializer.fromJson<int>(
        json['airFilterLastChangeDistance'],
      ),
      cabinFilterInterval: serializer.fromJson<int?>(
        json['cabinFilterInterval'],
      ),
      cabinFilterLastChangeDistance: serializer.fromJson<int>(
        json['cabinFilterLastChangeDistance'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vin': serializer.toJson<String>(vin),
      'name': serializer.toJson<String?>(name),
      'savedTotalDistance': serializer.toJson<int>(savedTotalDistance),
      'lastObdReading': serializer.toJson<int>(lastObdReading),
      'isAccuracyWarning': serializer.toJson<bool>(isAccuracyWarning),
      'oilInterval': serializer.toJson<int?>(oilInterval),
      'oilLastChangeDistance': serializer.toJson<int>(oilLastChangeDistance),
      'airFilterInterval': serializer.toJson<int?>(airFilterInterval),
      'airFilterLastChangeDistance': serializer.toJson<int>(
        airFilterLastChangeDistance,
      ),
      'cabinFilterInterval': serializer.toJson<int?>(cabinFilterInterval),
      'cabinFilterLastChangeDistance': serializer.toJson<int>(
        cabinFilterLastChangeDistance,
      ),
    };
  }

  Car copyWith({
    int? id,
    String? vin,
    Value<String?> name = const Value.absent(),
    int? savedTotalDistance,
    int? lastObdReading,
    bool? isAccuracyWarning,
    Value<int?> oilInterval = const Value.absent(),
    int? oilLastChangeDistance,
    Value<int?> airFilterInterval = const Value.absent(),
    int? airFilterLastChangeDistance,
    Value<int?> cabinFilterInterval = const Value.absent(),
    int? cabinFilterLastChangeDistance,
  }) => Car(
    id: id ?? this.id,
    vin: vin ?? this.vin,
    name: name.present ? name.value : this.name,
    savedTotalDistance: savedTotalDistance ?? this.savedTotalDistance,
    lastObdReading: lastObdReading ?? this.lastObdReading,
    isAccuracyWarning: isAccuracyWarning ?? this.isAccuracyWarning,
    oilInterval: oilInterval.present ? oilInterval.value : this.oilInterval,
    oilLastChangeDistance: oilLastChangeDistance ?? this.oilLastChangeDistance,
    airFilterInterval: airFilterInterval.present
        ? airFilterInterval.value
        : this.airFilterInterval,
    airFilterLastChangeDistance:
        airFilterLastChangeDistance ?? this.airFilterLastChangeDistance,
    cabinFilterInterval: cabinFilterInterval.present
        ? cabinFilterInterval.value
        : this.cabinFilterInterval,
    cabinFilterLastChangeDistance:
        cabinFilterLastChangeDistance ?? this.cabinFilterLastChangeDistance,
  );
  Car copyWithCompanion(CarsCompanion data) {
    return Car(
      id: data.id.present ? data.id.value : this.id,
      vin: data.vin.present ? data.vin.value : this.vin,
      name: data.name.present ? data.name.value : this.name,
      savedTotalDistance: data.savedTotalDistance.present
          ? data.savedTotalDistance.value
          : this.savedTotalDistance,
      lastObdReading: data.lastObdReading.present
          ? data.lastObdReading.value
          : this.lastObdReading,
      isAccuracyWarning: data.isAccuracyWarning.present
          ? data.isAccuracyWarning.value
          : this.isAccuracyWarning,
      oilInterval: data.oilInterval.present
          ? data.oilInterval.value
          : this.oilInterval,
      oilLastChangeDistance: data.oilLastChangeDistance.present
          ? data.oilLastChangeDistance.value
          : this.oilLastChangeDistance,
      airFilterInterval: data.airFilterInterval.present
          ? data.airFilterInterval.value
          : this.airFilterInterval,
      airFilterLastChangeDistance: data.airFilterLastChangeDistance.present
          ? data.airFilterLastChangeDistance.value
          : this.airFilterLastChangeDistance,
      cabinFilterInterval: data.cabinFilterInterval.present
          ? data.cabinFilterInterval.value
          : this.cabinFilterInterval,
      cabinFilterLastChangeDistance: data.cabinFilterLastChangeDistance.present
          ? data.cabinFilterLastChangeDistance.value
          : this.cabinFilterLastChangeDistance,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Car(')
          ..write('id: $id, ')
          ..write('vin: $vin, ')
          ..write('name: $name, ')
          ..write('savedTotalDistance: $savedTotalDistance, ')
          ..write('lastObdReading: $lastObdReading, ')
          ..write('isAccuracyWarning: $isAccuracyWarning, ')
          ..write('oilInterval: $oilInterval, ')
          ..write('oilLastChangeDistance: $oilLastChangeDistance, ')
          ..write('airFilterInterval: $airFilterInterval, ')
          ..write('airFilterLastChangeDistance: $airFilterLastChangeDistance, ')
          ..write('cabinFilterInterval: $cabinFilterInterval, ')
          ..write(
            'cabinFilterLastChangeDistance: $cabinFilterLastChangeDistance',
          )
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vin,
    name,
    savedTotalDistance,
    lastObdReading,
    isAccuracyWarning,
    oilInterval,
    oilLastChangeDistance,
    airFilterInterval,
    airFilterLastChangeDistance,
    cabinFilterInterval,
    cabinFilterLastChangeDistance,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Car &&
          other.id == this.id &&
          other.vin == this.vin &&
          other.name == this.name &&
          other.savedTotalDistance == this.savedTotalDistance &&
          other.lastObdReading == this.lastObdReading &&
          other.isAccuracyWarning == this.isAccuracyWarning &&
          other.oilInterval == this.oilInterval &&
          other.oilLastChangeDistance == this.oilLastChangeDistance &&
          other.airFilterInterval == this.airFilterInterval &&
          other.airFilterLastChangeDistance ==
              this.airFilterLastChangeDistance &&
          other.cabinFilterInterval == this.cabinFilterInterval &&
          other.cabinFilterLastChangeDistance ==
              this.cabinFilterLastChangeDistance);
}

class CarsCompanion extends UpdateCompanion<Car> {
  final Value<int> id;
  final Value<String> vin;
  final Value<String?> name;
  final Value<int> savedTotalDistance;
  final Value<int> lastObdReading;
  final Value<bool> isAccuracyWarning;
  final Value<int?> oilInterval;
  final Value<int> oilLastChangeDistance;
  final Value<int?> airFilterInterval;
  final Value<int> airFilterLastChangeDistance;
  final Value<int?> cabinFilterInterval;
  final Value<int> cabinFilterLastChangeDistance;
  const CarsCompanion({
    this.id = const Value.absent(),
    this.vin = const Value.absent(),
    this.name = const Value.absent(),
    this.savedTotalDistance = const Value.absent(),
    this.lastObdReading = const Value.absent(),
    this.isAccuracyWarning = const Value.absent(),
    this.oilInterval = const Value.absent(),
    this.oilLastChangeDistance = const Value.absent(),
    this.airFilterInterval = const Value.absent(),
    this.airFilterLastChangeDistance = const Value.absent(),
    this.cabinFilterInterval = const Value.absent(),
    this.cabinFilterLastChangeDistance = const Value.absent(),
  });
  CarsCompanion.insert({
    this.id = const Value.absent(),
    required String vin,
    this.name = const Value.absent(),
    this.savedTotalDistance = const Value.absent(),
    this.lastObdReading = const Value.absent(),
    this.isAccuracyWarning = const Value.absent(),
    this.oilInterval = const Value.absent(),
    this.oilLastChangeDistance = const Value.absent(),
    this.airFilterInterval = const Value.absent(),
    this.airFilterLastChangeDistance = const Value.absent(),
    this.cabinFilterInterval = const Value.absent(),
    this.cabinFilterLastChangeDistance = const Value.absent(),
  }) : vin = Value(vin);
  static Insertable<Car> custom({
    Expression<int>? id,
    Expression<String>? vin,
    Expression<String>? name,
    Expression<int>? savedTotalDistance,
    Expression<int>? lastObdReading,
    Expression<bool>? isAccuracyWarning,
    Expression<int>? oilInterval,
    Expression<int>? oilLastChangeDistance,
    Expression<int>? airFilterInterval,
    Expression<int>? airFilterLastChangeDistance,
    Expression<int>? cabinFilterInterval,
    Expression<int>? cabinFilterLastChangeDistance,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vin != null) 'vin': vin,
      if (name != null) 'name': name,
      if (savedTotalDistance != null)
        'saved_total_distance': savedTotalDistance,
      if (lastObdReading != null) 'last_obd_reading': lastObdReading,
      if (isAccuracyWarning != null) 'is_accuracy_warning': isAccuracyWarning,
      if (oilInterval != null) 'oil_interval': oilInterval,
      if (oilLastChangeDistance != null)
        'oil_last_change_distance': oilLastChangeDistance,
      if (airFilterInterval != null) 'air_filter_interval': airFilterInterval,
      if (airFilterLastChangeDistance != null)
        'air_filter_last_change_distance': airFilterLastChangeDistance,
      if (cabinFilterInterval != null)
        'cabin_filter_interval': cabinFilterInterval,
      if (cabinFilterLastChangeDistance != null)
        'cabin_filter_last_change_distance': cabinFilterLastChangeDistance,
    });
  }

  CarsCompanion copyWith({
    Value<int>? id,
    Value<String>? vin,
    Value<String?>? name,
    Value<int>? savedTotalDistance,
    Value<int>? lastObdReading,
    Value<bool>? isAccuracyWarning,
    Value<int?>? oilInterval,
    Value<int>? oilLastChangeDistance,
    Value<int?>? airFilterInterval,
    Value<int>? airFilterLastChangeDistance,
    Value<int?>? cabinFilterInterval,
    Value<int>? cabinFilterLastChangeDistance,
  }) {
    return CarsCompanion(
      id: id ?? this.id,
      vin: vin ?? this.vin,
      name: name ?? this.name,
      savedTotalDistance: savedTotalDistance ?? this.savedTotalDistance,
      lastObdReading: lastObdReading ?? this.lastObdReading,
      isAccuracyWarning: isAccuracyWarning ?? this.isAccuracyWarning,
      oilInterval: oilInterval ?? this.oilInterval,
      oilLastChangeDistance:
          oilLastChangeDistance ?? this.oilLastChangeDistance,
      airFilterInterval: airFilterInterval ?? this.airFilterInterval,
      airFilterLastChangeDistance:
          airFilterLastChangeDistance ?? this.airFilterLastChangeDistance,
      cabinFilterInterval: cabinFilterInterval ?? this.cabinFilterInterval,
      cabinFilterLastChangeDistance:
          cabinFilterLastChangeDistance ?? this.cabinFilterLastChangeDistance,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vin.present) {
      map['vin'] = Variable<String>(vin.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (savedTotalDistance.present) {
      map['saved_total_distance'] = Variable<int>(savedTotalDistance.value);
    }
    if (lastObdReading.present) {
      map['last_obd_reading'] = Variable<int>(lastObdReading.value);
    }
    if (isAccuracyWarning.present) {
      map['is_accuracy_warning'] = Variable<bool>(isAccuracyWarning.value);
    }
    if (oilInterval.present) {
      map['oil_interval'] = Variable<int>(oilInterval.value);
    }
    if (oilLastChangeDistance.present) {
      map['oil_last_change_distance'] = Variable<int>(
        oilLastChangeDistance.value,
      );
    }
    if (airFilterInterval.present) {
      map['air_filter_interval'] = Variable<int>(airFilterInterval.value);
    }
    if (airFilterLastChangeDistance.present) {
      map['air_filter_last_change_distance'] = Variable<int>(
        airFilterLastChangeDistance.value,
      );
    }
    if (cabinFilterInterval.present) {
      map['cabin_filter_interval'] = Variable<int>(cabinFilterInterval.value);
    }
    if (cabinFilterLastChangeDistance.present) {
      map['cabin_filter_last_change_distance'] = Variable<int>(
        cabinFilterLastChangeDistance.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CarsCompanion(')
          ..write('id: $id, ')
          ..write('vin: $vin, ')
          ..write('name: $name, ')
          ..write('savedTotalDistance: $savedTotalDistance, ')
          ..write('lastObdReading: $lastObdReading, ')
          ..write('isAccuracyWarning: $isAccuracyWarning, ')
          ..write('oilInterval: $oilInterval, ')
          ..write('oilLastChangeDistance: $oilLastChangeDistance, ')
          ..write('airFilterInterval: $airFilterInterval, ')
          ..write('airFilterLastChangeDistance: $airFilterLastChangeDistance, ')
          ..write('cabinFilterInterval: $cabinFilterInterval, ')
          ..write(
            'cabinFilterLastChangeDistance: $cabinFilterLastChangeDistance',
          )
          ..write(')'))
        .toString();
  }
}

class $TripsTable extends Trips with TableInfo<$TripsTable, Trip> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TripsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _carIdMeta = const VerificationMeta('carId');
  @override
  late final GeneratedColumn<int> carId = GeneratedColumn<int>(
    'car_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cars (id)',
    ),
  );
  static const VerificationMeta _startTimestampMeta = const VerificationMeta(
    'startTimestamp',
  );
  @override
  late final GeneratedColumn<int> startTimestamp = GeneratedColumn<int>(
    'start_timestamp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimestampMeta = const VerificationMeta(
    'endTimestamp',
  );
  @override
  late final GeneratedColumn<int> endTimestamp = GeneratedColumn<int>(
    'end_timestamp',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalDistanceMeta = const VerificationMeta(
    'totalDistance',
  );
  @override
  late final GeneratedColumn<int> totalDistance = GeneratedColumn<int>(
    'total_distance',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _averageRpmMeta = const VerificationMeta(
    'averageRpm',
  );
  @override
  late final GeneratedColumn<int> averageRpm = GeneratedColumn<int>(
    'average_rpm',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _averageSpeedMeta = const VerificationMeta(
    'averageSpeed',
  );
  @override
  late final GeneratedColumn<int> averageSpeed = GeneratedColumn<int>(
    'average_speed',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    carId,
    startTimestamp,
    endTimestamp,
    totalDistance,
    averageRpm,
    averageSpeed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trips';
  @override
  VerificationContext validateIntegrity(
    Insertable<Trip> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('car_id')) {
      context.handle(
        _carIdMeta,
        carId.isAcceptableOrUnknown(data['car_id']!, _carIdMeta),
      );
    } else if (isInserting) {
      context.missing(_carIdMeta);
    }
    if (data.containsKey('start_timestamp')) {
      context.handle(
        _startTimestampMeta,
        startTimestamp.isAcceptableOrUnknown(
          data['start_timestamp']!,
          _startTimestampMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startTimestampMeta);
    }
    if (data.containsKey('end_timestamp')) {
      context.handle(
        _endTimestampMeta,
        endTimestamp.isAcceptableOrUnknown(
          data['end_timestamp']!,
          _endTimestampMeta,
        ),
      );
    }
    if (data.containsKey('total_distance')) {
      context.handle(
        _totalDistanceMeta,
        totalDistance.isAcceptableOrUnknown(
          data['total_distance']!,
          _totalDistanceMeta,
        ),
      );
    }
    if (data.containsKey('average_rpm')) {
      context.handle(
        _averageRpmMeta,
        averageRpm.isAcceptableOrUnknown(data['average_rpm']!, _averageRpmMeta),
      );
    }
    if (data.containsKey('average_speed')) {
      context.handle(
        _averageSpeedMeta,
        averageSpeed.isAcceptableOrUnknown(
          data['average_speed']!,
          _averageSpeedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Trip map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Trip(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      carId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}car_id'],
      )!,
      startTimestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_timestamp'],
      )!,
      endTimestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_timestamp'],
      ),
      totalDistance: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_distance'],
      )!,
      averageRpm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}average_rpm'],
      ),
      averageSpeed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}average_speed'],
      ),
    );
  }

  @override
  $TripsTable createAlias(String alias) {
    return $TripsTable(attachedDatabase, alias);
  }
}

class Trip extends DataClass implements Insertable<Trip> {
  final int id;
  final int carId;
  final int startTimestamp;
  final int? endTimestamp;
  final int totalDistance;
  final int? averageRpm;
  final int? averageSpeed;
  const Trip({
    required this.id,
    required this.carId,
    required this.startTimestamp,
    this.endTimestamp,
    required this.totalDistance,
    this.averageRpm,
    this.averageSpeed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['car_id'] = Variable<int>(carId);
    map['start_timestamp'] = Variable<int>(startTimestamp);
    if (!nullToAbsent || endTimestamp != null) {
      map['end_timestamp'] = Variable<int>(endTimestamp);
    }
    map['total_distance'] = Variable<int>(totalDistance);
    if (!nullToAbsent || averageRpm != null) {
      map['average_rpm'] = Variable<int>(averageRpm);
    }
    if (!nullToAbsent || averageSpeed != null) {
      map['average_speed'] = Variable<int>(averageSpeed);
    }
    return map;
  }

  TripsCompanion toCompanion(bool nullToAbsent) {
    return TripsCompanion(
      id: Value(id),
      carId: Value(carId),
      startTimestamp: Value(startTimestamp),
      endTimestamp: endTimestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(endTimestamp),
      totalDistance: Value(totalDistance),
      averageRpm: averageRpm == null && nullToAbsent
          ? const Value.absent()
          : Value(averageRpm),
      averageSpeed: averageSpeed == null && nullToAbsent
          ? const Value.absent()
          : Value(averageSpeed),
    );
  }

  factory Trip.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Trip(
      id: serializer.fromJson<int>(json['id']),
      carId: serializer.fromJson<int>(json['carId']),
      startTimestamp: serializer.fromJson<int>(json['startTimestamp']),
      endTimestamp: serializer.fromJson<int?>(json['endTimestamp']),
      totalDistance: serializer.fromJson<int>(json['totalDistance']),
      averageRpm: serializer.fromJson<int?>(json['averageRpm']),
      averageSpeed: serializer.fromJson<int?>(json['averageSpeed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'carId': serializer.toJson<int>(carId),
      'startTimestamp': serializer.toJson<int>(startTimestamp),
      'endTimestamp': serializer.toJson<int?>(endTimestamp),
      'totalDistance': serializer.toJson<int>(totalDistance),
      'averageRpm': serializer.toJson<int?>(averageRpm),
      'averageSpeed': serializer.toJson<int?>(averageSpeed),
    };
  }

  Trip copyWith({
    int? id,
    int? carId,
    int? startTimestamp,
    Value<int?> endTimestamp = const Value.absent(),
    int? totalDistance,
    Value<int?> averageRpm = const Value.absent(),
    Value<int?> averageSpeed = const Value.absent(),
  }) => Trip(
    id: id ?? this.id,
    carId: carId ?? this.carId,
    startTimestamp: startTimestamp ?? this.startTimestamp,
    endTimestamp: endTimestamp.present ? endTimestamp.value : this.endTimestamp,
    totalDistance: totalDistance ?? this.totalDistance,
    averageRpm: averageRpm.present ? averageRpm.value : this.averageRpm,
    averageSpeed: averageSpeed.present ? averageSpeed.value : this.averageSpeed,
  );
  Trip copyWithCompanion(TripsCompanion data) {
    return Trip(
      id: data.id.present ? data.id.value : this.id,
      carId: data.carId.present ? data.carId.value : this.carId,
      startTimestamp: data.startTimestamp.present
          ? data.startTimestamp.value
          : this.startTimestamp,
      endTimestamp: data.endTimestamp.present
          ? data.endTimestamp.value
          : this.endTimestamp,
      totalDistance: data.totalDistance.present
          ? data.totalDistance.value
          : this.totalDistance,
      averageRpm: data.averageRpm.present
          ? data.averageRpm.value
          : this.averageRpm,
      averageSpeed: data.averageSpeed.present
          ? data.averageSpeed.value
          : this.averageSpeed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Trip(')
          ..write('id: $id, ')
          ..write('carId: $carId, ')
          ..write('startTimestamp: $startTimestamp, ')
          ..write('endTimestamp: $endTimestamp, ')
          ..write('totalDistance: $totalDistance, ')
          ..write('averageRpm: $averageRpm, ')
          ..write('averageSpeed: $averageSpeed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    carId,
    startTimestamp,
    endTimestamp,
    totalDistance,
    averageRpm,
    averageSpeed,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Trip &&
          other.id == this.id &&
          other.carId == this.carId &&
          other.startTimestamp == this.startTimestamp &&
          other.endTimestamp == this.endTimestamp &&
          other.totalDistance == this.totalDistance &&
          other.averageRpm == this.averageRpm &&
          other.averageSpeed == this.averageSpeed);
}

class TripsCompanion extends UpdateCompanion<Trip> {
  final Value<int> id;
  final Value<int> carId;
  final Value<int> startTimestamp;
  final Value<int?> endTimestamp;
  final Value<int> totalDistance;
  final Value<int?> averageRpm;
  final Value<int?> averageSpeed;
  const TripsCompanion({
    this.id = const Value.absent(),
    this.carId = const Value.absent(),
    this.startTimestamp = const Value.absent(),
    this.endTimestamp = const Value.absent(),
    this.totalDistance = const Value.absent(),
    this.averageRpm = const Value.absent(),
    this.averageSpeed = const Value.absent(),
  });
  TripsCompanion.insert({
    this.id = const Value.absent(),
    required int carId,
    required int startTimestamp,
    this.endTimestamp = const Value.absent(),
    this.totalDistance = const Value.absent(),
    this.averageRpm = const Value.absent(),
    this.averageSpeed = const Value.absent(),
  }) : carId = Value(carId),
       startTimestamp = Value(startTimestamp);
  static Insertable<Trip> custom({
    Expression<int>? id,
    Expression<int>? carId,
    Expression<int>? startTimestamp,
    Expression<int>? endTimestamp,
    Expression<int>? totalDistance,
    Expression<int>? averageRpm,
    Expression<int>? averageSpeed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (carId != null) 'car_id': carId,
      if (startTimestamp != null) 'start_timestamp': startTimestamp,
      if (endTimestamp != null) 'end_timestamp': endTimestamp,
      if (totalDistance != null) 'total_distance': totalDistance,
      if (averageRpm != null) 'average_rpm': averageRpm,
      if (averageSpeed != null) 'average_speed': averageSpeed,
    });
  }

  TripsCompanion copyWith({
    Value<int>? id,
    Value<int>? carId,
    Value<int>? startTimestamp,
    Value<int?>? endTimestamp,
    Value<int>? totalDistance,
    Value<int?>? averageRpm,
    Value<int?>? averageSpeed,
  }) {
    return TripsCompanion(
      id: id ?? this.id,
      carId: carId ?? this.carId,
      startTimestamp: startTimestamp ?? this.startTimestamp,
      endTimestamp: endTimestamp ?? this.endTimestamp,
      totalDistance: totalDistance ?? this.totalDistance,
      averageRpm: averageRpm ?? this.averageRpm,
      averageSpeed: averageSpeed ?? this.averageSpeed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (carId.present) {
      map['car_id'] = Variable<int>(carId.value);
    }
    if (startTimestamp.present) {
      map['start_timestamp'] = Variable<int>(startTimestamp.value);
    }
    if (endTimestamp.present) {
      map['end_timestamp'] = Variable<int>(endTimestamp.value);
    }
    if (totalDistance.present) {
      map['total_distance'] = Variable<int>(totalDistance.value);
    }
    if (averageRpm.present) {
      map['average_rpm'] = Variable<int>(averageRpm.value);
    }
    if (averageSpeed.present) {
      map['average_speed'] = Variable<int>(averageSpeed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TripsCompanion(')
          ..write('id: $id, ')
          ..write('carId: $carId, ')
          ..write('startTimestamp: $startTimestamp, ')
          ..write('endTimestamp: $endTimestamp, ')
          ..write('totalDistance: $totalDistance, ')
          ..write('averageRpm: $averageRpm, ')
          ..write('averageSpeed: $averageSpeed')
          ..write(')'))
        .toString();
  }
}

class $TripPointsTable extends TripPoints
    with TableInfo<$TripPointsTable, TripPoint> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TripPointsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tripIdMeta = const VerificationMeta('tripId');
  @override
  late final GeneratedColumn<int> tripId = GeneratedColumn<int>(
    'trip_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trips (id)',
    ),
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<int> timestamp = GeneratedColumn<int>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _speedMeta = const VerificationMeta('speed');
  @override
  late final GeneratedColumn<int> speed = GeneratedColumn<int>(
    'speed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rpmMeta = const VerificationMeta('rpm');
  @override
  late final GeneratedColumn<int> rpm = GeneratedColumn<int>(
    'rpm',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _throttlePositionMeta = const VerificationMeta(
    'throttlePosition',
  );
  @override
  late final GeneratedColumn<int> throttlePosition = GeneratedColumn<int>(
    'throttle_position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _engineTempMeta = const VerificationMeta(
    'engineTemp',
  );
  @override
  late final GeneratedColumn<int> engineTemp = GeneratedColumn<int>(
    'engine_temp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tripId,
    timestamp,
    speed,
    rpm,
    throttlePosition,
    engineTemp,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trip_points';
  @override
  VerificationContext validateIntegrity(
    Insertable<TripPoint> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('trip_id')) {
      context.handle(
        _tripIdMeta,
        tripId.isAcceptableOrUnknown(data['trip_id']!, _tripIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tripIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('speed')) {
      context.handle(
        _speedMeta,
        speed.isAcceptableOrUnknown(data['speed']!, _speedMeta),
      );
    } else if (isInserting) {
      context.missing(_speedMeta);
    }
    if (data.containsKey('rpm')) {
      context.handle(
        _rpmMeta,
        rpm.isAcceptableOrUnknown(data['rpm']!, _rpmMeta),
      );
    } else if (isInserting) {
      context.missing(_rpmMeta);
    }
    if (data.containsKey('throttle_position')) {
      context.handle(
        _throttlePositionMeta,
        throttlePosition.isAcceptableOrUnknown(
          data['throttle_position']!,
          _throttlePositionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_throttlePositionMeta);
    }
    if (data.containsKey('engine_temp')) {
      context.handle(
        _engineTempMeta,
        engineTemp.isAcceptableOrUnknown(data['engine_temp']!, _engineTempMeta),
      );
    } else if (isInserting) {
      context.missing(_engineTempMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TripPoint map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TripPoint(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tripId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}trip_id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp'],
      )!,
      speed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}speed'],
      )!,
      rpm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rpm'],
      )!,
      throttlePosition: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}throttle_position'],
      )!,
      engineTemp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}engine_temp'],
      )!,
    );
  }

  @override
  $TripPointsTable createAlias(String alias) {
    return $TripPointsTable(attachedDatabase, alias);
  }
}

class TripPoint extends DataClass implements Insertable<TripPoint> {
  final int id;
  final int tripId;
  final int timestamp;
  final int speed;
  final int rpm;
  final int throttlePosition;
  final int engineTemp;
  const TripPoint({
    required this.id,
    required this.tripId,
    required this.timestamp,
    required this.speed,
    required this.rpm,
    required this.throttlePosition,
    required this.engineTemp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['trip_id'] = Variable<int>(tripId);
    map['timestamp'] = Variable<int>(timestamp);
    map['speed'] = Variable<int>(speed);
    map['rpm'] = Variable<int>(rpm);
    map['throttle_position'] = Variable<int>(throttlePosition);
    map['engine_temp'] = Variable<int>(engineTemp);
    return map;
  }

  TripPointsCompanion toCompanion(bool nullToAbsent) {
    return TripPointsCompanion(
      id: Value(id),
      tripId: Value(tripId),
      timestamp: Value(timestamp),
      speed: Value(speed),
      rpm: Value(rpm),
      throttlePosition: Value(throttlePosition),
      engineTemp: Value(engineTemp),
    );
  }

  factory TripPoint.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TripPoint(
      id: serializer.fromJson<int>(json['id']),
      tripId: serializer.fromJson<int>(json['tripId']),
      timestamp: serializer.fromJson<int>(json['timestamp']),
      speed: serializer.fromJson<int>(json['speed']),
      rpm: serializer.fromJson<int>(json['rpm']),
      throttlePosition: serializer.fromJson<int>(json['throttlePosition']),
      engineTemp: serializer.fromJson<int>(json['engineTemp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tripId': serializer.toJson<int>(tripId),
      'timestamp': serializer.toJson<int>(timestamp),
      'speed': serializer.toJson<int>(speed),
      'rpm': serializer.toJson<int>(rpm),
      'throttlePosition': serializer.toJson<int>(throttlePosition),
      'engineTemp': serializer.toJson<int>(engineTemp),
    };
  }

  TripPoint copyWith({
    int? id,
    int? tripId,
    int? timestamp,
    int? speed,
    int? rpm,
    int? throttlePosition,
    int? engineTemp,
  }) => TripPoint(
    id: id ?? this.id,
    tripId: tripId ?? this.tripId,
    timestamp: timestamp ?? this.timestamp,
    speed: speed ?? this.speed,
    rpm: rpm ?? this.rpm,
    throttlePosition: throttlePosition ?? this.throttlePosition,
    engineTemp: engineTemp ?? this.engineTemp,
  );
  TripPoint copyWithCompanion(TripPointsCompanion data) {
    return TripPoint(
      id: data.id.present ? data.id.value : this.id,
      tripId: data.tripId.present ? data.tripId.value : this.tripId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      speed: data.speed.present ? data.speed.value : this.speed,
      rpm: data.rpm.present ? data.rpm.value : this.rpm,
      throttlePosition: data.throttlePosition.present
          ? data.throttlePosition.value
          : this.throttlePosition,
      engineTemp: data.engineTemp.present
          ? data.engineTemp.value
          : this.engineTemp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TripPoint(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('timestamp: $timestamp, ')
          ..write('speed: $speed, ')
          ..write('rpm: $rpm, ')
          ..write('throttlePosition: $throttlePosition, ')
          ..write('engineTemp: $engineTemp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tripId,
    timestamp,
    speed,
    rpm,
    throttlePosition,
    engineTemp,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TripPoint &&
          other.id == this.id &&
          other.tripId == this.tripId &&
          other.timestamp == this.timestamp &&
          other.speed == this.speed &&
          other.rpm == this.rpm &&
          other.throttlePosition == this.throttlePosition &&
          other.engineTemp == this.engineTemp);
}

class TripPointsCompanion extends UpdateCompanion<TripPoint> {
  final Value<int> id;
  final Value<int> tripId;
  final Value<int> timestamp;
  final Value<int> speed;
  final Value<int> rpm;
  final Value<int> throttlePosition;
  final Value<int> engineTemp;
  const TripPointsCompanion({
    this.id = const Value.absent(),
    this.tripId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.speed = const Value.absent(),
    this.rpm = const Value.absent(),
    this.throttlePosition = const Value.absent(),
    this.engineTemp = const Value.absent(),
  });
  TripPointsCompanion.insert({
    this.id = const Value.absent(),
    required int tripId,
    required int timestamp,
    required int speed,
    required int rpm,
    required int throttlePosition,
    required int engineTemp,
  }) : tripId = Value(tripId),
       timestamp = Value(timestamp),
       speed = Value(speed),
       rpm = Value(rpm),
       throttlePosition = Value(throttlePosition),
       engineTemp = Value(engineTemp);
  static Insertable<TripPoint> custom({
    Expression<int>? id,
    Expression<int>? tripId,
    Expression<int>? timestamp,
    Expression<int>? speed,
    Expression<int>? rpm,
    Expression<int>? throttlePosition,
    Expression<int>? engineTemp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tripId != null) 'trip_id': tripId,
      if (timestamp != null) 'timestamp': timestamp,
      if (speed != null) 'speed': speed,
      if (rpm != null) 'rpm': rpm,
      if (throttlePosition != null) 'throttle_position': throttlePosition,
      if (engineTemp != null) 'engine_temp': engineTemp,
    });
  }

  TripPointsCompanion copyWith({
    Value<int>? id,
    Value<int>? tripId,
    Value<int>? timestamp,
    Value<int>? speed,
    Value<int>? rpm,
    Value<int>? throttlePosition,
    Value<int>? engineTemp,
  }) {
    return TripPointsCompanion(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      timestamp: timestamp ?? this.timestamp,
      speed: speed ?? this.speed,
      rpm: rpm ?? this.rpm,
      throttlePosition: throttlePosition ?? this.throttlePosition,
      engineTemp: engineTemp ?? this.engineTemp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tripId.present) {
      map['trip_id'] = Variable<int>(tripId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    if (speed.present) {
      map['speed'] = Variable<int>(speed.value);
    }
    if (rpm.present) {
      map['rpm'] = Variable<int>(rpm.value);
    }
    if (throttlePosition.present) {
      map['throttle_position'] = Variable<int>(throttlePosition.value);
    }
    if (engineTemp.present) {
      map['engine_temp'] = Variable<int>(engineTemp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TripPointsCompanion(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('timestamp: $timestamp, ')
          ..write('speed: $speed, ')
          ..write('rpm: $rpm, ')
          ..write('throttlePosition: $throttlePosition, ')
          ..write('engineTemp: $engineTemp')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CarsTable cars = $CarsTable(this);
  late final $TripsTable trips = $TripsTable(this);
  late final $TripPointsTable tripPoints = $TripPointsTable(this);
  late final CarsDao carsDao = CarsDao(this as AppDatabase);
  late final TripsDao tripsDao = TripsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cars, trips, tripPoints];
}

typedef $$CarsTableCreateCompanionBuilder =
    CarsCompanion Function({
      Value<int> id,
      required String vin,
      Value<String?> name,
      Value<int> savedTotalDistance,
      Value<int> lastObdReading,
      Value<bool> isAccuracyWarning,
      Value<int?> oilInterval,
      Value<int> oilLastChangeDistance,
      Value<int?> airFilterInterval,
      Value<int> airFilterLastChangeDistance,
      Value<int?> cabinFilterInterval,
      Value<int> cabinFilterLastChangeDistance,
    });
typedef $$CarsTableUpdateCompanionBuilder =
    CarsCompanion Function({
      Value<int> id,
      Value<String> vin,
      Value<String?> name,
      Value<int> savedTotalDistance,
      Value<int> lastObdReading,
      Value<bool> isAccuracyWarning,
      Value<int?> oilInterval,
      Value<int> oilLastChangeDistance,
      Value<int?> airFilterInterval,
      Value<int> airFilterLastChangeDistance,
      Value<int?> cabinFilterInterval,
      Value<int> cabinFilterLastChangeDistance,
    });

final class $$CarsTableReferences
    extends BaseReferences<_$AppDatabase, $CarsTable, Car> {
  $$CarsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TripsTable, List<Trip>> _tripsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.trips,
    aliasName: 'cars__id__trips__car_id',
  );

  $$TripsTableProcessedTableManager get tripsRefs {
    final manager = $$TripsTableTableManager(
      $_db,
      $_db.trips,
    ).filter((f) => f.carId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_tripsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CarsTableFilterComposer extends Composer<_$AppDatabase, $CarsTable> {
  $$CarsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vin => $composableBuilder(
    column: $table.vin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get savedTotalDistance => $composableBuilder(
    column: $table.savedTotalDistance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastObdReading => $composableBuilder(
    column: $table.lastObdReading,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAccuracyWarning => $composableBuilder(
    column: $table.isAccuracyWarning,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get oilInterval => $composableBuilder(
    column: $table.oilInterval,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get oilLastChangeDistance => $composableBuilder(
    column: $table.oilLastChangeDistance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get airFilterInterval => $composableBuilder(
    column: $table.airFilterInterval,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get airFilterLastChangeDistance => $composableBuilder(
    column: $table.airFilterLastChangeDistance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cabinFilterInterval => $composableBuilder(
    column: $table.cabinFilterInterval,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cabinFilterLastChangeDistance => $composableBuilder(
    column: $table.cabinFilterLastChangeDistance,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> tripsRefs(
    Expression<bool> Function($$TripsTableFilterComposer f) f,
  ) {
    final $$TripsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.carId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableFilterComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CarsTableOrderingComposer extends Composer<_$AppDatabase, $CarsTable> {
  $$CarsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vin => $composableBuilder(
    column: $table.vin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get savedTotalDistance => $composableBuilder(
    column: $table.savedTotalDistance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastObdReading => $composableBuilder(
    column: $table.lastObdReading,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAccuracyWarning => $composableBuilder(
    column: $table.isAccuracyWarning,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get oilInterval => $composableBuilder(
    column: $table.oilInterval,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get oilLastChangeDistance => $composableBuilder(
    column: $table.oilLastChangeDistance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get airFilterInterval => $composableBuilder(
    column: $table.airFilterInterval,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get airFilterLastChangeDistance => $composableBuilder(
    column: $table.airFilterLastChangeDistance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cabinFilterInterval => $composableBuilder(
    column: $table.cabinFilterInterval,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cabinFilterLastChangeDistance => $composableBuilder(
    column: $table.cabinFilterLastChangeDistance,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CarsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CarsTable> {
  $$CarsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get vin =>
      $composableBuilder(column: $table.vin, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get savedTotalDistance => $composableBuilder(
    column: $table.savedTotalDistance,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastObdReading => $composableBuilder(
    column: $table.lastObdReading,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isAccuracyWarning => $composableBuilder(
    column: $table.isAccuracyWarning,
    builder: (column) => column,
  );

  GeneratedColumn<int> get oilInterval => $composableBuilder(
    column: $table.oilInterval,
    builder: (column) => column,
  );

  GeneratedColumn<int> get oilLastChangeDistance => $composableBuilder(
    column: $table.oilLastChangeDistance,
    builder: (column) => column,
  );

  GeneratedColumn<int> get airFilterInterval => $composableBuilder(
    column: $table.airFilterInterval,
    builder: (column) => column,
  );

  GeneratedColumn<int> get airFilterLastChangeDistance => $composableBuilder(
    column: $table.airFilterLastChangeDistance,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cabinFilterInterval => $composableBuilder(
    column: $table.cabinFilterInterval,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cabinFilterLastChangeDistance => $composableBuilder(
    column: $table.cabinFilterLastChangeDistance,
    builder: (column) => column,
  );

  Expression<T> tripsRefs<T extends Object>(
    Expression<T> Function($$TripsTableAnnotationComposer a) f,
  ) {
    final $$TripsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.carId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableAnnotationComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CarsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CarsTable,
          Car,
          $$CarsTableFilterComposer,
          $$CarsTableOrderingComposer,
          $$CarsTableAnnotationComposer,
          $$CarsTableCreateCompanionBuilder,
          $$CarsTableUpdateCompanionBuilder,
          (Car, $$CarsTableReferences),
          Car,
          PrefetchHooks Function({bool tripsRefs})
        > {
  $$CarsTableTableManager(_$AppDatabase db, $CarsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CarsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CarsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CarsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> vin = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<int> savedTotalDistance = const Value.absent(),
                Value<int> lastObdReading = const Value.absent(),
                Value<bool> isAccuracyWarning = const Value.absent(),
                Value<int?> oilInterval = const Value.absent(),
                Value<int> oilLastChangeDistance = const Value.absent(),
                Value<int?> airFilterInterval = const Value.absent(),
                Value<int> airFilterLastChangeDistance = const Value.absent(),
                Value<int?> cabinFilterInterval = const Value.absent(),
                Value<int> cabinFilterLastChangeDistance = const Value.absent(),
              }) => CarsCompanion(
                id: id,
                vin: vin,
                name: name,
                savedTotalDistance: savedTotalDistance,
                lastObdReading: lastObdReading,
                isAccuracyWarning: isAccuracyWarning,
                oilInterval: oilInterval,
                oilLastChangeDistance: oilLastChangeDistance,
                airFilterInterval: airFilterInterval,
                airFilterLastChangeDistance: airFilterLastChangeDistance,
                cabinFilterInterval: cabinFilterInterval,
                cabinFilterLastChangeDistance: cabinFilterLastChangeDistance,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String vin,
                Value<String?> name = const Value.absent(),
                Value<int> savedTotalDistance = const Value.absent(),
                Value<int> lastObdReading = const Value.absent(),
                Value<bool> isAccuracyWarning = const Value.absent(),
                Value<int?> oilInterval = const Value.absent(),
                Value<int> oilLastChangeDistance = const Value.absent(),
                Value<int?> airFilterInterval = const Value.absent(),
                Value<int> airFilterLastChangeDistance = const Value.absent(),
                Value<int?> cabinFilterInterval = const Value.absent(),
                Value<int> cabinFilterLastChangeDistance = const Value.absent(),
              }) => CarsCompanion.insert(
                id: id,
                vin: vin,
                name: name,
                savedTotalDistance: savedTotalDistance,
                lastObdReading: lastObdReading,
                isAccuracyWarning: isAccuracyWarning,
                oilInterval: oilInterval,
                oilLastChangeDistance: oilLastChangeDistance,
                airFilterInterval: airFilterInterval,
                airFilterLastChangeDistance: airFilterLastChangeDistance,
                cabinFilterInterval: cabinFilterInterval,
                cabinFilterLastChangeDistance: cabinFilterLastChangeDistance,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$CarsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({tripsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (tripsRefs) db.trips],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (tripsRefs)
                    await $_getPrefetchedData<Car, $CarsTable, Trip>(
                      currentTable: table,
                      referencedTable: $$CarsTableReferences._tripsRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$CarsTableReferences(db, table, p0).tripsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.carId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CarsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CarsTable,
      Car,
      $$CarsTableFilterComposer,
      $$CarsTableOrderingComposer,
      $$CarsTableAnnotationComposer,
      $$CarsTableCreateCompanionBuilder,
      $$CarsTableUpdateCompanionBuilder,
      (Car, $$CarsTableReferences),
      Car,
      PrefetchHooks Function({bool tripsRefs})
    >;
typedef $$TripsTableCreateCompanionBuilder =
    TripsCompanion Function({
      Value<int> id,
      required int carId,
      required int startTimestamp,
      Value<int?> endTimestamp,
      Value<int> totalDistance,
      Value<int?> averageRpm,
      Value<int?> averageSpeed,
    });
typedef $$TripsTableUpdateCompanionBuilder =
    TripsCompanion Function({
      Value<int> id,
      Value<int> carId,
      Value<int> startTimestamp,
      Value<int?> endTimestamp,
      Value<int> totalDistance,
      Value<int?> averageRpm,
      Value<int?> averageSpeed,
    });

final class $$TripsTableReferences
    extends BaseReferences<_$AppDatabase, $TripsTable, Trip> {
  $$TripsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CarsTable _carIdTable(_$AppDatabase db) =>
      db.cars.createAlias('trips__car_id__cars__id');

  $$CarsTableProcessedTableManager get carId {
    final $_column = $_itemColumn<int>('car_id')!;

    final manager = $$CarsTableTableManager(
      $_db,
      $_db.cars,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_carIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TripPointsTable, List<TripPoint>>
  _tripPointsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.tripPoints,
    aliasName: 'trips__id__trip_points__trip_id',
  );

  $$TripPointsTableProcessedTableManager get tripPointsRefs {
    final manager = $$TripPointsTableTableManager(
      $_db,
      $_db.tripPoints,
    ).filter((f) => f.tripId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_tripPointsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TripsTableFilterComposer extends Composer<_$AppDatabase, $TripsTable> {
  $$TripsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startTimestamp => $composableBuilder(
    column: $table.startTimestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endTimestamp => $composableBuilder(
    column: $table.endTimestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalDistance => $composableBuilder(
    column: $table.totalDistance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get averageRpm => $composableBuilder(
    column: $table.averageRpm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get averageSpeed => $composableBuilder(
    column: $table.averageSpeed,
    builder: (column) => ColumnFilters(column),
  );

  $$CarsTableFilterComposer get carId {
    final $$CarsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.carId,
      referencedTable: $db.cars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CarsTableFilterComposer(
            $db: $db,
            $table: $db.cars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> tripPointsRefs(
    Expression<bool> Function($$TripPointsTableFilterComposer f) f,
  ) {
    final $$TripPointsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tripPoints,
      getReferencedColumn: (t) => t.tripId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripPointsTableFilterComposer(
            $db: $db,
            $table: $db.tripPoints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TripsTableOrderingComposer
    extends Composer<_$AppDatabase, $TripsTable> {
  $$TripsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startTimestamp => $composableBuilder(
    column: $table.startTimestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endTimestamp => $composableBuilder(
    column: $table.endTimestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalDistance => $composableBuilder(
    column: $table.totalDistance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get averageRpm => $composableBuilder(
    column: $table.averageRpm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get averageSpeed => $composableBuilder(
    column: $table.averageSpeed,
    builder: (column) => ColumnOrderings(column),
  );

  $$CarsTableOrderingComposer get carId {
    final $$CarsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.carId,
      referencedTable: $db.cars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CarsTableOrderingComposer(
            $db: $db,
            $table: $db.cars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TripsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TripsTable> {
  $$TripsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get startTimestamp => $composableBuilder(
    column: $table.startTimestamp,
    builder: (column) => column,
  );

  GeneratedColumn<int> get endTimestamp => $composableBuilder(
    column: $table.endTimestamp,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalDistance => $composableBuilder(
    column: $table.totalDistance,
    builder: (column) => column,
  );

  GeneratedColumn<int> get averageRpm => $composableBuilder(
    column: $table.averageRpm,
    builder: (column) => column,
  );

  GeneratedColumn<int> get averageSpeed => $composableBuilder(
    column: $table.averageSpeed,
    builder: (column) => column,
  );

  $$CarsTableAnnotationComposer get carId {
    final $$CarsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.carId,
      referencedTable: $db.cars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CarsTableAnnotationComposer(
            $db: $db,
            $table: $db.cars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> tripPointsRefs<T extends Object>(
    Expression<T> Function($$TripPointsTableAnnotationComposer a) f,
  ) {
    final $$TripPointsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tripPoints,
      getReferencedColumn: (t) => t.tripId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripPointsTableAnnotationComposer(
            $db: $db,
            $table: $db.tripPoints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TripsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TripsTable,
          Trip,
          $$TripsTableFilterComposer,
          $$TripsTableOrderingComposer,
          $$TripsTableAnnotationComposer,
          $$TripsTableCreateCompanionBuilder,
          $$TripsTableUpdateCompanionBuilder,
          (Trip, $$TripsTableReferences),
          Trip,
          PrefetchHooks Function({bool carId, bool tripPointsRefs})
        > {
  $$TripsTableTableManager(_$AppDatabase db, $TripsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TripsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TripsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TripsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> carId = const Value.absent(),
                Value<int> startTimestamp = const Value.absent(),
                Value<int?> endTimestamp = const Value.absent(),
                Value<int> totalDistance = const Value.absent(),
                Value<int?> averageRpm = const Value.absent(),
                Value<int?> averageSpeed = const Value.absent(),
              }) => TripsCompanion(
                id: id,
                carId: carId,
                startTimestamp: startTimestamp,
                endTimestamp: endTimestamp,
                totalDistance: totalDistance,
                averageRpm: averageRpm,
                averageSpeed: averageSpeed,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int carId,
                required int startTimestamp,
                Value<int?> endTimestamp = const Value.absent(),
                Value<int> totalDistance = const Value.absent(),
                Value<int?> averageRpm = const Value.absent(),
                Value<int?> averageSpeed = const Value.absent(),
              }) => TripsCompanion.insert(
                id: id,
                carId: carId,
                startTimestamp: startTimestamp,
                endTimestamp: endTimestamp,
                totalDistance: totalDistance,
                averageRpm: averageRpm,
                averageSpeed: averageSpeed,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TripsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({carId = false, tripPointsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (tripPointsRefs) db.tripPoints],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (carId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.carId,
                                referencedTable: $$TripsTableReferences
                                    ._carIdTable(db),
                                referencedColumn: $$TripsTableReferences
                                    ._carIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (tripPointsRefs)
                    await $_getPrefetchedData<Trip, $TripsTable, TripPoint>(
                      currentTable: table,
                      referencedTable: $$TripsTableReferences
                          ._tripPointsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TripsTableReferences(db, table, p0).tripPointsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.tripId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TripsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TripsTable,
      Trip,
      $$TripsTableFilterComposer,
      $$TripsTableOrderingComposer,
      $$TripsTableAnnotationComposer,
      $$TripsTableCreateCompanionBuilder,
      $$TripsTableUpdateCompanionBuilder,
      (Trip, $$TripsTableReferences),
      Trip,
      PrefetchHooks Function({bool carId, bool tripPointsRefs})
    >;
typedef $$TripPointsTableCreateCompanionBuilder =
    TripPointsCompanion Function({
      Value<int> id,
      required int tripId,
      required int timestamp,
      required int speed,
      required int rpm,
      required int throttlePosition,
      required int engineTemp,
    });
typedef $$TripPointsTableUpdateCompanionBuilder =
    TripPointsCompanion Function({
      Value<int> id,
      Value<int> tripId,
      Value<int> timestamp,
      Value<int> speed,
      Value<int> rpm,
      Value<int> throttlePosition,
      Value<int> engineTemp,
    });

final class $$TripPointsTableReferences
    extends BaseReferences<_$AppDatabase, $TripPointsTable, TripPoint> {
  $$TripPointsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TripsTable _tripIdTable(_$AppDatabase db) =>
      db.trips.createAlias('trip_points__trip_id__trips__id');

  $$TripsTableProcessedTableManager get tripId {
    final $_column = $_itemColumn<int>('trip_id')!;

    final manager = $$TripsTableTableManager(
      $_db,
      $_db.trips,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tripIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TripPointsTableFilterComposer
    extends Composer<_$AppDatabase, $TripPointsTable> {
  $$TripPointsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get speed => $composableBuilder(
    column: $table.speed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rpm => $composableBuilder(
    column: $table.rpm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get throttlePosition => $composableBuilder(
    column: $table.throttlePosition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get engineTemp => $composableBuilder(
    column: $table.engineTemp,
    builder: (column) => ColumnFilters(column),
  );

  $$TripsTableFilterComposer get tripId {
    final $$TripsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableFilterComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TripPointsTableOrderingComposer
    extends Composer<_$AppDatabase, $TripPointsTable> {
  $$TripPointsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get speed => $composableBuilder(
    column: $table.speed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rpm => $composableBuilder(
    column: $table.rpm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get throttlePosition => $composableBuilder(
    column: $table.throttlePosition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get engineTemp => $composableBuilder(
    column: $table.engineTemp,
    builder: (column) => ColumnOrderings(column),
  );

  $$TripsTableOrderingComposer get tripId {
    final $$TripsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableOrderingComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TripPointsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TripPointsTable> {
  $$TripPointsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<int> get speed =>
      $composableBuilder(column: $table.speed, builder: (column) => column);

  GeneratedColumn<int> get rpm =>
      $composableBuilder(column: $table.rpm, builder: (column) => column);

  GeneratedColumn<int> get throttlePosition => $composableBuilder(
    column: $table.throttlePosition,
    builder: (column) => column,
  );

  GeneratedColumn<int> get engineTemp => $composableBuilder(
    column: $table.engineTemp,
    builder: (column) => column,
  );

  $$TripsTableAnnotationComposer get tripId {
    final $$TripsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableAnnotationComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TripPointsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TripPointsTable,
          TripPoint,
          $$TripPointsTableFilterComposer,
          $$TripPointsTableOrderingComposer,
          $$TripPointsTableAnnotationComposer,
          $$TripPointsTableCreateCompanionBuilder,
          $$TripPointsTableUpdateCompanionBuilder,
          (TripPoint, $$TripPointsTableReferences),
          TripPoint,
          PrefetchHooks Function({bool tripId})
        > {
  $$TripPointsTableTableManager(_$AppDatabase db, $TripPointsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TripPointsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TripPointsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TripPointsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tripId = const Value.absent(),
                Value<int> timestamp = const Value.absent(),
                Value<int> speed = const Value.absent(),
                Value<int> rpm = const Value.absent(),
                Value<int> throttlePosition = const Value.absent(),
                Value<int> engineTemp = const Value.absent(),
              }) => TripPointsCompanion(
                id: id,
                tripId: tripId,
                timestamp: timestamp,
                speed: speed,
                rpm: rpm,
                throttlePosition: throttlePosition,
                engineTemp: engineTemp,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int tripId,
                required int timestamp,
                required int speed,
                required int rpm,
                required int throttlePosition,
                required int engineTemp,
              }) => TripPointsCompanion.insert(
                id: id,
                tripId: tripId,
                timestamp: timestamp,
                speed: speed,
                rpm: rpm,
                throttlePosition: throttlePosition,
                engineTemp: engineTemp,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TripPointsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({tripId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (tripId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tripId,
                                referencedTable: $$TripPointsTableReferences
                                    ._tripIdTable(db),
                                referencedColumn: $$TripPointsTableReferences
                                    ._tripIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TripPointsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TripPointsTable,
      TripPoint,
      $$TripPointsTableFilterComposer,
      $$TripPointsTableOrderingComposer,
      $$TripPointsTableAnnotationComposer,
      $$TripPointsTableCreateCompanionBuilder,
      $$TripPointsTableUpdateCompanionBuilder,
      (TripPoint, $$TripPointsTableReferences),
      TripPoint,
      PrefetchHooks Function({bool tripId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CarsTableTableManager get cars => $$CarsTableTableManager(_db, _db.cars);
  $$TripsTableTableManager get trips =>
      $$TripsTableTableManager(_db, _db.trips);
  $$TripPointsTableTableManager get tripPoints =>
      $$TripPointsTableTableManager(_db, _db.tripPoints);
}
