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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vin,
    name,
    savedTotalDistance,
    lastObdReading,
    isAccuracyWarning,
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
  const Car({
    required this.id,
    required this.vin,
    this.name,
    required this.savedTotalDistance,
    required this.lastObdReading,
    required this.isAccuracyWarning,
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
    };
  }

  Car copyWith({
    int? id,
    String? vin,
    Value<String?> name = const Value.absent(),
    int? savedTotalDistance,
    int? lastObdReading,
    bool? isAccuracyWarning,
  }) => Car(
    id: id ?? this.id,
    vin: vin ?? this.vin,
    name: name.present ? name.value : this.name,
    savedTotalDistance: savedTotalDistance ?? this.savedTotalDistance,
    lastObdReading: lastObdReading ?? this.lastObdReading,
    isAccuracyWarning: isAccuracyWarning ?? this.isAccuracyWarning,
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
          ..write('isAccuracyWarning: $isAccuracyWarning')
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
          other.isAccuracyWarning == this.isAccuracyWarning);
}

class CarsCompanion extends UpdateCompanion<Car> {
  final Value<int> id;
  final Value<String> vin;
  final Value<String?> name;
  final Value<int> savedTotalDistance;
  final Value<int> lastObdReading;
  final Value<bool> isAccuracyWarning;
  const CarsCompanion({
    this.id = const Value.absent(),
    this.vin = const Value.absent(),
    this.name = const Value.absent(),
    this.savedTotalDistance = const Value.absent(),
    this.lastObdReading = const Value.absent(),
    this.isAccuracyWarning = const Value.absent(),
  });
  CarsCompanion.insert({
    this.id = const Value.absent(),
    required String vin,
    this.name = const Value.absent(),
    this.savedTotalDistance = const Value.absent(),
    this.lastObdReading = const Value.absent(),
    this.isAccuracyWarning = const Value.absent(),
  }) : vin = Value(vin);
  static Insertable<Car> custom({
    Expression<int>? id,
    Expression<String>? vin,
    Expression<String>? name,
    Expression<int>? savedTotalDistance,
    Expression<int>? lastObdReading,
    Expression<bool>? isAccuracyWarning,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vin != null) 'vin': vin,
      if (name != null) 'name': name,
      if (savedTotalDistance != null)
        'saved_total_distance': savedTotalDistance,
      if (lastObdReading != null) 'last_obd_reading': lastObdReading,
      if (isAccuracyWarning != null) 'is_accuracy_warning': isAccuracyWarning,
    });
  }

  CarsCompanion copyWith({
    Value<int>? id,
    Value<String>? vin,
    Value<String?>? name,
    Value<int>? savedTotalDistance,
    Value<int>? lastObdReading,
    Value<bool>? isAccuracyWarning,
  }) {
    return CarsCompanion(
      id: id ?? this.id,
      vin: vin ?? this.vin,
      name: name ?? this.name,
      savedTotalDistance: savedTotalDistance ?? this.savedTotalDistance,
      lastObdReading: lastObdReading ?? this.lastObdReading,
      isAccuracyWarning: isAccuracyWarning ?? this.isAccuracyWarning,
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
          ..write('isAccuracyWarning: $isAccuracyWarning')
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
      'REFERENCES cars (id) ON DELETE CASCADE',
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
      'REFERENCES trips (id) ON DELETE CASCADE',
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
  static const VerificationMeta _coolantTempMeta = const VerificationMeta(
    'coolantTemp',
  );
  @override
  late final GeneratedColumn<int> coolantTemp = GeneratedColumn<int>(
    'coolant_temp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _engineOilTempMeta = const VerificationMeta(
    'engineOilTemp',
  );
  @override
  late final GeneratedColumn<int> engineOilTemp = GeneratedColumn<int>(
    'engine_oil_temp',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _intakeAirTempMeta = const VerificationMeta(
    'intakeAirTemp',
  );
  @override
  late final GeneratedColumn<int> intakeAirTemp = GeneratedColumn<int>(
    'intake_air_temp',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fuelLevelMeta = const VerificationMeta(
    'fuelLevel',
  );
  @override
  late final GeneratedColumn<int> fuelLevel = GeneratedColumn<int>(
    'fuel_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mafMeta = const VerificationMeta('maf');
  @override
  late final GeneratedColumn<double> maf = GeneratedColumn<double>(
    'maf',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tripId,
    timestamp,
    speed,
    rpm,
    throttlePosition,
    coolantTemp,
    latitude,
    longitude,
    engineOilTemp,
    intakeAirTemp,
    fuelLevel,
    maf,
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
    if (data.containsKey('coolant_temp')) {
      context.handle(
        _coolantTempMeta,
        coolantTemp.isAcceptableOrUnknown(
          data['coolant_temp']!,
          _coolantTempMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_coolantTempMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('engine_oil_temp')) {
      context.handle(
        _engineOilTempMeta,
        engineOilTemp.isAcceptableOrUnknown(
          data['engine_oil_temp']!,
          _engineOilTempMeta,
        ),
      );
    }
    if (data.containsKey('intake_air_temp')) {
      context.handle(
        _intakeAirTempMeta,
        intakeAirTemp.isAcceptableOrUnknown(
          data['intake_air_temp']!,
          _intakeAirTempMeta,
        ),
      );
    }
    if (data.containsKey('fuel_level')) {
      context.handle(
        _fuelLevelMeta,
        fuelLevel.isAcceptableOrUnknown(data['fuel_level']!, _fuelLevelMeta),
      );
    }
    if (data.containsKey('maf')) {
      context.handle(
        _mafMeta,
        maf.isAcceptableOrUnknown(data['maf']!, _mafMeta),
      );
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
      coolantTemp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}coolant_temp'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      engineOilTemp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}engine_oil_temp'],
      ),
      intakeAirTemp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}intake_air_temp'],
      ),
      fuelLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fuel_level'],
      ),
      maf: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}maf'],
      ),
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
  final int coolantTemp;
  final double? latitude;
  final double? longitude;
  final int? engineOilTemp;
  final int? intakeAirTemp;
  final int? fuelLevel;
  final double? maf;
  const TripPoint({
    required this.id,
    required this.tripId,
    required this.timestamp,
    required this.speed,
    required this.rpm,
    required this.throttlePosition,
    required this.coolantTemp,
    this.latitude,
    this.longitude,
    this.engineOilTemp,
    this.intakeAirTemp,
    this.fuelLevel,
    this.maf,
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
    map['coolant_temp'] = Variable<int>(coolantTemp);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || engineOilTemp != null) {
      map['engine_oil_temp'] = Variable<int>(engineOilTemp);
    }
    if (!nullToAbsent || intakeAirTemp != null) {
      map['intake_air_temp'] = Variable<int>(intakeAirTemp);
    }
    if (!nullToAbsent || fuelLevel != null) {
      map['fuel_level'] = Variable<int>(fuelLevel);
    }
    if (!nullToAbsent || maf != null) {
      map['maf'] = Variable<double>(maf);
    }
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
      coolantTemp: Value(coolantTemp),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      engineOilTemp: engineOilTemp == null && nullToAbsent
          ? const Value.absent()
          : Value(engineOilTemp),
      intakeAirTemp: intakeAirTemp == null && nullToAbsent
          ? const Value.absent()
          : Value(intakeAirTemp),
      fuelLevel: fuelLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(fuelLevel),
      maf: maf == null && nullToAbsent ? const Value.absent() : Value(maf),
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
      coolantTemp: serializer.fromJson<int>(json['coolantTemp']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      engineOilTemp: serializer.fromJson<int?>(json['engineOilTemp']),
      intakeAirTemp: serializer.fromJson<int?>(json['intakeAirTemp']),
      fuelLevel: serializer.fromJson<int?>(json['fuelLevel']),
      maf: serializer.fromJson<double?>(json['maf']),
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
      'coolantTemp': serializer.toJson<int>(coolantTemp),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'engineOilTemp': serializer.toJson<int?>(engineOilTemp),
      'intakeAirTemp': serializer.toJson<int?>(intakeAirTemp),
      'fuelLevel': serializer.toJson<int?>(fuelLevel),
      'maf': serializer.toJson<double?>(maf),
    };
  }

  TripPoint copyWith({
    int? id,
    int? tripId,
    int? timestamp,
    int? speed,
    int? rpm,
    int? throttlePosition,
    int? coolantTemp,
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<int?> engineOilTemp = const Value.absent(),
    Value<int?> intakeAirTemp = const Value.absent(),
    Value<int?> fuelLevel = const Value.absent(),
    Value<double?> maf = const Value.absent(),
  }) => TripPoint(
    id: id ?? this.id,
    tripId: tripId ?? this.tripId,
    timestamp: timestamp ?? this.timestamp,
    speed: speed ?? this.speed,
    rpm: rpm ?? this.rpm,
    throttlePosition: throttlePosition ?? this.throttlePosition,
    coolantTemp: coolantTemp ?? this.coolantTemp,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    engineOilTemp: engineOilTemp.present
        ? engineOilTemp.value
        : this.engineOilTemp,
    intakeAirTemp: intakeAirTemp.present
        ? intakeAirTemp.value
        : this.intakeAirTemp,
    fuelLevel: fuelLevel.present ? fuelLevel.value : this.fuelLevel,
    maf: maf.present ? maf.value : this.maf,
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
      coolantTemp: data.coolantTemp.present
          ? data.coolantTemp.value
          : this.coolantTemp,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      engineOilTemp: data.engineOilTemp.present
          ? data.engineOilTemp.value
          : this.engineOilTemp,
      intakeAirTemp: data.intakeAirTemp.present
          ? data.intakeAirTemp.value
          : this.intakeAirTemp,
      fuelLevel: data.fuelLevel.present ? data.fuelLevel.value : this.fuelLevel,
      maf: data.maf.present ? data.maf.value : this.maf,
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
          ..write('coolantTemp: $coolantTemp, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('engineOilTemp: $engineOilTemp, ')
          ..write('intakeAirTemp: $intakeAirTemp, ')
          ..write('fuelLevel: $fuelLevel, ')
          ..write('maf: $maf')
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
    coolantTemp,
    latitude,
    longitude,
    engineOilTemp,
    intakeAirTemp,
    fuelLevel,
    maf,
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
          other.coolantTemp == this.coolantTemp &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.engineOilTemp == this.engineOilTemp &&
          other.intakeAirTemp == this.intakeAirTemp &&
          other.fuelLevel == this.fuelLevel &&
          other.maf == this.maf);
}

class TripPointsCompanion extends UpdateCompanion<TripPoint> {
  final Value<int> id;
  final Value<int> tripId;
  final Value<int> timestamp;
  final Value<int> speed;
  final Value<int> rpm;
  final Value<int> throttlePosition;
  final Value<int> coolantTemp;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<int?> engineOilTemp;
  final Value<int?> intakeAirTemp;
  final Value<int?> fuelLevel;
  final Value<double?> maf;
  const TripPointsCompanion({
    this.id = const Value.absent(),
    this.tripId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.speed = const Value.absent(),
    this.rpm = const Value.absent(),
    this.throttlePosition = const Value.absent(),
    this.coolantTemp = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.engineOilTemp = const Value.absent(),
    this.intakeAirTemp = const Value.absent(),
    this.fuelLevel = const Value.absent(),
    this.maf = const Value.absent(),
  });
  TripPointsCompanion.insert({
    this.id = const Value.absent(),
    required int tripId,
    required int timestamp,
    required int speed,
    required int rpm,
    required int throttlePosition,
    required int coolantTemp,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.engineOilTemp = const Value.absent(),
    this.intakeAirTemp = const Value.absent(),
    this.fuelLevel = const Value.absent(),
    this.maf = const Value.absent(),
  }) : tripId = Value(tripId),
       timestamp = Value(timestamp),
       speed = Value(speed),
       rpm = Value(rpm),
       throttlePosition = Value(throttlePosition),
       coolantTemp = Value(coolantTemp);
  static Insertable<TripPoint> custom({
    Expression<int>? id,
    Expression<int>? tripId,
    Expression<int>? timestamp,
    Expression<int>? speed,
    Expression<int>? rpm,
    Expression<int>? throttlePosition,
    Expression<int>? coolantTemp,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<int>? engineOilTemp,
    Expression<int>? intakeAirTemp,
    Expression<int>? fuelLevel,
    Expression<double>? maf,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tripId != null) 'trip_id': tripId,
      if (timestamp != null) 'timestamp': timestamp,
      if (speed != null) 'speed': speed,
      if (rpm != null) 'rpm': rpm,
      if (throttlePosition != null) 'throttle_position': throttlePosition,
      if (coolantTemp != null) 'coolant_temp': coolantTemp,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (engineOilTemp != null) 'engine_oil_temp': engineOilTemp,
      if (intakeAirTemp != null) 'intake_air_temp': intakeAirTemp,
      if (fuelLevel != null) 'fuel_level': fuelLevel,
      if (maf != null) 'maf': maf,
    });
  }

  TripPointsCompanion copyWith({
    Value<int>? id,
    Value<int>? tripId,
    Value<int>? timestamp,
    Value<int>? speed,
    Value<int>? rpm,
    Value<int>? throttlePosition,
    Value<int>? coolantTemp,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<int?>? engineOilTemp,
    Value<int?>? intakeAirTemp,
    Value<int?>? fuelLevel,
    Value<double?>? maf,
  }) {
    return TripPointsCompanion(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      timestamp: timestamp ?? this.timestamp,
      speed: speed ?? this.speed,
      rpm: rpm ?? this.rpm,
      throttlePosition: throttlePosition ?? this.throttlePosition,
      coolantTemp: coolantTemp ?? this.coolantTemp,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      engineOilTemp: engineOilTemp ?? this.engineOilTemp,
      intakeAirTemp: intakeAirTemp ?? this.intakeAirTemp,
      fuelLevel: fuelLevel ?? this.fuelLevel,
      maf: maf ?? this.maf,
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
    if (coolantTemp.present) {
      map['coolant_temp'] = Variable<int>(coolantTemp.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (engineOilTemp.present) {
      map['engine_oil_temp'] = Variable<int>(engineOilTemp.value);
    }
    if (intakeAirTemp.present) {
      map['intake_air_temp'] = Variable<int>(intakeAirTemp.value);
    }
    if (fuelLevel.present) {
      map['fuel_level'] = Variable<int>(fuelLevel.value);
    }
    if (maf.present) {
      map['maf'] = Variable<double>(maf.value);
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
          ..write('coolantTemp: $coolantTemp, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('engineOilTemp: $engineOilTemp, ')
          ..write('intakeAirTemp: $intakeAirTemp, ')
          ..write('fuelLevel: $fuelLevel, ')
          ..write('maf: $maf')
          ..write(')'))
        .toString();
  }
}

class $DtcCacheTable extends DtcCache
    with TableInfo<$DtcCacheTable, DtcCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DtcCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [code, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dtc_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<DtcCacheData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {code};
  @override
  DtcCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DtcCacheData(
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
    );
  }

  @override
  $DtcCacheTable createAlias(String alias) {
    return $DtcCacheTable(attachedDatabase, alias);
  }
}

class DtcCacheData extends DataClass implements Insertable<DtcCacheData> {
  final String code;
  final String description;
  const DtcCacheData({required this.code, required this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['description'] = Variable<String>(description);
    return map;
  }

  DtcCacheCompanion toCompanion(bool nullToAbsent) {
    return DtcCacheCompanion(
      code: Value(code),
      description: Value(description),
    );
  }

  factory DtcCacheData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DtcCacheData(
      code: serializer.fromJson<String>(json['code']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'description': serializer.toJson<String>(description),
    };
  }

  DtcCacheData copyWith({String? code, String? description}) => DtcCacheData(
    code: code ?? this.code,
    description: description ?? this.description,
  );
  DtcCacheData copyWithCompanion(DtcCacheCompanion data) {
    return DtcCacheData(
      code: data.code.present ? data.code.value : this.code,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DtcCacheData(')
          ..write('code: $code, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DtcCacheData &&
          other.code == this.code &&
          other.description == this.description);
}

class DtcCacheCompanion extends UpdateCompanion<DtcCacheData> {
  final Value<String> code;
  final Value<String> description;
  final Value<int> rowid;
  const DtcCacheCompanion({
    this.code = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DtcCacheCompanion.insert({
    required String code,
    required String description,
    this.rowid = const Value.absent(),
  }) : code = Value(code),
       description = Value(description);
  static Insertable<DtcCacheData> custom({
    Expression<String>? code,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DtcCacheCompanion copyWith({
    Value<String>? code,
    Value<String>? description,
    Value<int>? rowid,
  }) {
    return DtcCacheCompanion(
      code: code ?? this.code,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DtcCacheCompanion(')
          ..write('code: $code, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MaintenanceTasksTable extends MaintenanceTasks
    with TableInfo<$MaintenanceTasksTable, MaintenanceTask> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MaintenanceTasksTable(this.attachedDatabase, [this._alias]);
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
      'REFERENCES cars (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _intervalKmMeta = const VerificationMeta(
    'intervalKm',
  );
  @override
  late final GeneratedColumn<int> intervalKm = GeneratedColumn<int>(
    'interval_km',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastChangeKmMeta = const VerificationMeta(
    'lastChangeKm',
  );
  @override
  late final GeneratedColumn<int> lastChangeKm = GeneratedColumn<int>(
    'last_change_km',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    carId,
    title,
    description,
    intervalKm,
    lastChangeKm,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'maintenance_tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<MaintenanceTask> instance, {
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
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('interval_km')) {
      context.handle(
        _intervalKmMeta,
        intervalKm.isAcceptableOrUnknown(data['interval_km']!, _intervalKmMeta),
      );
    } else if (isInserting) {
      context.missing(_intervalKmMeta);
    }
    if (data.containsKey('last_change_km')) {
      context.handle(
        _lastChangeKmMeta,
        lastChangeKm.isAcceptableOrUnknown(
          data['last_change_km']!,
          _lastChangeKmMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastChangeKmMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MaintenanceTask map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MaintenanceTask(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      carId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}car_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      intervalKm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_km'],
      )!,
      lastChangeKm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_change_km'],
      )!,
    );
  }

  @override
  $MaintenanceTasksTable createAlias(String alias) {
    return $MaintenanceTasksTable(attachedDatabase, alias);
  }
}

class MaintenanceTask extends DataClass implements Insertable<MaintenanceTask> {
  final int id;
  final int carId;
  final String title;
  final String? description;
  final int intervalKm;
  final int lastChangeKm;
  const MaintenanceTask({
    required this.id,
    required this.carId,
    required this.title,
    this.description,
    required this.intervalKm,
    required this.lastChangeKm,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['car_id'] = Variable<int>(carId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['interval_km'] = Variable<int>(intervalKm);
    map['last_change_km'] = Variable<int>(lastChangeKm);
    return map;
  }

  MaintenanceTasksCompanion toCompanion(bool nullToAbsent) {
    return MaintenanceTasksCompanion(
      id: Value(id),
      carId: Value(carId),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      intervalKm: Value(intervalKm),
      lastChangeKm: Value(lastChangeKm),
    );
  }

  factory MaintenanceTask.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MaintenanceTask(
      id: serializer.fromJson<int>(json['id']),
      carId: serializer.fromJson<int>(json['carId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      intervalKm: serializer.fromJson<int>(json['intervalKm']),
      lastChangeKm: serializer.fromJson<int>(json['lastChangeKm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'carId': serializer.toJson<int>(carId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'intervalKm': serializer.toJson<int>(intervalKm),
      'lastChangeKm': serializer.toJson<int>(lastChangeKm),
    };
  }

  MaintenanceTask copyWith({
    int? id,
    int? carId,
    String? title,
    Value<String?> description = const Value.absent(),
    int? intervalKm,
    int? lastChangeKm,
  }) => MaintenanceTask(
    id: id ?? this.id,
    carId: carId ?? this.carId,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    intervalKm: intervalKm ?? this.intervalKm,
    lastChangeKm: lastChangeKm ?? this.lastChangeKm,
  );
  MaintenanceTask copyWithCompanion(MaintenanceTasksCompanion data) {
    return MaintenanceTask(
      id: data.id.present ? data.id.value : this.id,
      carId: data.carId.present ? data.carId.value : this.carId,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      intervalKm: data.intervalKm.present
          ? data.intervalKm.value
          : this.intervalKm,
      lastChangeKm: data.lastChangeKm.present
          ? data.lastChangeKm.value
          : this.lastChangeKm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceTask(')
          ..write('id: $id, ')
          ..write('carId: $carId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('intervalKm: $intervalKm, ')
          ..write('lastChangeKm: $lastChangeKm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, carId, title, description, intervalKm, lastChangeKm);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MaintenanceTask &&
          other.id == this.id &&
          other.carId == this.carId &&
          other.title == this.title &&
          other.description == this.description &&
          other.intervalKm == this.intervalKm &&
          other.lastChangeKm == this.lastChangeKm);
}

class MaintenanceTasksCompanion extends UpdateCompanion<MaintenanceTask> {
  final Value<int> id;
  final Value<int> carId;
  final Value<String> title;
  final Value<String?> description;
  final Value<int> intervalKm;
  final Value<int> lastChangeKm;
  const MaintenanceTasksCompanion({
    this.id = const Value.absent(),
    this.carId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.intervalKm = const Value.absent(),
    this.lastChangeKm = const Value.absent(),
  });
  MaintenanceTasksCompanion.insert({
    this.id = const Value.absent(),
    required int carId,
    required String title,
    this.description = const Value.absent(),
    required int intervalKm,
    required int lastChangeKm,
  }) : carId = Value(carId),
       title = Value(title),
       intervalKm = Value(intervalKm),
       lastChangeKm = Value(lastChangeKm);
  static Insertable<MaintenanceTask> custom({
    Expression<int>? id,
    Expression<int>? carId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? intervalKm,
    Expression<int>? lastChangeKm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (carId != null) 'car_id': carId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (intervalKm != null) 'interval_km': intervalKm,
      if (lastChangeKm != null) 'last_change_km': lastChangeKm,
    });
  }

  MaintenanceTasksCompanion copyWith({
    Value<int>? id,
    Value<int>? carId,
    Value<String>? title,
    Value<String?>? description,
    Value<int>? intervalKm,
    Value<int>? lastChangeKm,
  }) {
    return MaintenanceTasksCompanion(
      id: id ?? this.id,
      carId: carId ?? this.carId,
      title: title ?? this.title,
      description: description ?? this.description,
      intervalKm: intervalKm ?? this.intervalKm,
      lastChangeKm: lastChangeKm ?? this.lastChangeKm,
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
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (intervalKm.present) {
      map['interval_km'] = Variable<int>(intervalKm.value);
    }
    if (lastChangeKm.present) {
      map['last_change_km'] = Variable<int>(lastChangeKm.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceTasksCompanion(')
          ..write('id: $id, ')
          ..write('carId: $carId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('intervalKm: $intervalKm, ')
          ..write('lastChangeKm: $lastChangeKm')
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
  late final $DtcCacheTable dtcCache = $DtcCacheTable(this);
  late final $MaintenanceTasksTable maintenanceTasks = $MaintenanceTasksTable(
    this,
  );
  late final CarsDao carsDao = CarsDao(this as AppDatabase);
  late final TripsDao tripsDao = TripsDao(this as AppDatabase);
  late final DtcDao dtcDao = DtcDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cars,
    trips,
    tripPoints,
    dtcCache,
    maintenanceTasks,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'cars',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('trips', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'trips',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('trip_points', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'cars',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('maintenance_tasks', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$CarsTableCreateCompanionBuilder =
    CarsCompanion Function({
      Value<int> id,
      required String vin,
      Value<String?> name,
      Value<int> savedTotalDistance,
      Value<int> lastObdReading,
      Value<bool> isAccuracyWarning,
    });
typedef $$CarsTableUpdateCompanionBuilder =
    CarsCompanion Function({
      Value<int> id,
      Value<String> vin,
      Value<String?> name,
      Value<int> savedTotalDistance,
      Value<int> lastObdReading,
      Value<bool> isAccuracyWarning,
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

  static MultiTypedResultKey<$MaintenanceTasksTable, List<MaintenanceTask>>
  _maintenanceTasksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.maintenanceTasks,
    aliasName: 'cars__id__maintenance_tasks__car_id',
  );

  $$MaintenanceTasksTableProcessedTableManager get maintenanceTasksRefs {
    final manager = $$MaintenanceTasksTableTableManager(
      $_db,
      $_db.maintenanceTasks,
    ).filter((f) => f.carId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _maintenanceTasksRefsTable($_db),
    );
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

  Expression<bool> maintenanceTasksRefs(
    Expression<bool> Function($$MaintenanceTasksTableFilterComposer f) f,
  ) {
    final $$MaintenanceTasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.maintenanceTasks,
      getReferencedColumn: (t) => t.carId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceTasksTableFilterComposer(
            $db: $db,
            $table: $db.maintenanceTasks,
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

  Expression<T> maintenanceTasksRefs<T extends Object>(
    Expression<T> Function($$MaintenanceTasksTableAnnotationComposer a) f,
  ) {
    final $$MaintenanceTasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.maintenanceTasks,
      getReferencedColumn: (t) => t.carId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceTasksTableAnnotationComposer(
            $db: $db,
            $table: $db.maintenanceTasks,
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
          PrefetchHooks Function({bool tripsRefs, bool maintenanceTasksRefs})
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
              }) => CarsCompanion(
                id: id,
                vin: vin,
                name: name,
                savedTotalDistance: savedTotalDistance,
                lastObdReading: lastObdReading,
                isAccuracyWarning: isAccuracyWarning,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String vin,
                Value<String?> name = const Value.absent(),
                Value<int> savedTotalDistance = const Value.absent(),
                Value<int> lastObdReading = const Value.absent(),
                Value<bool> isAccuracyWarning = const Value.absent(),
              }) => CarsCompanion.insert(
                id: id,
                vin: vin,
                name: name,
                savedTotalDistance: savedTotalDistance,
                lastObdReading: lastObdReading,
                isAccuracyWarning: isAccuracyWarning,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$CarsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({tripsRefs = false, maintenanceTasksRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (tripsRefs) db.trips,
                    if (maintenanceTasksRefs) db.maintenanceTasks,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (tripsRefs)
                        await $_getPrefetchedData<Car, $CarsTable, Trip>(
                          currentTable: table,
                          referencedTable: $$CarsTableReferences
                              ._tripsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CarsTableReferences(db, table, p0).tripsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.carId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (maintenanceTasksRefs)
                        await $_getPrefetchedData<
                          Car,
                          $CarsTable,
                          MaintenanceTask
                        >(
                          currentTable: table,
                          referencedTable: $$CarsTableReferences
                              ._maintenanceTasksRefsTable(db),
                          managerFromTypedResult: (p0) => $$CarsTableReferences(
                            db,
                            table,
                            p0,
                          ).maintenanceTasksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.carId == item.id,
                              ),
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
      PrefetchHooks Function({bool tripsRefs, bool maintenanceTasksRefs})
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
      required int coolantTemp,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<int?> engineOilTemp,
      Value<int?> intakeAirTemp,
      Value<int?> fuelLevel,
      Value<double?> maf,
    });
typedef $$TripPointsTableUpdateCompanionBuilder =
    TripPointsCompanion Function({
      Value<int> id,
      Value<int> tripId,
      Value<int> timestamp,
      Value<int> speed,
      Value<int> rpm,
      Value<int> throttlePosition,
      Value<int> coolantTemp,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<int?> engineOilTemp,
      Value<int?> intakeAirTemp,
      Value<int?> fuelLevel,
      Value<double?> maf,
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

  ColumnFilters<int> get coolantTemp => $composableBuilder(
    column: $table.coolantTemp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get engineOilTemp => $composableBuilder(
    column: $table.engineOilTemp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intakeAirTemp => $composableBuilder(
    column: $table.intakeAirTemp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fuelLevel => $composableBuilder(
    column: $table.fuelLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maf => $composableBuilder(
    column: $table.maf,
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

  ColumnOrderings<int> get coolantTemp => $composableBuilder(
    column: $table.coolantTemp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get engineOilTemp => $composableBuilder(
    column: $table.engineOilTemp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intakeAirTemp => $composableBuilder(
    column: $table.intakeAirTemp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fuelLevel => $composableBuilder(
    column: $table.fuelLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maf => $composableBuilder(
    column: $table.maf,
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

  GeneratedColumn<int> get coolantTemp => $composableBuilder(
    column: $table.coolantTemp,
    builder: (column) => column,
  );

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<int> get engineOilTemp => $composableBuilder(
    column: $table.engineOilTemp,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intakeAirTemp => $composableBuilder(
    column: $table.intakeAirTemp,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fuelLevel =>
      $composableBuilder(column: $table.fuelLevel, builder: (column) => column);

  GeneratedColumn<double> get maf =>
      $composableBuilder(column: $table.maf, builder: (column) => column);

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
                Value<int> coolantTemp = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<int?> engineOilTemp = const Value.absent(),
                Value<int?> intakeAirTemp = const Value.absent(),
                Value<int?> fuelLevel = const Value.absent(),
                Value<double?> maf = const Value.absent(),
              }) => TripPointsCompanion(
                id: id,
                tripId: tripId,
                timestamp: timestamp,
                speed: speed,
                rpm: rpm,
                throttlePosition: throttlePosition,
                coolantTemp: coolantTemp,
                latitude: latitude,
                longitude: longitude,
                engineOilTemp: engineOilTemp,
                intakeAirTemp: intakeAirTemp,
                fuelLevel: fuelLevel,
                maf: maf,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int tripId,
                required int timestamp,
                required int speed,
                required int rpm,
                required int throttlePosition,
                required int coolantTemp,
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<int?> engineOilTemp = const Value.absent(),
                Value<int?> intakeAirTemp = const Value.absent(),
                Value<int?> fuelLevel = const Value.absent(),
                Value<double?> maf = const Value.absent(),
              }) => TripPointsCompanion.insert(
                id: id,
                tripId: tripId,
                timestamp: timestamp,
                speed: speed,
                rpm: rpm,
                throttlePosition: throttlePosition,
                coolantTemp: coolantTemp,
                latitude: latitude,
                longitude: longitude,
                engineOilTemp: engineOilTemp,
                intakeAirTemp: intakeAirTemp,
                fuelLevel: fuelLevel,
                maf: maf,
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
typedef $$DtcCacheTableCreateCompanionBuilder =
    DtcCacheCompanion Function({
      required String code,
      required String description,
      Value<int> rowid,
    });
typedef $$DtcCacheTableUpdateCompanionBuilder =
    DtcCacheCompanion Function({
      Value<String> code,
      Value<String> description,
      Value<int> rowid,
    });

class $$DtcCacheTableFilterComposer
    extends Composer<_$AppDatabase, $DtcCacheTable> {
  $$DtcCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DtcCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $DtcCacheTable> {
  $$DtcCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DtcCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $DtcCacheTable> {
  $$DtcCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );
}

class $$DtcCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DtcCacheTable,
          DtcCacheData,
          $$DtcCacheTableFilterComposer,
          $$DtcCacheTableOrderingComposer,
          $$DtcCacheTableAnnotationComposer,
          $$DtcCacheTableCreateCompanionBuilder,
          $$DtcCacheTableUpdateCompanionBuilder,
          (
            DtcCacheData,
            BaseReferences<_$AppDatabase, $DtcCacheTable, DtcCacheData>,
          ),
          DtcCacheData,
          PrefetchHooks Function()
        > {
  $$DtcCacheTableTableManager(_$AppDatabase db, $DtcCacheTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DtcCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DtcCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DtcCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> code = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DtcCacheCompanion(
                code: code,
                description: description,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String code,
                required String description,
                Value<int> rowid = const Value.absent(),
              }) => DtcCacheCompanion.insert(
                code: code,
                description: description,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DtcCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DtcCacheTable,
      DtcCacheData,
      $$DtcCacheTableFilterComposer,
      $$DtcCacheTableOrderingComposer,
      $$DtcCacheTableAnnotationComposer,
      $$DtcCacheTableCreateCompanionBuilder,
      $$DtcCacheTableUpdateCompanionBuilder,
      (
        DtcCacheData,
        BaseReferences<_$AppDatabase, $DtcCacheTable, DtcCacheData>,
      ),
      DtcCacheData,
      PrefetchHooks Function()
    >;
typedef $$MaintenanceTasksTableCreateCompanionBuilder =
    MaintenanceTasksCompanion Function({
      Value<int> id,
      required int carId,
      required String title,
      Value<String?> description,
      required int intervalKm,
      required int lastChangeKm,
    });
typedef $$MaintenanceTasksTableUpdateCompanionBuilder =
    MaintenanceTasksCompanion Function({
      Value<int> id,
      Value<int> carId,
      Value<String> title,
      Value<String?> description,
      Value<int> intervalKm,
      Value<int> lastChangeKm,
    });

final class $$MaintenanceTasksTableReferences
    extends
        BaseReferences<_$AppDatabase, $MaintenanceTasksTable, MaintenanceTask> {
  $$MaintenanceTasksTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CarsTable _carIdTable(_$AppDatabase db) =>
      db.cars.createAlias('maintenance_tasks__car_id__cars__id');

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
}

class $$MaintenanceTasksTableFilterComposer
    extends Composer<_$AppDatabase, $MaintenanceTasksTable> {
  $$MaintenanceTasksTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalKm => $composableBuilder(
    column: $table.intervalKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastChangeKm => $composableBuilder(
    column: $table.lastChangeKm,
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
}

class $$MaintenanceTasksTableOrderingComposer
    extends Composer<_$AppDatabase, $MaintenanceTasksTable> {
  $$MaintenanceTasksTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalKm => $composableBuilder(
    column: $table.intervalKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastChangeKm => $composableBuilder(
    column: $table.lastChangeKm,
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

class $$MaintenanceTasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $MaintenanceTasksTable> {
  $$MaintenanceTasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intervalKm => $composableBuilder(
    column: $table.intervalKm,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastChangeKm => $composableBuilder(
    column: $table.lastChangeKm,
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
}

class $$MaintenanceTasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MaintenanceTasksTable,
          MaintenanceTask,
          $$MaintenanceTasksTableFilterComposer,
          $$MaintenanceTasksTableOrderingComposer,
          $$MaintenanceTasksTableAnnotationComposer,
          $$MaintenanceTasksTableCreateCompanionBuilder,
          $$MaintenanceTasksTableUpdateCompanionBuilder,
          (MaintenanceTask, $$MaintenanceTasksTableReferences),
          MaintenanceTask,
          PrefetchHooks Function({bool carId})
        > {
  $$MaintenanceTasksTableTableManager(
    _$AppDatabase db,
    $MaintenanceTasksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MaintenanceTasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MaintenanceTasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MaintenanceTasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> carId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> intervalKm = const Value.absent(),
                Value<int> lastChangeKm = const Value.absent(),
              }) => MaintenanceTasksCompanion(
                id: id,
                carId: carId,
                title: title,
                description: description,
                intervalKm: intervalKm,
                lastChangeKm: lastChangeKm,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int carId,
                required String title,
                Value<String?> description = const Value.absent(),
                required int intervalKm,
                required int lastChangeKm,
              }) => MaintenanceTasksCompanion.insert(
                id: id,
                carId: carId,
                title: title,
                description: description,
                intervalKm: intervalKm,
                lastChangeKm: lastChangeKm,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MaintenanceTasksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({carId = false}) {
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
                    if (carId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.carId,
                                referencedTable:
                                    $$MaintenanceTasksTableReferences
                                        ._carIdTable(db),
                                referencedColumn:
                                    $$MaintenanceTasksTableReferences
                                        ._carIdTable(db)
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

typedef $$MaintenanceTasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MaintenanceTasksTable,
      MaintenanceTask,
      $$MaintenanceTasksTableFilterComposer,
      $$MaintenanceTasksTableOrderingComposer,
      $$MaintenanceTasksTableAnnotationComposer,
      $$MaintenanceTasksTableCreateCompanionBuilder,
      $$MaintenanceTasksTableUpdateCompanionBuilder,
      (MaintenanceTask, $$MaintenanceTasksTableReferences),
      MaintenanceTask,
      PrefetchHooks Function({bool carId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CarsTableTableManager get cars => $$CarsTableTableManager(_db, _db.cars);
  $$TripsTableTableManager get trips =>
      $$TripsTableTableManager(_db, _db.trips);
  $$TripPointsTableTableManager get tripPoints =>
      $$TripPointsTableTableManager(_db, _db.tripPoints);
  $$DtcCacheTableTableManager get dtcCache =>
      $$DtcCacheTableTableManager(_db, _db.dtcCache);
  $$MaintenanceTasksTableTableManager get maintenanceTasks =>
      $$MaintenanceTasksTableTableManager(_db, _db.maintenanceTasks);
}
