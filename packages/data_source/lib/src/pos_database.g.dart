// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pos_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Category extends DataClass implements Insertable<Category> {
  final int createdAt;
  final int modifiedAt;
  final int id;
  final String name;
  final int color;
  Category(
      {@required this.createdAt,
      @required this.modifiedAt,
      @required this.id,
      @required this.name,
      @required this.color});
  factory Category.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Category(
      createdAt:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      modifiedAt: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}modified_at']),
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      color: intType.mapFromDatabaseResponse(data['${effectivePrefix}color']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<int>(createdAt);
    }
    if (!nullToAbsent || modifiedAt != null) {
      map['modified_at'] = Variable<int>(modifiedAt);
    }
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<int>(color);
    }
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      modifiedAt: modifiedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(modifiedAt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
    );
  }

  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Category(
      createdAt: serializer.fromJson<int>(json['createdAt']),
      modifiedAt: serializer.fromJson<int>(json['modifiedAt']),
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<int>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<int>(createdAt),
      'modifiedAt': serializer.toJson<int>(modifiedAt),
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<int>(color),
    };
  }

  Category copyWith(
          {int createdAt, int modifiedAt, int id, String name, int color}) =>
      Category(
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        id: id ?? this.id,
        name: name ?? this.name,
        color: color ?? this.color,
      );
  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      createdAt.hashCode,
      $mrjc(modifiedAt.hashCode,
          $mrjc(id.hashCode, $mrjc(name.hashCode, color.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Category &&
          other.createdAt == this.createdAt &&
          other.modifiedAt == this.modifiedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.color == this.color);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> createdAt;
  final Value<int> modifiedAt;
  final Value<int> id;
  final Value<String> name;
  final Value<int> color;
  const CategoriesCompanion({
    this.createdAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
  });
  CategoriesCompanion.insert({
    @required int createdAt,
    @required int modifiedAt,
    this.id = const Value.absent(),
    @required String name,
    @required int color,
  })  : createdAt = Value(createdAt),
        modifiedAt = Value(modifiedAt),
        name = Value(name),
        color = Value(color);
  static Insertable<Category> custom({
    Expression<int> createdAt,
    Expression<int> modifiedAt,
    Expression<int> id,
    Expression<String> name,
    Expression<int> color,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
    });
  }

  CategoriesCompanion copyWith(
      {Value<int> createdAt,
      Value<int> modifiedAt,
      Value<int> id,
      Value<String> name,
      Value<int> color}) {
    return CategoriesCompanion(
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<int>(modifiedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  final GeneratedDatabase _db;
  final String _alias;
  $CategoriesTable(this._db, [this._alias]);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedIntColumn _createdAt;
  @override
  GeneratedIntColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedIntColumn _constructCreatedAt() {
    return GeneratedIntColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _modifiedAtMeta = const VerificationMeta('modifiedAt');
  GeneratedIntColumn _modifiedAt;
  @override
  GeneratedIntColumn get modifiedAt => _modifiedAt ??= _constructModifiedAt();
  GeneratedIntColumn _constructModifiedAt() {
    return GeneratedIntColumn(
      'modified_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  GeneratedIntColumn _color;
  @override
  GeneratedIntColumn get color => _color ??= _constructColor();
  GeneratedIntColumn _constructColor() {
    return GeneratedIntColumn(
      'color',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [createdAt, modifiedAt, id, name, color];
  @override
  $CategoriesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'categories';
  @override
  final String actualTableName = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<Category> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('modified_at')) {
      context.handle(
          _modifiedAtMeta,
          modifiedAt.isAcceptableOrUnknown(
              data['modified_at'], _modifiedAtMeta));
    } else if (isInserting) {
      context.missing(_modifiedAtMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color'], _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Category.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(_db, alias);
  }
}

class Discount extends DataClass implements Insertable<Discount> {
  final int createdAt;
  final int modifiedAt;
  final int id;
  final String name;
  final double value;
  final DiscountType type;
  Discount(
      {@required this.createdAt,
      @required this.modifiedAt,
      @required this.id,
      @required this.name,
      @required this.value,
      @required this.type});
  factory Discount.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    return Discount(
      createdAt:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      modifiedAt: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}modified_at']),
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      value:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}value']),
      type: $DiscountsTable.$converter0.mapToDart(
          intType.mapFromDatabaseResponse(data['${effectivePrefix}type'])),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<int>(createdAt);
    }
    if (!nullToAbsent || modifiedAt != null) {
      map['modified_at'] = Variable<int>(modifiedAt);
    }
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<double>(value);
    }
    if (!nullToAbsent || type != null) {
      final converter = $DiscountsTable.$converter0;
      map['type'] = Variable<int>(converter.mapToSql(type));
    }
    return map;
  }

  DiscountsCompanion toCompanion(bool nullToAbsent) {
    return DiscountsCompanion(
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      modifiedAt: modifiedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(modifiedAt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
    );
  }

  factory Discount.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Discount(
      createdAt: serializer.fromJson<int>(json['createdAt']),
      modifiedAt: serializer.fromJson<int>(json['modifiedAt']),
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      value: serializer.fromJson<double>(json['value']),
      type: serializer.fromJson<DiscountType>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<int>(createdAt),
      'modifiedAt': serializer.toJson<int>(modifiedAt),
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'value': serializer.toJson<double>(value),
      'type': serializer.toJson<DiscountType>(type),
    };
  }

  Discount copyWith(
          {int createdAt,
          int modifiedAt,
          int id,
          String name,
          double value,
          DiscountType type}) =>
      Discount(
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        id: id ?? this.id,
        name: name ?? this.name,
        value: value ?? this.value,
        type: type ?? this.type,
      );
  @override
  String toString() {
    return (StringBuffer('Discount(')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('value: $value, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      createdAt.hashCode,
      $mrjc(
          modifiedAt.hashCode,
          $mrjc(id.hashCode,
              $mrjc(name.hashCode, $mrjc(value.hashCode, type.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Discount &&
          other.createdAt == this.createdAt &&
          other.modifiedAt == this.modifiedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.value == this.value &&
          other.type == this.type);
}

class DiscountsCompanion extends UpdateCompanion<Discount> {
  final Value<int> createdAt;
  final Value<int> modifiedAt;
  final Value<int> id;
  final Value<String> name;
  final Value<double> value;
  final Value<DiscountType> type;
  const DiscountsCompanion({
    this.createdAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.value = const Value.absent(),
    this.type = const Value.absent(),
  });
  DiscountsCompanion.insert({
    @required int createdAt,
    @required int modifiedAt,
    this.id = const Value.absent(),
    @required String name,
    @required double value,
    @required DiscountType type,
  })  : createdAt = Value(createdAt),
        modifiedAt = Value(modifiedAt),
        name = Value(name),
        value = Value(value),
        type = Value(type);
  static Insertable<Discount> custom({
    Expression<int> createdAt,
    Expression<int> modifiedAt,
    Expression<int> id,
    Expression<String> name,
    Expression<double> value,
    Expression<int> type,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (value != null) 'value': value,
      if (type != null) 'type': type,
    });
  }

  DiscountsCompanion copyWith(
      {Value<int> createdAt,
      Value<int> modifiedAt,
      Value<int> id,
      Value<String> name,
      Value<double> value,
      Value<DiscountType> type}) {
    return DiscountsCompanion(
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<int>(modifiedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (type.present) {
      final converter = $DiscountsTable.$converter0;
      map['type'] = Variable<int>(converter.mapToSql(type.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiscountsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('value: $value, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $DiscountsTable extends Discounts
    with TableInfo<$DiscountsTable, Discount> {
  final GeneratedDatabase _db;
  final String _alias;
  $DiscountsTable(this._db, [this._alias]);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedIntColumn _createdAt;
  @override
  GeneratedIntColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedIntColumn _constructCreatedAt() {
    return GeneratedIntColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _modifiedAtMeta = const VerificationMeta('modifiedAt');
  GeneratedIntColumn _modifiedAt;
  @override
  GeneratedIntColumn get modifiedAt => _modifiedAt ??= _constructModifiedAt();
  GeneratedIntColumn _constructModifiedAt() {
    return GeneratedIntColumn(
      'modified_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _valueMeta = const VerificationMeta('value');
  GeneratedRealColumn _value;
  @override
  GeneratedRealColumn get value => _value ??= _constructValue();
  GeneratedRealColumn _constructValue() {
    return GeneratedRealColumn(
      'value',
      $tableName,
      false,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedIntColumn _type;
  @override
  GeneratedIntColumn get type => _type ??= _constructType();
  GeneratedIntColumn _constructType() {
    return GeneratedIntColumn(
      'type',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [createdAt, modifiedAt, id, name, value, type];
  @override
  $DiscountsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'discounts';
  @override
  final String actualTableName = 'discounts';
  @override
  VerificationContext validateIntegrity(Insertable<Discount> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('modified_at')) {
      context.handle(
          _modifiedAtMeta,
          modifiedAt.isAcceptableOrUnknown(
              data['modified_at'], _modifiedAtMeta));
    } else if (isInserting) {
      context.missing(_modifiedAtMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value'], _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    context.handle(_typeMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Discount map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Discount.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $DiscountsTable createAlias(String alias) {
    return $DiscountsTable(_db, alias);
  }

  static TypeConverter<DiscountType, int> $converter0 =
      const EnumIndexConverter<DiscountType>(DiscountType.values);
}

class Tax extends DataClass implements Insertable<Tax> {
  final int createdAt;
  final int modifiedAt;
  final int id;
  final String name;
  final double value;
  Tax(
      {@required this.createdAt,
      @required this.modifiedAt,
      @required this.id,
      @required this.name,
      @required this.value});
  factory Tax.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    return Tax(
      createdAt:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      modifiedAt: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}modified_at']),
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      value:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}value']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<int>(createdAt);
    }
    if (!nullToAbsent || modifiedAt != null) {
      map['modified_at'] = Variable<int>(modifiedAt);
    }
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<double>(value);
    }
    return map;
  }

  TaxesCompanion toCompanion(bool nullToAbsent) {
    return TaxesCompanion(
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      modifiedAt: modifiedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(modifiedAt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
    );
  }

  factory Tax.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Tax(
      createdAt: serializer.fromJson<int>(json['createdAt']),
      modifiedAt: serializer.fromJson<int>(json['modifiedAt']),
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      value: serializer.fromJson<double>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<int>(createdAt),
      'modifiedAt': serializer.toJson<int>(modifiedAt),
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'value': serializer.toJson<double>(value),
    };
  }

  Tax copyWith(
          {int createdAt, int modifiedAt, int id, String name, double value}) =>
      Tax(
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        id: id ?? this.id,
        name: name ?? this.name,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('Tax(')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      createdAt.hashCode,
      $mrjc(modifiedAt.hashCode,
          $mrjc(id.hashCode, $mrjc(name.hashCode, value.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Tax &&
          other.createdAt == this.createdAt &&
          other.modifiedAt == this.modifiedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.value == this.value);
}

class TaxesCompanion extends UpdateCompanion<Tax> {
  final Value<int> createdAt;
  final Value<int> modifiedAt;
  final Value<int> id;
  final Value<String> name;
  final Value<double> value;
  const TaxesCompanion({
    this.createdAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.value = const Value.absent(),
  });
  TaxesCompanion.insert({
    @required int createdAt,
    @required int modifiedAt,
    this.id = const Value.absent(),
    @required String name,
    @required double value,
  })  : createdAt = Value(createdAt),
        modifiedAt = Value(modifiedAt),
        name = Value(name),
        value = Value(value);
  static Insertable<Tax> custom({
    Expression<int> createdAt,
    Expression<int> modifiedAt,
    Expression<int> id,
    Expression<String> name,
    Expression<double> value,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (value != null) 'value': value,
    });
  }

  TaxesCompanion copyWith(
      {Value<int> createdAt,
      Value<int> modifiedAt,
      Value<int> id,
      Value<String> name,
      Value<double> value}) {
    return TaxesCompanion(
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<int>(modifiedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaxesCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

class $TaxesTable extends Taxes with TableInfo<$TaxesTable, Tax> {
  final GeneratedDatabase _db;
  final String _alias;
  $TaxesTable(this._db, [this._alias]);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedIntColumn _createdAt;
  @override
  GeneratedIntColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedIntColumn _constructCreatedAt() {
    return GeneratedIntColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _modifiedAtMeta = const VerificationMeta('modifiedAt');
  GeneratedIntColumn _modifiedAt;
  @override
  GeneratedIntColumn get modifiedAt => _modifiedAt ??= _constructModifiedAt();
  GeneratedIntColumn _constructModifiedAt() {
    return GeneratedIntColumn(
      'modified_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _valueMeta = const VerificationMeta('value');
  GeneratedRealColumn _value;
  @override
  GeneratedRealColumn get value => _value ??= _constructValue();
  GeneratedRealColumn _constructValue() {
    return GeneratedRealColumn(
      'value',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [createdAt, modifiedAt, id, name, value];
  @override
  $TaxesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'taxes';
  @override
  final String actualTableName = 'taxes';
  @override
  VerificationContext validateIntegrity(Insertable<Tax> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('modified_at')) {
      context.handle(
          _modifiedAtMeta,
          modifiedAt.isAcceptableOrUnknown(
              data['modified_at'], _modifiedAtMeta));
    } else if (isInserting) {
      context.missing(_modifiedAtMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value'], _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tax map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Tax.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TaxesTable createAlias(String alias) {
    return $TaxesTable(_db, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final int createdAt;
  final int modifiedAt;
  final int id;
  final String name;
  final double price;
  final double cost;
  final String image;
  final bool available;
  final int categoryId;
  Product(
      {@required this.createdAt,
      @required this.modifiedAt,
      @required this.id,
      @required this.name,
      this.price,
      this.cost,
      this.image,
      @required this.available,
      @required this.categoryId});
  factory Product.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Product(
      createdAt:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      modifiedAt: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}modified_at']),
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      price:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}price']),
      cost: doubleType.mapFromDatabaseResponse(data['${effectivePrefix}cost']),
      image:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}image']),
      available:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}available']),
      categoryId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}category_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<int>(createdAt);
    }
    if (!nullToAbsent || modifiedAt != null) {
      map['modified_at'] = Variable<int>(modifiedAt);
    }
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<double>(price);
    }
    if (!nullToAbsent || cost != null) {
      map['cost'] = Variable<double>(cost);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    if (!nullToAbsent || available != null) {
      map['available'] = Variable<bool>(available);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      modifiedAt: modifiedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(modifiedAt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
      cost: cost == null && nullToAbsent ? const Value.absent() : Value(cost),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      available: available == null && nullToAbsent
          ? const Value.absent()
          : Value(available),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
    );
  }

  factory Product.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Product(
      createdAt: serializer.fromJson<int>(json['createdAt']),
      modifiedAt: serializer.fromJson<int>(json['modifiedAt']),
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      price: serializer.fromJson<double>(json['price']),
      cost: serializer.fromJson<double>(json['cost']),
      image: serializer.fromJson<String>(json['image']),
      available: serializer.fromJson<bool>(json['available']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<int>(createdAt),
      'modifiedAt': serializer.toJson<int>(modifiedAt),
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'price': serializer.toJson<double>(price),
      'cost': serializer.toJson<double>(cost),
      'image': serializer.toJson<String>(image),
      'available': serializer.toJson<bool>(available),
      'categoryId': serializer.toJson<int>(categoryId),
    };
  }

  Product copyWith(
          {int createdAt,
          int modifiedAt,
          int id,
          String name,
          double price,
          double cost,
          String image,
          bool available,
          int categoryId}) =>
      Product(
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        cost: cost ?? this.cost,
        image: image ?? this.image,
        available: available ?? this.available,
        categoryId: categoryId ?? this.categoryId,
      );
  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('cost: $cost, ')
          ..write('image: $image, ')
          ..write('available: $available, ')
          ..write('categoryId: $categoryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      createdAt.hashCode,
      $mrjc(
          modifiedAt.hashCode,
          $mrjc(
              id.hashCode,
              $mrjc(
                  name.hashCode,
                  $mrjc(
                      price.hashCode,
                      $mrjc(
                          cost.hashCode,
                          $mrjc(
                              image.hashCode,
                              $mrjc(available.hashCode,
                                  categoryId.hashCode)))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Product &&
          other.createdAt == this.createdAt &&
          other.modifiedAt == this.modifiedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.price == this.price &&
          other.cost == this.cost &&
          other.image == this.image &&
          other.available == this.available &&
          other.categoryId == this.categoryId);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> createdAt;
  final Value<int> modifiedAt;
  final Value<int> id;
  final Value<String> name;
  final Value<double> price;
  final Value<double> cost;
  final Value<String> image;
  final Value<bool> available;
  final Value<int> categoryId;
  const ProductsCompanion({
    this.createdAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.price = const Value.absent(),
    this.cost = const Value.absent(),
    this.image = const Value.absent(),
    this.available = const Value.absent(),
    this.categoryId = const Value.absent(),
  });
  ProductsCompanion.insert({
    @required int createdAt,
    @required int modifiedAt,
    this.id = const Value.absent(),
    @required String name,
    this.price = const Value.absent(),
    this.cost = const Value.absent(),
    this.image = const Value.absent(),
    @required bool available,
    @required int categoryId,
  })  : createdAt = Value(createdAt),
        modifiedAt = Value(modifiedAt),
        name = Value(name),
        available = Value(available),
        categoryId = Value(categoryId);
  static Insertable<Product> custom({
    Expression<int> createdAt,
    Expression<int> modifiedAt,
    Expression<int> id,
    Expression<String> name,
    Expression<double> price,
    Expression<double> cost,
    Expression<String> image,
    Expression<bool> available,
    Expression<int> categoryId,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (price != null) 'price': price,
      if (cost != null) 'cost': cost,
      if (image != null) 'image': image,
      if (available != null) 'available': available,
      if (categoryId != null) 'category_id': categoryId,
    });
  }

  ProductsCompanion copyWith(
      {Value<int> createdAt,
      Value<int> modifiedAt,
      Value<int> id,
      Value<String> name,
      Value<double> price,
      Value<double> cost,
      Value<String> image,
      Value<bool> available,
      Value<int> categoryId}) {
    return ProductsCompanion(
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      cost: cost ?? this.cost,
      image: image ?? this.image,
      available: available ?? this.available,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<int>(modifiedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (cost.present) {
      map['cost'] = Variable<double>(cost.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (available.present) {
      map['available'] = Variable<bool>(available.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('cost: $cost, ')
          ..write('image: $image, ')
          ..write('available: $available, ')
          ..write('categoryId: $categoryId')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProductsTable(this._db, [this._alias]);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedIntColumn _createdAt;
  @override
  GeneratedIntColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedIntColumn _constructCreatedAt() {
    return GeneratedIntColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _modifiedAtMeta = const VerificationMeta('modifiedAt');
  GeneratedIntColumn _modifiedAt;
  @override
  GeneratedIntColumn get modifiedAt => _modifiedAt ??= _constructModifiedAt();
  GeneratedIntColumn _constructModifiedAt() {
    return GeneratedIntColumn(
      'modified_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _priceMeta = const VerificationMeta('price');
  GeneratedRealColumn _price;
  @override
  GeneratedRealColumn get price => _price ??= _constructPrice();
  GeneratedRealColumn _constructPrice() {
    return GeneratedRealColumn(
      'price',
      $tableName,
      true,
    );
  }

  final VerificationMeta _costMeta = const VerificationMeta('cost');
  GeneratedRealColumn _cost;
  @override
  GeneratedRealColumn get cost => _cost ??= _constructCost();
  GeneratedRealColumn _constructCost() {
    return GeneratedRealColumn(
      'cost',
      $tableName,
      true,
    );
  }

  final VerificationMeta _imageMeta = const VerificationMeta('image');
  GeneratedTextColumn _image;
  @override
  GeneratedTextColumn get image => _image ??= _constructImage();
  GeneratedTextColumn _constructImage() {
    return GeneratedTextColumn(
      'image',
      $tableName,
      true,
    );
  }

  final VerificationMeta _availableMeta = const VerificationMeta('available');
  GeneratedBoolColumn _available;
  @override
  GeneratedBoolColumn get available => _available ??= _constructAvailable();
  GeneratedBoolColumn _constructAvailable() {
    return GeneratedBoolColumn(
      'available',
      $tableName,
      false,
    );
  }

  final VerificationMeta _categoryIdMeta = const VerificationMeta('categoryId');
  GeneratedIntColumn _categoryId;
  @override
  GeneratedIntColumn get categoryId => _categoryId ??= _constructCategoryId();
  GeneratedIntColumn _constructCategoryId() {
    return GeneratedIntColumn('category_id', $tableName, false,
        $customConstraints: 'REFERENCES categories(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [
        createdAt,
        modifiedAt,
        id,
        name,
        price,
        cost,
        image,
        available,
        categoryId
      ];
  @override
  $ProductsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'products';
  @override
  final String actualTableName = 'products';
  @override
  VerificationContext validateIntegrity(Insertable<Product> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('modified_at')) {
      context.handle(
          _modifiedAtMeta,
          modifiedAt.isAcceptableOrUnknown(
              data['modified_at'], _modifiedAtMeta));
    } else if (isInserting) {
      context.missing(_modifiedAtMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price'], _priceMeta));
    }
    if (data.containsKey('cost')) {
      context.handle(
          _costMeta, cost.isAcceptableOrUnknown(data['cost'], _costMeta));
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image'], _imageMeta));
    }
    if (data.containsKey('available')) {
      context.handle(_availableMeta,
          available.isAcceptableOrUnknown(data['available'], _availableMeta));
    } else if (isInserting) {
      context.missing(_availableMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id'], _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Product.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(_db, alias);
  }
}

class Variant extends DataClass implements Insertable<Variant> {
  final int createdAt;
  final int modifiedAt;
  final int id;
  final String name;
  final double price;
  final double cost;
  final bool available;
  final int productId;
  Variant(
      {@required this.createdAt,
      @required this.modifiedAt,
      @required this.id,
      @required this.name,
      @required this.price,
      this.cost,
      @required this.available,
      @required this.productId});
  factory Variant.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Variant(
      createdAt:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      modifiedAt: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}modified_at']),
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      price:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}price']),
      cost: doubleType.mapFromDatabaseResponse(data['${effectivePrefix}cost']),
      available:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}available']),
      productId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}product_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<int>(createdAt);
    }
    if (!nullToAbsent || modifiedAt != null) {
      map['modified_at'] = Variable<int>(modifiedAt);
    }
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<double>(price);
    }
    if (!nullToAbsent || cost != null) {
      map['cost'] = Variable<double>(cost);
    }
    if (!nullToAbsent || available != null) {
      map['available'] = Variable<bool>(available);
    }
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<int>(productId);
    }
    return map;
  }

  VariantsCompanion toCompanion(bool nullToAbsent) {
    return VariantsCompanion(
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      modifiedAt: modifiedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(modifiedAt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
      cost: cost == null && nullToAbsent ? const Value.absent() : Value(cost),
      available: available == null && nullToAbsent
          ? const Value.absent()
          : Value(available),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
    );
  }

  factory Variant.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Variant(
      createdAt: serializer.fromJson<int>(json['createdAt']),
      modifiedAt: serializer.fromJson<int>(json['modifiedAt']),
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      price: serializer.fromJson<double>(json['price']),
      cost: serializer.fromJson<double>(json['cost']),
      available: serializer.fromJson<bool>(json['available']),
      productId: serializer.fromJson<int>(json['productId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<int>(createdAt),
      'modifiedAt': serializer.toJson<int>(modifiedAt),
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'price': serializer.toJson<double>(price),
      'cost': serializer.toJson<double>(cost),
      'available': serializer.toJson<bool>(available),
      'productId': serializer.toJson<int>(productId),
    };
  }

  Variant copyWith(
          {int createdAt,
          int modifiedAt,
          int id,
          String name,
          double price,
          double cost,
          bool available,
          int productId}) =>
      Variant(
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        cost: cost ?? this.cost,
        available: available ?? this.available,
        productId: productId ?? this.productId,
      );
  @override
  String toString() {
    return (StringBuffer('Variant(')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('cost: $cost, ')
          ..write('available: $available, ')
          ..write('productId: $productId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      createdAt.hashCode,
      $mrjc(
          modifiedAt.hashCode,
          $mrjc(
              id.hashCode,
              $mrjc(
                  name.hashCode,
                  $mrjc(
                      price.hashCode,
                      $mrjc(cost.hashCode,
                          $mrjc(available.hashCode, productId.hashCode))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Variant &&
          other.createdAt == this.createdAt &&
          other.modifiedAt == this.modifiedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.price == this.price &&
          other.cost == this.cost &&
          other.available == this.available &&
          other.productId == this.productId);
}

class VariantsCompanion extends UpdateCompanion<Variant> {
  final Value<int> createdAt;
  final Value<int> modifiedAt;
  final Value<int> id;
  final Value<String> name;
  final Value<double> price;
  final Value<double> cost;
  final Value<bool> available;
  final Value<int> productId;
  const VariantsCompanion({
    this.createdAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.price = const Value.absent(),
    this.cost = const Value.absent(),
    this.available = const Value.absent(),
    this.productId = const Value.absent(),
  });
  VariantsCompanion.insert({
    @required int createdAt,
    @required int modifiedAt,
    this.id = const Value.absent(),
    @required String name,
    @required double price,
    this.cost = const Value.absent(),
    @required bool available,
    @required int productId,
  })  : createdAt = Value(createdAt),
        modifiedAt = Value(modifiedAt),
        name = Value(name),
        price = Value(price),
        available = Value(available),
        productId = Value(productId);
  static Insertable<Variant> custom({
    Expression<int> createdAt,
    Expression<int> modifiedAt,
    Expression<int> id,
    Expression<String> name,
    Expression<double> price,
    Expression<double> cost,
    Expression<bool> available,
    Expression<int> productId,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (price != null) 'price': price,
      if (cost != null) 'cost': cost,
      if (available != null) 'available': available,
      if (productId != null) 'product_id': productId,
    });
  }

  VariantsCompanion copyWith(
      {Value<int> createdAt,
      Value<int> modifiedAt,
      Value<int> id,
      Value<String> name,
      Value<double> price,
      Value<double> cost,
      Value<bool> available,
      Value<int> productId}) {
    return VariantsCompanion(
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      cost: cost ?? this.cost,
      available: available ?? this.available,
      productId: productId ?? this.productId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<int>(modifiedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (cost.present) {
      map['cost'] = Variable<double>(cost.value);
    }
    if (available.present) {
      map['available'] = Variable<bool>(available.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VariantsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('cost: $cost, ')
          ..write('available: $available, ')
          ..write('productId: $productId')
          ..write(')'))
        .toString();
  }
}

class $VariantsTable extends Variants with TableInfo<$VariantsTable, Variant> {
  final GeneratedDatabase _db;
  final String _alias;
  $VariantsTable(this._db, [this._alias]);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedIntColumn _createdAt;
  @override
  GeneratedIntColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedIntColumn _constructCreatedAt() {
    return GeneratedIntColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _modifiedAtMeta = const VerificationMeta('modifiedAt');
  GeneratedIntColumn _modifiedAt;
  @override
  GeneratedIntColumn get modifiedAt => _modifiedAt ??= _constructModifiedAt();
  GeneratedIntColumn _constructModifiedAt() {
    return GeneratedIntColumn(
      'modified_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _priceMeta = const VerificationMeta('price');
  GeneratedRealColumn _price;
  @override
  GeneratedRealColumn get price => _price ??= _constructPrice();
  GeneratedRealColumn _constructPrice() {
    return GeneratedRealColumn(
      'price',
      $tableName,
      false,
    );
  }

  final VerificationMeta _costMeta = const VerificationMeta('cost');
  GeneratedRealColumn _cost;
  @override
  GeneratedRealColumn get cost => _cost ??= _constructCost();
  GeneratedRealColumn _constructCost() {
    return GeneratedRealColumn(
      'cost',
      $tableName,
      true,
    );
  }

  final VerificationMeta _availableMeta = const VerificationMeta('available');
  GeneratedBoolColumn _available;
  @override
  GeneratedBoolColumn get available => _available ??= _constructAvailable();
  GeneratedBoolColumn _constructAvailable() {
    return GeneratedBoolColumn(
      'available',
      $tableName,
      false,
    );
  }

  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  GeneratedIntColumn _productId;
  @override
  GeneratedIntColumn get productId => _productId ??= _constructProductId();
  GeneratedIntColumn _constructProductId() {
    return GeneratedIntColumn('product_id', $tableName, false,
        $customConstraints: 'REFERENCES products(id)');
  }

  @override
  List<GeneratedColumn> get $columns =>
      [createdAt, modifiedAt, id, name, price, cost, available, productId];
  @override
  $VariantsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'variants';
  @override
  final String actualTableName = 'variants';
  @override
  VerificationContext validateIntegrity(Insertable<Variant> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('modified_at')) {
      context.handle(
          _modifiedAtMeta,
          modifiedAt.isAcceptableOrUnknown(
              data['modified_at'], _modifiedAtMeta));
    } else if (isInserting) {
      context.missing(_modifiedAtMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price'], _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('cost')) {
      context.handle(
          _costMeta, cost.isAcceptableOrUnknown(data['cost'], _costMeta));
    }
    if (data.containsKey('available')) {
      context.handle(_availableMeta,
          available.isAcceptableOrUnknown(data['available'], _availableMeta));
    } else if (isInserting) {
      context.missing(_availableMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id'], _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Variant map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Variant.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $VariantsTable createAlias(String alias) {
    return $VariantsTable(_db, alias);
  }
}

class ProductDiscount extends DataClass implements Insertable<ProductDiscount> {
  final int productId;
  final int discountId;
  ProductDiscount({@required this.productId, @required this.discountId});
  factory ProductDiscount.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return ProductDiscount(
      productId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}product_id']),
      discountId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}discount_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<int>(productId);
    }
    if (!nullToAbsent || discountId != null) {
      map['discount_id'] = Variable<int>(discountId);
    }
    return map;
  }

  ProductDiscountsCompanion toCompanion(bool nullToAbsent) {
    return ProductDiscountsCompanion(
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      discountId: discountId == null && nullToAbsent
          ? const Value.absent()
          : Value(discountId),
    );
  }

  factory ProductDiscount.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProductDiscount(
      productId: serializer.fromJson<int>(json['productId']),
      discountId: serializer.fromJson<int>(json['discountId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productId': serializer.toJson<int>(productId),
      'discountId': serializer.toJson<int>(discountId),
    };
  }

  ProductDiscount copyWith({int productId, int discountId}) => ProductDiscount(
        productId: productId ?? this.productId,
        discountId: discountId ?? this.discountId,
      );
  @override
  String toString() {
    return (StringBuffer('ProductDiscount(')
          ..write('productId: $productId, ')
          ..write('discountId: $discountId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(productId.hashCode, discountId.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ProductDiscount &&
          other.productId == this.productId &&
          other.discountId == this.discountId);
}

class ProductDiscountsCompanion extends UpdateCompanion<ProductDiscount> {
  final Value<int> productId;
  final Value<int> discountId;
  const ProductDiscountsCompanion({
    this.productId = const Value.absent(),
    this.discountId = const Value.absent(),
  });
  ProductDiscountsCompanion.insert({
    @required int productId,
    @required int discountId,
  })  : productId = Value(productId),
        discountId = Value(discountId);
  static Insertable<ProductDiscount> custom({
    Expression<int> productId,
    Expression<int> discountId,
  }) {
    return RawValuesInsertable({
      if (productId != null) 'product_id': productId,
      if (discountId != null) 'discount_id': discountId,
    });
  }

  ProductDiscountsCompanion copyWith(
      {Value<int> productId, Value<int> discountId}) {
    return ProductDiscountsCompanion(
      productId: productId ?? this.productId,
      discountId: discountId ?? this.discountId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (discountId.present) {
      map['discount_id'] = Variable<int>(discountId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductDiscountsCompanion(')
          ..write('productId: $productId, ')
          ..write('discountId: $discountId')
          ..write(')'))
        .toString();
  }
}

class $ProductDiscountsTable extends ProductDiscounts
    with TableInfo<$ProductDiscountsTable, ProductDiscount> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProductDiscountsTable(this._db, [this._alias]);
  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  GeneratedIntColumn _productId;
  @override
  GeneratedIntColumn get productId => _productId ??= _constructProductId();
  GeneratedIntColumn _constructProductId() {
    return GeneratedIntColumn('product_id', $tableName, false,
        $customConstraints: 'REFERENCES products(id)');
  }

  final VerificationMeta _discountIdMeta = const VerificationMeta('discountId');
  GeneratedIntColumn _discountId;
  @override
  GeneratedIntColumn get discountId => _discountId ??= _constructDiscountId();
  GeneratedIntColumn _constructDiscountId() {
    return GeneratedIntColumn('discount_id', $tableName, false,
        $customConstraints: 'REFERENCES discounts(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [productId, discountId];
  @override
  $ProductDiscountsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'product_discounts';
  @override
  final String actualTableName = 'product_discounts';
  @override
  VerificationContext validateIntegrity(Insertable<ProductDiscount> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id'], _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('discount_id')) {
      context.handle(
          _discountIdMeta,
          discountId.isAcceptableOrUnknown(
              data['discount_id'], _discountIdMeta));
    } else if (isInserting) {
      context.missing(_discountIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  ProductDiscount map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ProductDiscount.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ProductDiscountsTable createAlias(String alias) {
    return $ProductDiscountsTable(_db, alias);
  }
}

class ProductTax extends DataClass implements Insertable<ProductTax> {
  final int productId;
  final int taxId;
  ProductTax({@required this.productId, @required this.taxId});
  factory ProductTax.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return ProductTax(
      productId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}product_id']),
      taxId: intType.mapFromDatabaseResponse(data['${effectivePrefix}tax_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<int>(productId);
    }
    if (!nullToAbsent || taxId != null) {
      map['tax_id'] = Variable<int>(taxId);
    }
    return map;
  }

  ProductTaxesCompanion toCompanion(bool nullToAbsent) {
    return ProductTaxesCompanion(
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      taxId:
          taxId == null && nullToAbsent ? const Value.absent() : Value(taxId),
    );
  }

  factory ProductTax.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProductTax(
      productId: serializer.fromJson<int>(json['productId']),
      taxId: serializer.fromJson<int>(json['taxId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productId': serializer.toJson<int>(productId),
      'taxId': serializer.toJson<int>(taxId),
    };
  }

  ProductTax copyWith({int productId, int taxId}) => ProductTax(
        productId: productId ?? this.productId,
        taxId: taxId ?? this.taxId,
      );
  @override
  String toString() {
    return (StringBuffer('ProductTax(')
          ..write('productId: $productId, ')
          ..write('taxId: $taxId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(productId.hashCode, taxId.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ProductTax &&
          other.productId == this.productId &&
          other.taxId == this.taxId);
}

class ProductTaxesCompanion extends UpdateCompanion<ProductTax> {
  final Value<int> productId;
  final Value<int> taxId;
  const ProductTaxesCompanion({
    this.productId = const Value.absent(),
    this.taxId = const Value.absent(),
  });
  ProductTaxesCompanion.insert({
    @required int productId,
    @required int taxId,
  })  : productId = Value(productId),
        taxId = Value(taxId);
  static Insertable<ProductTax> custom({
    Expression<int> productId,
    Expression<int> taxId,
  }) {
    return RawValuesInsertable({
      if (productId != null) 'product_id': productId,
      if (taxId != null) 'tax_id': taxId,
    });
  }

  ProductTaxesCompanion copyWith({Value<int> productId, Value<int> taxId}) {
    return ProductTaxesCompanion(
      productId: productId ?? this.productId,
      taxId: taxId ?? this.taxId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (taxId.present) {
      map['tax_id'] = Variable<int>(taxId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductTaxesCompanion(')
          ..write('productId: $productId, ')
          ..write('taxId: $taxId')
          ..write(')'))
        .toString();
  }
}

class $ProductTaxesTable extends ProductTaxes
    with TableInfo<$ProductTaxesTable, ProductTax> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProductTaxesTable(this._db, [this._alias]);
  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  GeneratedIntColumn _productId;
  @override
  GeneratedIntColumn get productId => _productId ??= _constructProductId();
  GeneratedIntColumn _constructProductId() {
    return GeneratedIntColumn('product_id', $tableName, false,
        $customConstraints: 'REFERENCES products(id)');
  }

  final VerificationMeta _taxIdMeta = const VerificationMeta('taxId');
  GeneratedIntColumn _taxId;
  @override
  GeneratedIntColumn get taxId => _taxId ??= _constructTaxId();
  GeneratedIntColumn _constructTaxId() {
    return GeneratedIntColumn('tax_id', $tableName, false,
        $customConstraints: 'REFERENCES taxes(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [productId, taxId];
  @override
  $ProductTaxesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'product_taxes';
  @override
  final String actualTableName = 'product_taxes';
  @override
  VerificationContext validateIntegrity(Insertable<ProductTax> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id'], _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('tax_id')) {
      context.handle(
          _taxIdMeta, taxId.isAcceptableOrUnknown(data['tax_id'], _taxIdMeta));
    } else if (isInserting) {
      context.missing(_taxIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  ProductTax map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ProductTax.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ProductTaxesTable createAlias(String alias) {
    return $ProductTaxesTable(_db, alias);
  }
}

class ProductBarCode extends DataClass implements Insertable<ProductBarCode> {
  final String code;
  final int productId;
  final int variantId;
  ProductBarCode(
      {@required this.code, @required this.productId, this.variantId});
  factory ProductBarCode.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return ProductBarCode(
      code: stringType.mapFromDatabaseResponse(data['${effectivePrefix}code']),
      productId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}product_id']),
      variantId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}variant_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<int>(productId);
    }
    if (!nullToAbsent || variantId != null) {
      map['variant_id'] = Variable<int>(variantId);
    }
    return map;
  }

  ProductBarCodesCompanion toCompanion(bool nullToAbsent) {
    return ProductBarCodesCompanion(
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      variantId: variantId == null && nullToAbsent
          ? const Value.absent()
          : Value(variantId),
    );
  }

  factory ProductBarCode.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProductBarCode(
      code: serializer.fromJson<String>(json['code']),
      productId: serializer.fromJson<int>(json['productId']),
      variantId: serializer.fromJson<int>(json['variantId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'productId': serializer.toJson<int>(productId),
      'variantId': serializer.toJson<int>(variantId),
    };
  }

  ProductBarCode copyWith({String code, int productId, int variantId}) =>
      ProductBarCode(
        code: code ?? this.code,
        productId: productId ?? this.productId,
        variantId: variantId ?? this.variantId,
      );
  @override
  String toString() {
    return (StringBuffer('ProductBarCode(')
          ..write('code: $code, ')
          ..write('productId: $productId, ')
          ..write('variantId: $variantId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(
      $mrjc(code.hashCode, $mrjc(productId.hashCode, variantId.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ProductBarCode &&
          other.code == this.code &&
          other.productId == this.productId &&
          other.variantId == this.variantId);
}

class ProductBarCodesCompanion extends UpdateCompanion<ProductBarCode> {
  final Value<String> code;
  final Value<int> productId;
  final Value<int> variantId;
  const ProductBarCodesCompanion({
    this.code = const Value.absent(),
    this.productId = const Value.absent(),
    this.variantId = const Value.absent(),
  });
  ProductBarCodesCompanion.insert({
    @required String code,
    @required int productId,
    this.variantId = const Value.absent(),
  })  : code = Value(code),
        productId = Value(productId);
  static Insertable<ProductBarCode> custom({
    Expression<String> code,
    Expression<int> productId,
    Expression<int> variantId,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (productId != null) 'product_id': productId,
      if (variantId != null) 'variant_id': variantId,
    });
  }

  ProductBarCodesCompanion copyWith(
      {Value<String> code, Value<int> productId, Value<int> variantId}) {
    return ProductBarCodesCompanion(
      code: code ?? this.code,
      productId: productId ?? this.productId,
      variantId: variantId ?? this.variantId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (variantId.present) {
      map['variant_id'] = Variable<int>(variantId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductBarCodesCompanion(')
          ..write('code: $code, ')
          ..write('productId: $productId, ')
          ..write('variantId: $variantId')
          ..write(')'))
        .toString();
  }
}

class $ProductBarCodesTable extends ProductBarCodes
    with TableInfo<$ProductBarCodesTable, ProductBarCode> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProductBarCodesTable(this._db, [this._alias]);
  final VerificationMeta _codeMeta = const VerificationMeta('code');
  GeneratedTextColumn _code;
  @override
  GeneratedTextColumn get code => _code ??= _constructCode();
  GeneratedTextColumn _constructCode() {
    return GeneratedTextColumn(
      'code',
      $tableName,
      false,
    );
  }

  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  GeneratedIntColumn _productId;
  @override
  GeneratedIntColumn get productId => _productId ??= _constructProductId();
  GeneratedIntColumn _constructProductId() {
    return GeneratedIntColumn('product_id', $tableName, false,
        $customConstraints: 'REFERENCES products(id)');
  }

  final VerificationMeta _variantIdMeta = const VerificationMeta('variantId');
  GeneratedIntColumn _variantId;
  @override
  GeneratedIntColumn get variantId => _variantId ??= _constructVariantId();
  GeneratedIntColumn _constructVariantId() {
    return GeneratedIntColumn(
      'variant_id',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [code, productId, variantId];
  @override
  $ProductBarCodesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'product_bar_codes';
  @override
  final String actualTableName = 'product_bar_codes';
  @override
  VerificationContext validateIntegrity(Insertable<ProductBarCode> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code'], _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id'], _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('variant_id')) {
      context.handle(_variantIdMeta,
          variantId.isAcceptableOrUnknown(data['variant_id'], _variantIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {code};
  @override
  ProductBarCode map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ProductBarCode.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ProductBarCodesTable createAlias(String alias) {
    return $ProductBarCodesTable(_db, alias);
  }
}

class Sale extends DataClass implements Insertable<Sale> {
  final int createdAt;
  final int modifiedAt;
  final int id;
  final int customerId;
  final String code;
  final double subTotalPrice;
  final double totalPrice;
  final double totalCost;
  final double discount;
  final double tax;
  final double payPrice;
  final double change;
  final int year;
  final int month;
  Sale(
      {@required this.createdAt,
      @required this.modifiedAt,
      @required this.id,
      this.customerId,
      @required this.code,
      @required this.subTotalPrice,
      @required this.totalPrice,
      this.totalCost,
      this.discount,
      this.tax,
      this.payPrice,
      this.change,
      @required this.year,
      @required this.month});
  factory Sale.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    return Sale(
      createdAt:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      modifiedAt: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}modified_at']),
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      customerId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}customer_id']),
      code: stringType.mapFromDatabaseResponse(data['${effectivePrefix}code']),
      subTotalPrice: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}sub_total_price']),
      totalPrice: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}total_price']),
      totalCost: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}total_cost']),
      discount: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}discount']),
      tax: doubleType.mapFromDatabaseResponse(data['${effectivePrefix}tax']),
      payPrice: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}pay_price']),
      change:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}change']),
      year: intType.mapFromDatabaseResponse(data['${effectivePrefix}year']),
      month: intType.mapFromDatabaseResponse(data['${effectivePrefix}month']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<int>(createdAt);
    }
    if (!nullToAbsent || modifiedAt != null) {
      map['modified_at'] = Variable<int>(modifiedAt);
    }
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<int>(customerId);
    }
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    if (!nullToAbsent || subTotalPrice != null) {
      map['sub_total_price'] = Variable<double>(subTotalPrice);
    }
    if (!nullToAbsent || totalPrice != null) {
      map['total_price'] = Variable<double>(totalPrice);
    }
    if (!nullToAbsent || totalCost != null) {
      map['total_cost'] = Variable<double>(totalCost);
    }
    if (!nullToAbsent || discount != null) {
      map['discount'] = Variable<double>(discount);
    }
    if (!nullToAbsent || tax != null) {
      map['tax'] = Variable<double>(tax);
    }
    if (!nullToAbsent || payPrice != null) {
      map['pay_price'] = Variable<double>(payPrice);
    }
    if (!nullToAbsent || change != null) {
      map['change'] = Variable<double>(change);
    }
    if (!nullToAbsent || year != null) {
      map['year'] = Variable<int>(year);
    }
    if (!nullToAbsent || month != null) {
      map['month'] = Variable<int>(month);
    }
    return map;
  }

  SalesCompanion toCompanion(bool nullToAbsent) {
    return SalesCompanion(
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      modifiedAt: modifiedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(modifiedAt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      subTotalPrice: subTotalPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(subTotalPrice),
      totalPrice: totalPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(totalPrice),
      totalCost: totalCost == null && nullToAbsent
          ? const Value.absent()
          : Value(totalCost),
      discount: discount == null && nullToAbsent
          ? const Value.absent()
          : Value(discount),
      tax: tax == null && nullToAbsent ? const Value.absent() : Value(tax),
      payPrice: payPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(payPrice),
      change:
          change == null && nullToAbsent ? const Value.absent() : Value(change),
      year: year == null && nullToAbsent ? const Value.absent() : Value(year),
      month:
          month == null && nullToAbsent ? const Value.absent() : Value(month),
    );
  }

  factory Sale.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Sale(
      createdAt: serializer.fromJson<int>(json['createdAt']),
      modifiedAt: serializer.fromJson<int>(json['modifiedAt']),
      id: serializer.fromJson<int>(json['id']),
      customerId: serializer.fromJson<int>(json['customerId']),
      code: serializer.fromJson<String>(json['code']),
      subTotalPrice: serializer.fromJson<double>(json['subTotalPrice']),
      totalPrice: serializer.fromJson<double>(json['totalPrice']),
      totalCost: serializer.fromJson<double>(json['totalCost']),
      discount: serializer.fromJson<double>(json['discount']),
      tax: serializer.fromJson<double>(json['tax']),
      payPrice: serializer.fromJson<double>(json['payPrice']),
      change: serializer.fromJson<double>(json['change']),
      year: serializer.fromJson<int>(json['year']),
      month: serializer.fromJson<int>(json['month']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<int>(createdAt),
      'modifiedAt': serializer.toJson<int>(modifiedAt),
      'id': serializer.toJson<int>(id),
      'customerId': serializer.toJson<int>(customerId),
      'code': serializer.toJson<String>(code),
      'subTotalPrice': serializer.toJson<double>(subTotalPrice),
      'totalPrice': serializer.toJson<double>(totalPrice),
      'totalCost': serializer.toJson<double>(totalCost),
      'discount': serializer.toJson<double>(discount),
      'tax': serializer.toJson<double>(tax),
      'payPrice': serializer.toJson<double>(payPrice),
      'change': serializer.toJson<double>(change),
      'year': serializer.toJson<int>(year),
      'month': serializer.toJson<int>(month),
    };
  }

  Sale copyWith(
          {int createdAt,
          int modifiedAt,
          int id,
          int customerId,
          String code,
          double subTotalPrice,
          double totalPrice,
          double totalCost,
          double discount,
          double tax,
          double payPrice,
          double change,
          int year,
          int month}) =>
      Sale(
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        code: code ?? this.code,
        subTotalPrice: subTotalPrice ?? this.subTotalPrice,
        totalPrice: totalPrice ?? this.totalPrice,
        totalCost: totalCost ?? this.totalCost,
        discount: discount ?? this.discount,
        tax: tax ?? this.tax,
        payPrice: payPrice ?? this.payPrice,
        change: change ?? this.change,
        year: year ?? this.year,
        month: month ?? this.month,
      );
  @override
  String toString() {
    return (StringBuffer('Sale(')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('code: $code, ')
          ..write('subTotalPrice: $subTotalPrice, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('totalCost: $totalCost, ')
          ..write('discount: $discount, ')
          ..write('tax: $tax, ')
          ..write('payPrice: $payPrice, ')
          ..write('change: $change, ')
          ..write('year: $year, ')
          ..write('month: $month')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      createdAt.hashCode,
      $mrjc(
          modifiedAt.hashCode,
          $mrjc(
              id.hashCode,
              $mrjc(
                  customerId.hashCode,
                  $mrjc(
                      code.hashCode,
                      $mrjc(
                          subTotalPrice.hashCode,
                          $mrjc(
                              totalPrice.hashCode,
                              $mrjc(
                                  totalCost.hashCode,
                                  $mrjc(
                                      discount.hashCode,
                                      $mrjc(
                                          tax.hashCode,
                                          $mrjc(
                                              payPrice.hashCode,
                                              $mrjc(
                                                  change.hashCode,
                                                  $mrjc(
                                                      year.hashCode,
                                                      month
                                                          .hashCode))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Sale &&
          other.createdAt == this.createdAt &&
          other.modifiedAt == this.modifiedAt &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.code == this.code &&
          other.subTotalPrice == this.subTotalPrice &&
          other.totalPrice == this.totalPrice &&
          other.totalCost == this.totalCost &&
          other.discount == this.discount &&
          other.tax == this.tax &&
          other.payPrice == this.payPrice &&
          other.change == this.change &&
          other.year == this.year &&
          other.month == this.month);
}

class SalesCompanion extends UpdateCompanion<Sale> {
  final Value<int> createdAt;
  final Value<int> modifiedAt;
  final Value<int> id;
  final Value<int> customerId;
  final Value<String> code;
  final Value<double> subTotalPrice;
  final Value<double> totalPrice;
  final Value<double> totalCost;
  final Value<double> discount;
  final Value<double> tax;
  final Value<double> payPrice;
  final Value<double> change;
  final Value<int> year;
  final Value<int> month;
  const SalesCompanion({
    this.createdAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.code = const Value.absent(),
    this.subTotalPrice = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.totalCost = const Value.absent(),
    this.discount = const Value.absent(),
    this.tax = const Value.absent(),
    this.payPrice = const Value.absent(),
    this.change = const Value.absent(),
    this.year = const Value.absent(),
    this.month = const Value.absent(),
  });
  SalesCompanion.insert({
    @required int createdAt,
    @required int modifiedAt,
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    @required String code,
    @required double subTotalPrice,
    @required double totalPrice,
    this.totalCost = const Value.absent(),
    this.discount = const Value.absent(),
    this.tax = const Value.absent(),
    this.payPrice = const Value.absent(),
    this.change = const Value.absent(),
    @required int year,
    @required int month,
  })  : createdAt = Value(createdAt),
        modifiedAt = Value(modifiedAt),
        code = Value(code),
        subTotalPrice = Value(subTotalPrice),
        totalPrice = Value(totalPrice),
        year = Value(year),
        month = Value(month);
  static Insertable<Sale> custom({
    Expression<int> createdAt,
    Expression<int> modifiedAt,
    Expression<int> id,
    Expression<int> customerId,
    Expression<String> code,
    Expression<double> subTotalPrice,
    Expression<double> totalPrice,
    Expression<double> totalCost,
    Expression<double> discount,
    Expression<double> tax,
    Expression<double> payPrice,
    Expression<double> change,
    Expression<int> year,
    Expression<int> month,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (code != null) 'code': code,
      if (subTotalPrice != null) 'sub_total_price': subTotalPrice,
      if (totalPrice != null) 'total_price': totalPrice,
      if (totalCost != null) 'total_cost': totalCost,
      if (discount != null) 'discount': discount,
      if (tax != null) 'tax': tax,
      if (payPrice != null) 'pay_price': payPrice,
      if (change != null) 'change': change,
      if (year != null) 'year': year,
      if (month != null) 'month': month,
    });
  }

  SalesCompanion copyWith(
      {Value<int> createdAt,
      Value<int> modifiedAt,
      Value<int> id,
      Value<int> customerId,
      Value<String> code,
      Value<double> subTotalPrice,
      Value<double> totalPrice,
      Value<double> totalCost,
      Value<double> discount,
      Value<double> tax,
      Value<double> payPrice,
      Value<double> change,
      Value<int> year,
      Value<int> month}) {
    return SalesCompanion(
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      code: code ?? this.code,
      subTotalPrice: subTotalPrice ?? this.subTotalPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      totalCost: totalCost ?? this.totalCost,
      discount: discount ?? this.discount,
      tax: tax ?? this.tax,
      payPrice: payPrice ?? this.payPrice,
      change: change ?? this.change,
      year: year ?? this.year,
      month: month ?? this.month,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<int>(modifiedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (subTotalPrice.present) {
      map['sub_total_price'] = Variable<double>(subTotalPrice.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<double>(totalPrice.value);
    }
    if (totalCost.present) {
      map['total_cost'] = Variable<double>(totalCost.value);
    }
    if (discount.present) {
      map['discount'] = Variable<double>(discount.value);
    }
    if (tax.present) {
      map['tax'] = Variable<double>(tax.value);
    }
    if (payPrice.present) {
      map['pay_price'] = Variable<double>(payPrice.value);
    }
    if (change.present) {
      map['change'] = Variable<double>(change.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('code: $code, ')
          ..write('subTotalPrice: $subTotalPrice, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('totalCost: $totalCost, ')
          ..write('discount: $discount, ')
          ..write('tax: $tax, ')
          ..write('payPrice: $payPrice, ')
          ..write('change: $change, ')
          ..write('year: $year, ')
          ..write('month: $month')
          ..write(')'))
        .toString();
  }
}

class $SalesTable extends Sales with TableInfo<$SalesTable, Sale> {
  final GeneratedDatabase _db;
  final String _alias;
  $SalesTable(this._db, [this._alias]);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedIntColumn _createdAt;
  @override
  GeneratedIntColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedIntColumn _constructCreatedAt() {
    return GeneratedIntColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _modifiedAtMeta = const VerificationMeta('modifiedAt');
  GeneratedIntColumn _modifiedAt;
  @override
  GeneratedIntColumn get modifiedAt => _modifiedAt ??= _constructModifiedAt();
  GeneratedIntColumn _constructModifiedAt() {
    return GeneratedIntColumn(
      'modified_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _customerIdMeta = const VerificationMeta('customerId');
  GeneratedIntColumn _customerId;
  @override
  GeneratedIntColumn get customerId => _customerId ??= _constructCustomerId();
  GeneratedIntColumn _constructCustomerId() {
    return GeneratedIntColumn(
      'customer_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _codeMeta = const VerificationMeta('code');
  GeneratedTextColumn _code;
  @override
  GeneratedTextColumn get code => _code ??= _constructCode();
  GeneratedTextColumn _constructCode() {
    return GeneratedTextColumn(
      'code',
      $tableName,
      false,
    );
  }

  final VerificationMeta _subTotalPriceMeta =
      const VerificationMeta('subTotalPrice');
  GeneratedRealColumn _subTotalPrice;
  @override
  GeneratedRealColumn get subTotalPrice =>
      _subTotalPrice ??= _constructSubTotalPrice();
  GeneratedRealColumn _constructSubTotalPrice() {
    return GeneratedRealColumn(
      'sub_total_price',
      $tableName,
      false,
    );
  }

  final VerificationMeta _totalPriceMeta = const VerificationMeta('totalPrice');
  GeneratedRealColumn _totalPrice;
  @override
  GeneratedRealColumn get totalPrice => _totalPrice ??= _constructTotalPrice();
  GeneratedRealColumn _constructTotalPrice() {
    return GeneratedRealColumn(
      'total_price',
      $tableName,
      false,
    );
  }

  final VerificationMeta _totalCostMeta = const VerificationMeta('totalCost');
  GeneratedRealColumn _totalCost;
  @override
  GeneratedRealColumn get totalCost => _totalCost ??= _constructTotalCost();
  GeneratedRealColumn _constructTotalCost() {
    return GeneratedRealColumn(
      'total_cost',
      $tableName,
      true,
    );
  }

  final VerificationMeta _discountMeta = const VerificationMeta('discount');
  GeneratedRealColumn _discount;
  @override
  GeneratedRealColumn get discount => _discount ??= _constructDiscount();
  GeneratedRealColumn _constructDiscount() {
    return GeneratedRealColumn(
      'discount',
      $tableName,
      true,
    );
  }

  final VerificationMeta _taxMeta = const VerificationMeta('tax');
  GeneratedRealColumn _tax;
  @override
  GeneratedRealColumn get tax => _tax ??= _constructTax();
  GeneratedRealColumn _constructTax() {
    return GeneratedRealColumn(
      'tax',
      $tableName,
      true,
    );
  }

  final VerificationMeta _payPriceMeta = const VerificationMeta('payPrice');
  GeneratedRealColumn _payPrice;
  @override
  GeneratedRealColumn get payPrice => _payPrice ??= _constructPayPrice();
  GeneratedRealColumn _constructPayPrice() {
    return GeneratedRealColumn(
      'pay_price',
      $tableName,
      true,
    );
  }

  final VerificationMeta _changeMeta = const VerificationMeta('change');
  GeneratedRealColumn _change;
  @override
  GeneratedRealColumn get change => _change ??= _constructChange();
  GeneratedRealColumn _constructChange() {
    return GeneratedRealColumn(
      'change',
      $tableName,
      true,
    );
  }

  final VerificationMeta _yearMeta = const VerificationMeta('year');
  GeneratedIntColumn _year;
  @override
  GeneratedIntColumn get year => _year ??= _constructYear();
  GeneratedIntColumn _constructYear() {
    return GeneratedIntColumn(
      'year',
      $tableName,
      false,
    );
  }

  final VerificationMeta _monthMeta = const VerificationMeta('month');
  GeneratedIntColumn _month;
  @override
  GeneratedIntColumn get month => _month ??= _constructMonth();
  GeneratedIntColumn _constructMonth() {
    return GeneratedIntColumn(
      'month',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        createdAt,
        modifiedAt,
        id,
        customerId,
        code,
        subTotalPrice,
        totalPrice,
        totalCost,
        discount,
        tax,
        payPrice,
        change,
        year,
        month
      ];
  @override
  $SalesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'sales';
  @override
  final String actualTableName = 'sales';
  @override
  VerificationContext validateIntegrity(Insertable<Sale> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('modified_at')) {
      context.handle(
          _modifiedAtMeta,
          modifiedAt.isAcceptableOrUnknown(
              data['modified_at'], _modifiedAtMeta));
    } else if (isInserting) {
      context.missing(_modifiedAtMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id'], _customerIdMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code'], _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('sub_total_price')) {
      context.handle(
          _subTotalPriceMeta,
          subTotalPrice.isAcceptableOrUnknown(
              data['sub_total_price'], _subTotalPriceMeta));
    } else if (isInserting) {
      context.missing(_subTotalPriceMeta);
    }
    if (data.containsKey('total_price')) {
      context.handle(
          _totalPriceMeta,
          totalPrice.isAcceptableOrUnknown(
              data['total_price'], _totalPriceMeta));
    } else if (isInserting) {
      context.missing(_totalPriceMeta);
    }
    if (data.containsKey('total_cost')) {
      context.handle(_totalCostMeta,
          totalCost.isAcceptableOrUnknown(data['total_cost'], _totalCostMeta));
    }
    if (data.containsKey('discount')) {
      context.handle(_discountMeta,
          discount.isAcceptableOrUnknown(data['discount'], _discountMeta));
    }
    if (data.containsKey('tax')) {
      context.handle(
          _taxMeta, tax.isAcceptableOrUnknown(data['tax'], _taxMeta));
    }
    if (data.containsKey('pay_price')) {
      context.handle(_payPriceMeta,
          payPrice.isAcceptableOrUnknown(data['pay_price'], _payPriceMeta));
    }
    if (data.containsKey('change')) {
      context.handle(_changeMeta,
          change.isAcceptableOrUnknown(data['change'], _changeMeta));
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year'], _yearMeta));
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
          _monthMeta, month.isAcceptableOrUnknown(data['month'], _monthMeta));
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Sale map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Sale.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $SalesTable createAlias(String alias) {
    return $SalesTable(_db, alias);
  }
}

class SaleItem extends DataClass implements Insertable<SaleItem> {
  final int createdAt;
  final int modifiedAt;
  final int id;
  final int productId;
  final int variantId;
  final String productName;
  final String variantName;
  final double price;
  final double cost;
  final int quantity;
  final double totalPrice;
  final double discount;
  final double tax;
  final int saleId;
  SaleItem(
      {@required this.createdAt,
      @required this.modifiedAt,
      @required this.id,
      @required this.productId,
      this.variantId,
      @required this.productName,
      this.variantName,
      @required this.price,
      this.cost,
      @required this.quantity,
      @required this.totalPrice,
      this.discount,
      this.tax,
      @required this.saleId});
  factory SaleItem.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    return SaleItem(
      createdAt:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      modifiedAt: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}modified_at']),
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      productId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}product_id']),
      variantId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}variant_id']),
      productName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}product_name']),
      variantName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}variant_name']),
      price:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}price']),
      cost: doubleType.mapFromDatabaseResponse(data['${effectivePrefix}cost']),
      quantity:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}quantity']),
      totalPrice: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}total_price']),
      discount: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}discount']),
      tax: doubleType.mapFromDatabaseResponse(data['${effectivePrefix}tax']),
      saleId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}sale_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<int>(createdAt);
    }
    if (!nullToAbsent || modifiedAt != null) {
      map['modified_at'] = Variable<int>(modifiedAt);
    }
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<int>(productId);
    }
    if (!nullToAbsent || variantId != null) {
      map['variant_id'] = Variable<int>(variantId);
    }
    if (!nullToAbsent || productName != null) {
      map['product_name'] = Variable<String>(productName);
    }
    if (!nullToAbsent || variantName != null) {
      map['variant_name'] = Variable<String>(variantName);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<double>(price);
    }
    if (!nullToAbsent || cost != null) {
      map['cost'] = Variable<double>(cost);
    }
    if (!nullToAbsent || quantity != null) {
      map['quantity'] = Variable<int>(quantity);
    }
    if (!nullToAbsent || totalPrice != null) {
      map['total_price'] = Variable<double>(totalPrice);
    }
    if (!nullToAbsent || discount != null) {
      map['discount'] = Variable<double>(discount);
    }
    if (!nullToAbsent || tax != null) {
      map['tax'] = Variable<double>(tax);
    }
    if (!nullToAbsent || saleId != null) {
      map['sale_id'] = Variable<int>(saleId);
    }
    return map;
  }

  SaleItemsCompanion toCompanion(bool nullToAbsent) {
    return SaleItemsCompanion(
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      modifiedAt: modifiedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(modifiedAt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      variantId: variantId == null && nullToAbsent
          ? const Value.absent()
          : Value(variantId),
      productName: productName == null && nullToAbsent
          ? const Value.absent()
          : Value(productName),
      variantName: variantName == null && nullToAbsent
          ? const Value.absent()
          : Value(variantName),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
      cost: cost == null && nullToAbsent ? const Value.absent() : Value(cost),
      quantity: quantity == null && nullToAbsent
          ? const Value.absent()
          : Value(quantity),
      totalPrice: totalPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(totalPrice),
      discount: discount == null && nullToAbsent
          ? const Value.absent()
          : Value(discount),
      tax: tax == null && nullToAbsent ? const Value.absent() : Value(tax),
      saleId:
          saleId == null && nullToAbsent ? const Value.absent() : Value(saleId),
    );
  }

  factory SaleItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return SaleItem(
      createdAt: serializer.fromJson<int>(json['createdAt']),
      modifiedAt: serializer.fromJson<int>(json['modifiedAt']),
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      variantId: serializer.fromJson<int>(json['variantId']),
      productName: serializer.fromJson<String>(json['productName']),
      variantName: serializer.fromJson<String>(json['variantName']),
      price: serializer.fromJson<double>(json['price']),
      cost: serializer.fromJson<double>(json['cost']),
      quantity: serializer.fromJson<int>(json['quantity']),
      totalPrice: serializer.fromJson<double>(json['totalPrice']),
      discount: serializer.fromJson<double>(json['discount']),
      tax: serializer.fromJson<double>(json['tax']),
      saleId: serializer.fromJson<int>(json['saleId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<int>(createdAt),
      'modifiedAt': serializer.toJson<int>(modifiedAt),
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'variantId': serializer.toJson<int>(variantId),
      'productName': serializer.toJson<String>(productName),
      'variantName': serializer.toJson<String>(variantName),
      'price': serializer.toJson<double>(price),
      'cost': serializer.toJson<double>(cost),
      'quantity': serializer.toJson<int>(quantity),
      'totalPrice': serializer.toJson<double>(totalPrice),
      'discount': serializer.toJson<double>(discount),
      'tax': serializer.toJson<double>(tax),
      'saleId': serializer.toJson<int>(saleId),
    };
  }

  SaleItem copyWith(
          {int createdAt,
          int modifiedAt,
          int id,
          int productId,
          int variantId,
          String productName,
          String variantName,
          double price,
          double cost,
          int quantity,
          double totalPrice,
          double discount,
          double tax,
          int saleId}) =>
      SaleItem(
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        id: id ?? this.id,
        productId: productId ?? this.productId,
        variantId: variantId ?? this.variantId,
        productName: productName ?? this.productName,
        variantName: variantName ?? this.variantName,
        price: price ?? this.price,
        cost: cost ?? this.cost,
        quantity: quantity ?? this.quantity,
        totalPrice: totalPrice ?? this.totalPrice,
        discount: discount ?? this.discount,
        tax: tax ?? this.tax,
        saleId: saleId ?? this.saleId,
      );
  @override
  String toString() {
    return (StringBuffer('SaleItem(')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('variantId: $variantId, ')
          ..write('productName: $productName, ')
          ..write('variantName: $variantName, ')
          ..write('price: $price, ')
          ..write('cost: $cost, ')
          ..write('quantity: $quantity, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('discount: $discount, ')
          ..write('tax: $tax, ')
          ..write('saleId: $saleId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      createdAt.hashCode,
      $mrjc(
          modifiedAt.hashCode,
          $mrjc(
              id.hashCode,
              $mrjc(
                  productId.hashCode,
                  $mrjc(
                      variantId.hashCode,
                      $mrjc(
                          productName.hashCode,
                          $mrjc(
                              variantName.hashCode,
                              $mrjc(
                                  price.hashCode,
                                  $mrjc(
                                      cost.hashCode,
                                      $mrjc(
                                          quantity.hashCode,
                                          $mrjc(
                                              totalPrice.hashCode,
                                              $mrjc(
                                                  discount.hashCode,
                                                  $mrjc(
                                                      tax.hashCode,
                                                      saleId
                                                          .hashCode))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is SaleItem &&
          other.createdAt == this.createdAt &&
          other.modifiedAt == this.modifiedAt &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.variantId == this.variantId &&
          other.productName == this.productName &&
          other.variantName == this.variantName &&
          other.price == this.price &&
          other.cost == this.cost &&
          other.quantity == this.quantity &&
          other.totalPrice == this.totalPrice &&
          other.discount == this.discount &&
          other.tax == this.tax &&
          other.saleId == this.saleId);
}

class SaleItemsCompanion extends UpdateCompanion<SaleItem> {
  final Value<int> createdAt;
  final Value<int> modifiedAt;
  final Value<int> id;
  final Value<int> productId;
  final Value<int> variantId;
  final Value<String> productName;
  final Value<String> variantName;
  final Value<double> price;
  final Value<double> cost;
  final Value<int> quantity;
  final Value<double> totalPrice;
  final Value<double> discount;
  final Value<double> tax;
  final Value<int> saleId;
  const SaleItemsCompanion({
    this.createdAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.variantId = const Value.absent(),
    this.productName = const Value.absent(),
    this.variantName = const Value.absent(),
    this.price = const Value.absent(),
    this.cost = const Value.absent(),
    this.quantity = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.discount = const Value.absent(),
    this.tax = const Value.absent(),
    this.saleId = const Value.absent(),
  });
  SaleItemsCompanion.insert({
    @required int createdAt,
    @required int modifiedAt,
    this.id = const Value.absent(),
    @required int productId,
    this.variantId = const Value.absent(),
    @required String productName,
    this.variantName = const Value.absent(),
    @required double price,
    this.cost = const Value.absent(),
    @required int quantity,
    @required double totalPrice,
    this.discount = const Value.absent(),
    this.tax = const Value.absent(),
    @required int saleId,
  })  : createdAt = Value(createdAt),
        modifiedAt = Value(modifiedAt),
        productId = Value(productId),
        productName = Value(productName),
        price = Value(price),
        quantity = Value(quantity),
        totalPrice = Value(totalPrice),
        saleId = Value(saleId);
  static Insertable<SaleItem> custom({
    Expression<int> createdAt,
    Expression<int> modifiedAt,
    Expression<int> id,
    Expression<int> productId,
    Expression<int> variantId,
    Expression<String> productName,
    Expression<String> variantName,
    Expression<double> price,
    Expression<double> cost,
    Expression<int> quantity,
    Expression<double> totalPrice,
    Expression<double> discount,
    Expression<double> tax,
    Expression<int> saleId,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (variantId != null) 'variant_id': variantId,
      if (productName != null) 'product_name': productName,
      if (variantName != null) 'variant_name': variantName,
      if (price != null) 'price': price,
      if (cost != null) 'cost': cost,
      if (quantity != null) 'quantity': quantity,
      if (totalPrice != null) 'total_price': totalPrice,
      if (discount != null) 'discount': discount,
      if (tax != null) 'tax': tax,
      if (saleId != null) 'sale_id': saleId,
    });
  }

  SaleItemsCompanion copyWith(
      {Value<int> createdAt,
      Value<int> modifiedAt,
      Value<int> id,
      Value<int> productId,
      Value<int> variantId,
      Value<String> productName,
      Value<String> variantName,
      Value<double> price,
      Value<double> cost,
      Value<int> quantity,
      Value<double> totalPrice,
      Value<double> discount,
      Value<double> tax,
      Value<int> saleId}) {
    return SaleItemsCompanion(
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      id: id ?? this.id,
      productId: productId ?? this.productId,
      variantId: variantId ?? this.variantId,
      productName: productName ?? this.productName,
      variantName: variantName ?? this.variantName,
      price: price ?? this.price,
      cost: cost ?? this.cost,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      discount: discount ?? this.discount,
      tax: tax ?? this.tax,
      saleId: saleId ?? this.saleId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<int>(modifiedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (variantId.present) {
      map['variant_id'] = Variable<int>(variantId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (variantName.present) {
      map['variant_name'] = Variable<String>(variantName.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (cost.present) {
      map['cost'] = Variable<double>(cost.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<double>(totalPrice.value);
    }
    if (discount.present) {
      map['discount'] = Variable<double>(discount.value);
    }
    if (tax.present) {
      map['tax'] = Variable<double>(tax.value);
    }
    if (saleId.present) {
      map['sale_id'] = Variable<int>(saleId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SaleItemsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('variantId: $variantId, ')
          ..write('productName: $productName, ')
          ..write('variantName: $variantName, ')
          ..write('price: $price, ')
          ..write('cost: $cost, ')
          ..write('quantity: $quantity, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('discount: $discount, ')
          ..write('tax: $tax, ')
          ..write('saleId: $saleId')
          ..write(')'))
        .toString();
  }
}

class $SaleItemsTable extends SaleItems
    with TableInfo<$SaleItemsTable, SaleItem> {
  final GeneratedDatabase _db;
  final String _alias;
  $SaleItemsTable(this._db, [this._alias]);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedIntColumn _createdAt;
  @override
  GeneratedIntColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedIntColumn _constructCreatedAt() {
    return GeneratedIntColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _modifiedAtMeta = const VerificationMeta('modifiedAt');
  GeneratedIntColumn _modifiedAt;
  @override
  GeneratedIntColumn get modifiedAt => _modifiedAt ??= _constructModifiedAt();
  GeneratedIntColumn _constructModifiedAt() {
    return GeneratedIntColumn(
      'modified_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  GeneratedIntColumn _productId;
  @override
  GeneratedIntColumn get productId => _productId ??= _constructProductId();
  GeneratedIntColumn _constructProductId() {
    return GeneratedIntColumn(
      'product_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _variantIdMeta = const VerificationMeta('variantId');
  GeneratedIntColumn _variantId;
  @override
  GeneratedIntColumn get variantId => _variantId ??= _constructVariantId();
  GeneratedIntColumn _constructVariantId() {
    return GeneratedIntColumn(
      'variant_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _productNameMeta =
      const VerificationMeta('productName');
  GeneratedTextColumn _productName;
  @override
  GeneratedTextColumn get productName =>
      _productName ??= _constructProductName();
  GeneratedTextColumn _constructProductName() {
    return GeneratedTextColumn(
      'product_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _variantNameMeta =
      const VerificationMeta('variantName');
  GeneratedTextColumn _variantName;
  @override
  GeneratedTextColumn get variantName =>
      _variantName ??= _constructVariantName();
  GeneratedTextColumn _constructVariantName() {
    return GeneratedTextColumn(
      'variant_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _priceMeta = const VerificationMeta('price');
  GeneratedRealColumn _price;
  @override
  GeneratedRealColumn get price => _price ??= _constructPrice();
  GeneratedRealColumn _constructPrice() {
    return GeneratedRealColumn(
      'price',
      $tableName,
      false,
    );
  }

  final VerificationMeta _costMeta = const VerificationMeta('cost');
  GeneratedRealColumn _cost;
  @override
  GeneratedRealColumn get cost => _cost ??= _constructCost();
  GeneratedRealColumn _constructCost() {
    return GeneratedRealColumn(
      'cost',
      $tableName,
      true,
    );
  }

  final VerificationMeta _quantityMeta = const VerificationMeta('quantity');
  GeneratedIntColumn _quantity;
  @override
  GeneratedIntColumn get quantity => _quantity ??= _constructQuantity();
  GeneratedIntColumn _constructQuantity() {
    return GeneratedIntColumn(
      'quantity',
      $tableName,
      false,
    );
  }

  final VerificationMeta _totalPriceMeta = const VerificationMeta('totalPrice');
  GeneratedRealColumn _totalPrice;
  @override
  GeneratedRealColumn get totalPrice => _totalPrice ??= _constructTotalPrice();
  GeneratedRealColumn _constructTotalPrice() {
    return GeneratedRealColumn(
      'total_price',
      $tableName,
      false,
    );
  }

  final VerificationMeta _discountMeta = const VerificationMeta('discount');
  GeneratedRealColumn _discount;
  @override
  GeneratedRealColumn get discount => _discount ??= _constructDiscount();
  GeneratedRealColumn _constructDiscount() {
    return GeneratedRealColumn(
      'discount',
      $tableName,
      true,
    );
  }

  final VerificationMeta _taxMeta = const VerificationMeta('tax');
  GeneratedRealColumn _tax;
  @override
  GeneratedRealColumn get tax => _tax ??= _constructTax();
  GeneratedRealColumn _constructTax() {
    return GeneratedRealColumn(
      'tax',
      $tableName,
      true,
    );
  }

  final VerificationMeta _saleIdMeta = const VerificationMeta('saleId');
  GeneratedIntColumn _saleId;
  @override
  GeneratedIntColumn get saleId => _saleId ??= _constructSaleId();
  GeneratedIntColumn _constructSaleId() {
    return GeneratedIntColumn('sale_id', $tableName, false,
        $customConstraints: 'REFERENCES sales(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [
        createdAt,
        modifiedAt,
        id,
        productId,
        variantId,
        productName,
        variantName,
        price,
        cost,
        quantity,
        totalPrice,
        discount,
        tax,
        saleId
      ];
  @override
  $SaleItemsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'sale_items';
  @override
  final String actualTableName = 'sale_items';
  @override
  VerificationContext validateIntegrity(Insertable<SaleItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('modified_at')) {
      context.handle(
          _modifiedAtMeta,
          modifiedAt.isAcceptableOrUnknown(
              data['modified_at'], _modifiedAtMeta));
    } else if (isInserting) {
      context.missing(_modifiedAtMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id'], _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('variant_id')) {
      context.handle(_variantIdMeta,
          variantId.isAcceptableOrUnknown(data['variant_id'], _variantIdMeta));
    }
    if (data.containsKey('product_name')) {
      context.handle(
          _productNameMeta,
          productName.isAcceptableOrUnknown(
              data['product_name'], _productNameMeta));
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('variant_name')) {
      context.handle(
          _variantNameMeta,
          variantName.isAcceptableOrUnknown(
              data['variant_name'], _variantNameMeta));
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price'], _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('cost')) {
      context.handle(
          _costMeta, cost.isAcceptableOrUnknown(data['cost'], _costMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity'], _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('total_price')) {
      context.handle(
          _totalPriceMeta,
          totalPrice.isAcceptableOrUnknown(
              data['total_price'], _totalPriceMeta));
    } else if (isInserting) {
      context.missing(_totalPriceMeta);
    }
    if (data.containsKey('discount')) {
      context.handle(_discountMeta,
          discount.isAcceptableOrUnknown(data['discount'], _discountMeta));
    }
    if (data.containsKey('tax')) {
      context.handle(
          _taxMeta, tax.isAcceptableOrUnknown(data['tax'], _taxMeta));
    }
    if (data.containsKey('sale_id')) {
      context.handle(_saleIdMeta,
          saleId.isAcceptableOrUnknown(data['sale_id'], _saleIdMeta));
    } else if (isInserting) {
      context.missing(_saleIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SaleItem map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return SaleItem.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $SaleItemsTable createAlias(String alias) {
    return $SaleItemsTable(_db, alias);
  }
}

abstract class _$POSDatabase extends GeneratedDatabase {
  _$POSDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $CategoriesTable _categories;
  $CategoriesTable get categories => _categories ??= $CategoriesTable(this);
  $DiscountsTable _discounts;
  $DiscountsTable get discounts => _discounts ??= $DiscountsTable(this);
  $TaxesTable _taxes;
  $TaxesTable get taxes => _taxes ??= $TaxesTable(this);
  $ProductsTable _products;
  $ProductsTable get products => _products ??= $ProductsTable(this);
  $VariantsTable _variants;
  $VariantsTable get variants => _variants ??= $VariantsTable(this);
  $ProductDiscountsTable _productDiscounts;
  $ProductDiscountsTable get productDiscounts =>
      _productDiscounts ??= $ProductDiscountsTable(this);
  $ProductTaxesTable _productTaxes;
  $ProductTaxesTable get productTaxes =>
      _productTaxes ??= $ProductTaxesTable(this);
  $ProductBarCodesTable _productBarCodes;
  $ProductBarCodesTable get productBarCodes =>
      _productBarCodes ??= $ProductBarCodesTable(this);
  $SalesTable _sales;
  $SalesTable get sales => _sales ??= $SalesTable(this);
  $SaleItemsTable _saleItems;
  $SaleItemsTable get saleItems => _saleItems ??= $SaleItemsTable(this);
  CategoryDao _categoryDao;
  CategoryDao get categoryDao =>
      _categoryDao ??= CategoryDao(this as POSDatabase);
  DiscountDao _discountDao;
  DiscountDao get discountDao =>
      _discountDao ??= DiscountDao(this as POSDatabase);
  TaxDao _taxDao;
  TaxDao get taxDao => _taxDao ??= TaxDao(this as POSDatabase);
  ProductDao _productDao;
  ProductDao get productDao => _productDao ??= ProductDao(this as POSDatabase);
  SaleDao _saleDao;
  SaleDao get saleDao => _saleDao ??= SaleDao(this as POSDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        categories,
        discounts,
        taxes,
        products,
        variants,
        productDiscounts,
        productTaxes,
        productBarCodes,
        sales,
        saleItems
      ];
}
