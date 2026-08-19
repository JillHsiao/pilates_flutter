// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $StudentsTable extends Students
    with TableInfo<$StudentsTable, StudentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _joinDateMeta = const VerificationMeta(
    'joinDate',
  );
  @override
  late final GeneratedColumn<String> joinDate = GeneratedColumn<String>(
    'join_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    phone,
    joinDate,
    note,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'students';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('join_date')) {
      context.handle(
        _joinDateMeta,
        joinDate.isAcceptableOrUnknown(data['join_date']!, _joinDateMeta),
      );
    } else if (isInserting) {
      context.missing(_joinDateMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudentRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      joinDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}join_date'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $StudentsTable createAlias(String alias) {
    return $StudentsTable(attachedDatabase, alias);
  }
}

class StudentRow extends DataClass implements Insertable<StudentRow> {
  final int id;
  final String name;
  final String? phone;
  final String joinDate;
  final String? note;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  const StudentRow({
    required this.id,
    required this.name,
    this.phone,
    required this.joinDate,
    this.note,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['join_date'] = Variable<String>(joinDate);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  StudentsCompanion toCompanion(bool nullToAbsent) {
    return StudentsCompanion(
      id: Value(id),
      name: Value(name),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      joinDate: Value(joinDate),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory StudentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudentRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      joinDate: serializer.fromJson<String>(json['joinDate']),
      note: serializer.fromJson<String?>(json['note']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'joinDate': serializer.toJson<String>(joinDate),
      'note': serializer.toJson<String?>(note),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  StudentRow copyWith({
    int? id,
    String? name,
    Value<String?> phone = const Value.absent(),
    String? joinDate,
    Value<String?> note = const Value.absent(),
    bool? isActive,
    String? createdAt,
    String? updatedAt,
  }) => StudentRow(
    id: id ?? this.id,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    joinDate: joinDate ?? this.joinDate,
    note: note.present ? note.value : this.note,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  StudentRow copyWithCompanion(StudentsCompanion data) {
    return StudentRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      joinDate: data.joinDate.present ? data.joinDate.value : this.joinDate,
      note: data.note.present ? data.note.value : this.note,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudentRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('joinDate: $joinDate, ')
          ..write('note: $note, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    phone,
    joinDate,
    note,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudentRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.joinDate == this.joinDate &&
          other.note == this.note &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class StudentsCompanion extends UpdateCompanion<StudentRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String> joinDate;
  final Value<String?> note;
  final Value<bool> isActive;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  const StudentsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.joinDate = const Value.absent(),
    this.note = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  StudentsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.phone = const Value.absent(),
    required String joinDate,
    this.note = const Value.absent(),
    this.isActive = const Value.absent(),
    required String createdAt,
    required String updatedAt,
  }) : name = Value(name),
       joinDate = Value(joinDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<StudentRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? joinDate,
    Expression<String>? note,
    Expression<bool>? isActive,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (joinDate != null) 'join_date': joinDate,
      if (note != null) 'note': note,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  StudentsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? phone,
    Value<String>? joinDate,
    Value<String?>? note,
    Value<bool>? isActive,
    Value<String>? createdAt,
    Value<String>? updatedAt,
  }) {
    return StudentsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      joinDate: joinDate ?? this.joinDate,
      note: note ?? this.note,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (joinDate.present) {
      map['join_date'] = Variable<String>(joinDate.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('joinDate: $joinDate, ')
          ..write('note: $note, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CoursePackagesTable extends CoursePackages
    with TableInfo<$CoursePackagesTable, CoursePackageRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoursePackagesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lessonCountMeta = const VerificationMeta(
    'lessonCount',
  );
  @override
  late final GeneratedColumn<int> lessonCount = GeneratedColumn<int>(
    'lesson_count',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('lesson_count > 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<int> price = GeneratedColumn<int>(
    'price',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('price >= 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    lessonCount,
    price,
    isActive,
    sortOrder,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'course_packages';
  @override
  VerificationContext validateIntegrity(
    Insertable<CoursePackageRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('lesson_count')) {
      context.handle(
        _lessonCountMeta,
        lessonCount.isAcceptableOrUnknown(
          data['lesson_count']!,
          _lessonCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lessonCountMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CoursePackageRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CoursePackageRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      lessonCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lesson_count'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CoursePackagesTable createAlias(String alias) {
    return $CoursePackagesTable(attachedDatabase, alias);
  }
}

class CoursePackageRow extends DataClass
    implements Insertable<CoursePackageRow> {
  final int id;
  final String name;
  final int lessonCount;
  final int price;
  final bool isActive;
  final int sortOrder;
  final String createdAt;
  final String updatedAt;
  const CoursePackageRow({
    required this.id,
    required this.name,
    required this.lessonCount,
    required this.price,
    required this.isActive,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['lesson_count'] = Variable<int>(lessonCount);
    map['price'] = Variable<int>(price);
    map['is_active'] = Variable<bool>(isActive);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  CoursePackagesCompanion toCompanion(bool nullToAbsent) {
    return CoursePackagesCompanion(
      id: Value(id),
      name: Value(name),
      lessonCount: Value(lessonCount),
      price: Value(price),
      isActive: Value(isActive),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CoursePackageRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CoursePackageRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      lessonCount: serializer.fromJson<int>(json['lessonCount']),
      price: serializer.fromJson<int>(json['price']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'lessonCount': serializer.toJson<int>(lessonCount),
      'price': serializer.toJson<int>(price),
      'isActive': serializer.toJson<bool>(isActive),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  CoursePackageRow copyWith({
    int? id,
    String? name,
    int? lessonCount,
    int? price,
    bool? isActive,
    int? sortOrder,
    String? createdAt,
    String? updatedAt,
  }) => CoursePackageRow(
    id: id ?? this.id,
    name: name ?? this.name,
    lessonCount: lessonCount ?? this.lessonCount,
    price: price ?? this.price,
    isActive: isActive ?? this.isActive,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CoursePackageRow copyWithCompanion(CoursePackagesCompanion data) {
    return CoursePackageRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      lessonCount: data.lessonCount.present
          ? data.lessonCount.value
          : this.lessonCount,
      price: data.price.present ? data.price.value : this.price,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CoursePackageRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lessonCount: $lessonCount, ')
          ..write('price: $price, ')
          ..write('isActive: $isActive, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    lessonCount,
    price,
    isActive,
    sortOrder,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CoursePackageRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.lessonCount == this.lessonCount &&
          other.price == this.price &&
          other.isActive == this.isActive &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CoursePackagesCompanion extends UpdateCompanion<CoursePackageRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> lessonCount;
  final Value<int> price;
  final Value<bool> isActive;
  final Value<int> sortOrder;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  const CoursePackagesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.lessonCount = const Value.absent(),
    this.price = const Value.absent(),
    this.isActive = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CoursePackagesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int lessonCount,
    required int price,
    this.isActive = const Value.absent(),
    this.sortOrder = const Value.absent(),
    required String createdAt,
    required String updatedAt,
  }) : name = Value(name),
       lessonCount = Value(lessonCount),
       price = Value(price),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<CoursePackageRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? lessonCount,
    Expression<int>? price,
    Expression<bool>? isActive,
    Expression<int>? sortOrder,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (lessonCount != null) 'lesson_count': lessonCount,
      if (price != null) 'price': price,
      if (isActive != null) 'is_active': isActive,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CoursePackagesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? lessonCount,
    Value<int>? price,
    Value<bool>? isActive,
    Value<int>? sortOrder,
    Value<String>? createdAt,
    Value<String>? updatedAt,
  }) {
    return CoursePackagesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      lessonCount: lessonCount ?? this.lessonCount,
      price: price ?? this.price,
      isActive: isActive ?? this.isActive,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (lessonCount.present) {
      map['lesson_count'] = Variable<int>(lessonCount.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoursePackagesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lessonCount: $lessonCount, ')
          ..write('price: $price, ')
          ..write('isActive: $isActive, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PurchasesTable extends Purchases
    with TableInfo<$PurchasesTable, PurchaseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchasesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES students (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _coursePackageIdMeta = const VerificationMeta(
    'coursePackageId',
  );
  @override
  late final GeneratedColumn<int> coursePackageId = GeneratedColumn<int>(
    'course_package_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES course_packages (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _purchaseDateMeta = const VerificationMeta(
    'purchaseDate',
  );
  @override
  late final GeneratedColumn<String> purchaseDate = GeneratedColumn<String>(
    'purchase_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _packageNameMeta = const VerificationMeta(
    'packageName',
  );
  @override
  late final GeneratedColumn<String> packageName = GeneratedColumn<String>(
    'package_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchasedLessonsMeta = const VerificationMeta(
    'purchasedLessons',
  );
  @override
  late final GeneratedColumn<int> purchasedLessons = GeneratedColumn<int>(
    'purchased_lessons',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('purchased_lessons > 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<int> totalAmount = GeneratedColumn<int>(
    'total_amount',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('total_amount >= 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studentId,
    coursePackageId,
    purchaseDate,
    packageName,
    purchasedLessons,
    totalAmount,
    note,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchases';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('course_package_id')) {
      context.handle(
        _coursePackageIdMeta,
        coursePackageId.isAcceptableOrUnknown(
          data['course_package_id']!,
          _coursePackageIdMeta,
        ),
      );
    }
    if (data.containsKey('purchase_date')) {
      context.handle(
        _purchaseDateMeta,
        purchaseDate.isAcceptableOrUnknown(
          data['purchase_date']!,
          _purchaseDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchaseDateMeta);
    }
    if (data.containsKey('package_name')) {
      context.handle(
        _packageNameMeta,
        packageName.isAcceptableOrUnknown(
          data['package_name']!,
          _packageNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_packageNameMeta);
    }
    if (data.containsKey('purchased_lessons')) {
      context.handle(
        _purchasedLessonsMeta,
        purchasedLessons.isAcceptableOrUnknown(
          data['purchased_lessons']!,
          _purchasedLessonsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchasedLessonsMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      )!,
      coursePackageId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}course_package_id'],
      ),
      purchaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_date'],
      )!,
      packageName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}package_name'],
      )!,
      purchasedLessons: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}purchased_lessons'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_amount'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PurchasesTable createAlias(String alias) {
    return $PurchasesTable(attachedDatabase, alias);
  }
}

class PurchaseRow extends DataClass implements Insertable<PurchaseRow> {
  final int id;
  final int studentId;
  final int? coursePackageId;
  final String purchaseDate;
  final String packageName;
  final int purchasedLessons;
  final int totalAmount;
  final String? note;
  final String createdAt;
  final String updatedAt;
  const PurchaseRow({
    required this.id,
    required this.studentId,
    this.coursePackageId,
    required this.purchaseDate,
    required this.packageName,
    required this.purchasedLessons,
    required this.totalAmount,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_id'] = Variable<int>(studentId);
    if (!nullToAbsent || coursePackageId != null) {
      map['course_package_id'] = Variable<int>(coursePackageId);
    }
    map['purchase_date'] = Variable<String>(purchaseDate);
    map['package_name'] = Variable<String>(packageName);
    map['purchased_lessons'] = Variable<int>(purchasedLessons);
    map['total_amount'] = Variable<int>(totalAmount);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  PurchasesCompanion toCompanion(bool nullToAbsent) {
    return PurchasesCompanion(
      id: Value(id),
      studentId: Value(studentId),
      coursePackageId: coursePackageId == null && nullToAbsent
          ? const Value.absent()
          : Value(coursePackageId),
      purchaseDate: Value(purchaseDate),
      packageName: Value(packageName),
      purchasedLessons: Value(purchasedLessons),
      totalAmount: Value(totalAmount),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PurchaseRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseRow(
      id: serializer.fromJson<int>(json['id']),
      studentId: serializer.fromJson<int>(json['studentId']),
      coursePackageId: serializer.fromJson<int?>(json['coursePackageId']),
      purchaseDate: serializer.fromJson<String>(json['purchaseDate']),
      packageName: serializer.fromJson<String>(json['packageName']),
      purchasedLessons: serializer.fromJson<int>(json['purchasedLessons']),
      totalAmount: serializer.fromJson<int>(json['totalAmount']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentId': serializer.toJson<int>(studentId),
      'coursePackageId': serializer.toJson<int?>(coursePackageId),
      'purchaseDate': serializer.toJson<String>(purchaseDate),
      'packageName': serializer.toJson<String>(packageName),
      'purchasedLessons': serializer.toJson<int>(purchasedLessons),
      'totalAmount': serializer.toJson<int>(totalAmount),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  PurchaseRow copyWith({
    int? id,
    int? studentId,
    Value<int?> coursePackageId = const Value.absent(),
    String? purchaseDate,
    String? packageName,
    int? purchasedLessons,
    int? totalAmount,
    Value<String?> note = const Value.absent(),
    String? createdAt,
    String? updatedAt,
  }) => PurchaseRow(
    id: id ?? this.id,
    studentId: studentId ?? this.studentId,
    coursePackageId: coursePackageId.present
        ? coursePackageId.value
        : this.coursePackageId,
    purchaseDate: purchaseDate ?? this.purchaseDate,
    packageName: packageName ?? this.packageName,
    purchasedLessons: purchasedLessons ?? this.purchasedLessons,
    totalAmount: totalAmount ?? this.totalAmount,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PurchaseRow copyWithCompanion(PurchasesCompanion data) {
    return PurchaseRow(
      id: data.id.present ? data.id.value : this.id,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      coursePackageId: data.coursePackageId.present
          ? data.coursePackageId.value
          : this.coursePackageId,
      purchaseDate: data.purchaseDate.present
          ? data.purchaseDate.value
          : this.purchaseDate,
      packageName: data.packageName.present
          ? data.packageName.value
          : this.packageName,
      purchasedLessons: data.purchasedLessons.present
          ? data.purchasedLessons.value
          : this.purchasedLessons,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseRow(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('coursePackageId: $coursePackageId, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('packageName: $packageName, ')
          ..write('purchasedLessons: $purchasedLessons, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    studentId,
    coursePackageId,
    purchaseDate,
    packageName,
    purchasedLessons,
    totalAmount,
    note,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseRow &&
          other.id == this.id &&
          other.studentId == this.studentId &&
          other.coursePackageId == this.coursePackageId &&
          other.purchaseDate == this.purchaseDate &&
          other.packageName == this.packageName &&
          other.purchasedLessons == this.purchasedLessons &&
          other.totalAmount == this.totalAmount &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PurchasesCompanion extends UpdateCompanion<PurchaseRow> {
  final Value<int> id;
  final Value<int> studentId;
  final Value<int?> coursePackageId;
  final Value<String> purchaseDate;
  final Value<String> packageName;
  final Value<int> purchasedLessons;
  final Value<int> totalAmount;
  final Value<String?> note;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  const PurchasesCompanion({
    this.id = const Value.absent(),
    this.studentId = const Value.absent(),
    this.coursePackageId = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.packageName = const Value.absent(),
    this.purchasedLessons = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PurchasesCompanion.insert({
    this.id = const Value.absent(),
    required int studentId,
    this.coursePackageId = const Value.absent(),
    required String purchaseDate,
    required String packageName,
    required int purchasedLessons,
    required int totalAmount,
    this.note = const Value.absent(),
    required String createdAt,
    required String updatedAt,
  }) : studentId = Value(studentId),
       purchaseDate = Value(purchaseDate),
       packageName = Value(packageName),
       purchasedLessons = Value(purchasedLessons),
       totalAmount = Value(totalAmount),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<PurchaseRow> custom({
    Expression<int>? id,
    Expression<int>? studentId,
    Expression<int>? coursePackageId,
    Expression<String>? purchaseDate,
    Expression<String>? packageName,
    Expression<int>? purchasedLessons,
    Expression<int>? totalAmount,
    Expression<String>? note,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentId != null) 'student_id': studentId,
      if (coursePackageId != null) 'course_package_id': coursePackageId,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (packageName != null) 'package_name': packageName,
      if (purchasedLessons != null) 'purchased_lessons': purchasedLessons,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PurchasesCompanion copyWith({
    Value<int>? id,
    Value<int>? studentId,
    Value<int?>? coursePackageId,
    Value<String>? purchaseDate,
    Value<String>? packageName,
    Value<int>? purchasedLessons,
    Value<int>? totalAmount,
    Value<String?>? note,
    Value<String>? createdAt,
    Value<String>? updatedAt,
  }) {
    return PurchasesCompanion(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      coursePackageId: coursePackageId ?? this.coursePackageId,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      packageName: packageName ?? this.packageName,
      purchasedLessons: purchasedLessons ?? this.purchasedLessons,
      totalAmount: totalAmount ?? this.totalAmount,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (coursePackageId.present) {
      map['course_package_id'] = Variable<int>(coursePackageId.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<String>(purchaseDate.value);
    }
    if (packageName.present) {
      map['package_name'] = Variable<String>(packageName.value);
    }
    if (purchasedLessons.present) {
      map['purchased_lessons'] = Variable<int>(purchasedLessons.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<int>(totalAmount.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchasesCompanion(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('coursePackageId: $coursePackageId, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('packageName: $packageName, ')
          ..write('purchasedLessons: $purchasedLessons, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTable extends Payments
    with TableInfo<$PaymentsTable, PaymentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _purchaseIdMeta = const VerificationMeta(
    'purchaseId',
  );
  @override
  late final GeneratedColumn<int> purchaseId = GeneratedColumn<int>(
    'purchase_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES purchases (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _paymentDateMeta = const VerificationMeta(
    'paymentDate',
  );
  @override
  late final GeneratedColumn<String> paymentDate = GeneratedColumn<String>(
    'payment_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('amount > 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    purchaseId,
    paymentDate,
    amount,
    paymentMethod,
    note,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('purchase_id')) {
      context.handle(
        _purchaseIdMeta,
        purchaseId.isAcceptableOrUnknown(data['purchase_id']!, _purchaseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_purchaseIdMeta);
    }
    if (data.containsKey('payment_date')) {
      context.handle(
        _paymentDateMeta,
        paymentDate.isAcceptableOrUnknown(
          data['payment_date']!,
          _paymentDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentDateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      purchaseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}purchase_id'],
      )!,
      paymentDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_date'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }
}

class PaymentRow extends DataClass implements Insertable<PaymentRow> {
  final int id;
  final int purchaseId;
  final String paymentDate;
  final int amount;
  final String paymentMethod;
  final String? note;
  final String createdAt;
  const PaymentRow({
    required this.id,
    required this.purchaseId,
    required this.paymentDate,
    required this.amount,
    required this.paymentMethod,
    this.note,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['purchase_id'] = Variable<int>(purchaseId);
    map['payment_date'] = Variable<String>(paymentDate);
    map['amount'] = Variable<int>(amount);
    map['payment_method'] = Variable<String>(paymentMethod);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  PaymentsCompanion toCompanion(bool nullToAbsent) {
    return PaymentsCompanion(
      id: Value(id),
      purchaseId: Value(purchaseId),
      paymentDate: Value(paymentDate),
      amount: Value(amount),
      paymentMethod: Value(paymentMethod),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory PaymentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentRow(
      id: serializer.fromJson<int>(json['id']),
      purchaseId: serializer.fromJson<int>(json['purchaseId']),
      paymentDate: serializer.fromJson<String>(json['paymentDate']),
      amount: serializer.fromJson<int>(json['amount']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'purchaseId': serializer.toJson<int>(purchaseId),
      'paymentDate': serializer.toJson<String>(paymentDate),
      'amount': serializer.toJson<int>(amount),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  PaymentRow copyWith({
    int? id,
    int? purchaseId,
    String? paymentDate,
    int? amount,
    String? paymentMethod,
    Value<String?> note = const Value.absent(),
    String? createdAt,
  }) => PaymentRow(
    id: id ?? this.id,
    purchaseId: purchaseId ?? this.purchaseId,
    paymentDate: paymentDate ?? this.paymentDate,
    amount: amount ?? this.amount,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
  );
  PaymentRow copyWithCompanion(PaymentsCompanion data) {
    return PaymentRow(
      id: data.id.present ? data.id.value : this.id,
      purchaseId: data.purchaseId.present
          ? data.purchaseId.value
          : this.purchaseId,
      paymentDate: data.paymentDate.present
          ? data.paymentDate.value
          : this.paymentDate,
      amount: data.amount.present ? data.amount.value : this.amount,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentRow(')
          ..write('id: $id, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('amount: $amount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    purchaseId,
    paymentDate,
    amount,
    paymentMethod,
    note,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentRow &&
          other.id == this.id &&
          other.purchaseId == this.purchaseId &&
          other.paymentDate == this.paymentDate &&
          other.amount == this.amount &&
          other.paymentMethod == this.paymentMethod &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class PaymentsCompanion extends UpdateCompanion<PaymentRow> {
  final Value<int> id;
  final Value<int> purchaseId;
  final Value<String> paymentDate;
  final Value<int> amount;
  final Value<String> paymentMethod;
  final Value<String?> note;
  final Value<String> createdAt;
  const PaymentsCompanion({
    this.id = const Value.absent(),
    this.purchaseId = const Value.absent(),
    this.paymentDate = const Value.absent(),
    this.amount = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int purchaseId,
    required String paymentDate,
    required int amount,
    required String paymentMethod,
    this.note = const Value.absent(),
    required String createdAt,
  }) : purchaseId = Value(purchaseId),
       paymentDate = Value(paymentDate),
       amount = Value(amount),
       paymentMethod = Value(paymentMethod),
       createdAt = Value(createdAt);
  static Insertable<PaymentRow> custom({
    Expression<int>? id,
    Expression<int>? purchaseId,
    Expression<String>? paymentDate,
    Expression<int>? amount,
    Expression<String>? paymentMethod,
    Expression<String>? note,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (purchaseId != null) 'purchase_id': purchaseId,
      if (paymentDate != null) 'payment_date': paymentDate,
      if (amount != null) 'amount': amount,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PaymentsCompanion copyWith({
    Value<int>? id,
    Value<int>? purchaseId,
    Value<String>? paymentDate,
    Value<int>? amount,
    Value<String>? paymentMethod,
    Value<String?>? note,
    Value<String>? createdAt,
  }) {
    return PaymentsCompanion(
      id: id ?? this.id,
      purchaseId: purchaseId ?? this.purchaseId,
      paymentDate: paymentDate ?? this.paymentDate,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (purchaseId.present) {
      map['purchase_id'] = Variable<int>(purchaseId.value);
    }
    if (paymentDate.present) {
      map['payment_date'] = Variable<String>(paymentDate.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('id: $id, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('amount: $amount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $LessonRecordsTable extends LessonRecords
    with TableInfo<$LessonRecordsTable, LessonRecordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LessonRecordsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES students (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _lessonDateMeta = const VerificationMeta(
    'lessonDate',
  );
  @override
  late final GeneratedColumn<String> lessonDate = GeneratedColumn<String>(
    'lesson_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _physicalConditionMeta = const VerificationMeta(
    'physicalCondition',
  );
  @override
  late final GeneratedColumn<String> physicalCondition =
      GeneratedColumn<String>(
        'physical_condition',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studentId,
    lessonDate,
    status,
    content,
    physicalCondition,
    note,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lesson_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<LessonRecordRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('lesson_date')) {
      context.handle(
        _lessonDateMeta,
        lessonDate.isAcceptableOrUnknown(data['lesson_date']!, _lessonDateMeta),
      );
    } else if (isInserting) {
      context.missing(_lessonDateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    }
    if (data.containsKey('physical_condition')) {
      context.handle(
        _physicalConditionMeta,
        physicalCondition.isAcceptableOrUnknown(
          data['physical_condition']!,
          _physicalConditionMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LessonRecordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LessonRecordRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      )!,
      lessonDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lesson_date'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      ),
      physicalCondition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}physical_condition'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $LessonRecordsTable createAlias(String alias) {
    return $LessonRecordsTable(attachedDatabase, alias);
  }
}

class LessonRecordRow extends DataClass implements Insertable<LessonRecordRow> {
  final int id;
  final int studentId;
  final String lessonDate;
  final String status;
  final String? content;
  final String? physicalCondition;
  final String? note;
  final String createdAt;
  final String updatedAt;
  const LessonRecordRow({
    required this.id,
    required this.studentId,
    required this.lessonDate,
    required this.status,
    this.content,
    this.physicalCondition,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_id'] = Variable<int>(studentId);
    map['lesson_date'] = Variable<String>(lessonDate);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    if (!nullToAbsent || physicalCondition != null) {
      map['physical_condition'] = Variable<String>(physicalCondition);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  LessonRecordsCompanion toCompanion(bool nullToAbsent) {
    return LessonRecordsCompanion(
      id: Value(id),
      studentId: Value(studentId),
      lessonDate: Value(lessonDate),
      status: Value(status),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      physicalCondition: physicalCondition == null && nullToAbsent
          ? const Value.absent()
          : Value(physicalCondition),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LessonRecordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LessonRecordRow(
      id: serializer.fromJson<int>(json['id']),
      studentId: serializer.fromJson<int>(json['studentId']),
      lessonDate: serializer.fromJson<String>(json['lessonDate']),
      status: serializer.fromJson<String>(json['status']),
      content: serializer.fromJson<String?>(json['content']),
      physicalCondition: serializer.fromJson<String?>(
        json['physicalCondition'],
      ),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentId': serializer.toJson<int>(studentId),
      'lessonDate': serializer.toJson<String>(lessonDate),
      'status': serializer.toJson<String>(status),
      'content': serializer.toJson<String?>(content),
      'physicalCondition': serializer.toJson<String?>(physicalCondition),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  LessonRecordRow copyWith({
    int? id,
    int? studentId,
    String? lessonDate,
    String? status,
    Value<String?> content = const Value.absent(),
    Value<String?> physicalCondition = const Value.absent(),
    Value<String?> note = const Value.absent(),
    String? createdAt,
    String? updatedAt,
  }) => LessonRecordRow(
    id: id ?? this.id,
    studentId: studentId ?? this.studentId,
    lessonDate: lessonDate ?? this.lessonDate,
    status: status ?? this.status,
    content: content.present ? content.value : this.content,
    physicalCondition: physicalCondition.present
        ? physicalCondition.value
        : this.physicalCondition,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  LessonRecordRow copyWithCompanion(LessonRecordsCompanion data) {
    return LessonRecordRow(
      id: data.id.present ? data.id.value : this.id,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      lessonDate: data.lessonDate.present
          ? data.lessonDate.value
          : this.lessonDate,
      status: data.status.present ? data.status.value : this.status,
      content: data.content.present ? data.content.value : this.content,
      physicalCondition: data.physicalCondition.present
          ? data.physicalCondition.value
          : this.physicalCondition,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LessonRecordRow(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('lessonDate: $lessonDate, ')
          ..write('status: $status, ')
          ..write('content: $content, ')
          ..write('physicalCondition: $physicalCondition, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    studentId,
    lessonDate,
    status,
    content,
    physicalCondition,
    note,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LessonRecordRow &&
          other.id == this.id &&
          other.studentId == this.studentId &&
          other.lessonDate == this.lessonDate &&
          other.status == this.status &&
          other.content == this.content &&
          other.physicalCondition == this.physicalCondition &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LessonRecordsCompanion extends UpdateCompanion<LessonRecordRow> {
  final Value<int> id;
  final Value<int> studentId;
  final Value<String> lessonDate;
  final Value<String> status;
  final Value<String?> content;
  final Value<String?> physicalCondition;
  final Value<String?> note;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  const LessonRecordsCompanion({
    this.id = const Value.absent(),
    this.studentId = const Value.absent(),
    this.lessonDate = const Value.absent(),
    this.status = const Value.absent(),
    this.content = const Value.absent(),
    this.physicalCondition = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LessonRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int studentId,
    required String lessonDate,
    required String status,
    this.content = const Value.absent(),
    this.physicalCondition = const Value.absent(),
    this.note = const Value.absent(),
    required String createdAt,
    required String updatedAt,
  }) : studentId = Value(studentId),
       lessonDate = Value(lessonDate),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LessonRecordRow> custom({
    Expression<int>? id,
    Expression<int>? studentId,
    Expression<String>? lessonDate,
    Expression<String>? status,
    Expression<String>? content,
    Expression<String>? physicalCondition,
    Expression<String>? note,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentId != null) 'student_id': studentId,
      if (lessonDate != null) 'lesson_date': lessonDate,
      if (status != null) 'status': status,
      if (content != null) 'content': content,
      if (physicalCondition != null) 'physical_condition': physicalCondition,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LessonRecordsCompanion copyWith({
    Value<int>? id,
    Value<int>? studentId,
    Value<String>? lessonDate,
    Value<String>? status,
    Value<String?>? content,
    Value<String?>? physicalCondition,
    Value<String?>? note,
    Value<String>? createdAt,
    Value<String>? updatedAt,
  }) {
    return LessonRecordsCompanion(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      lessonDate: lessonDate ?? this.lessonDate,
      status: status ?? this.status,
      content: content ?? this.content,
      physicalCondition: physicalCondition ?? this.physicalCondition,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (lessonDate.present) {
      map['lesson_date'] = Variable<String>(lessonDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (physicalCondition.present) {
      map['physical_condition'] = Variable<String>(physicalCondition.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LessonRecordsCompanion(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('lessonDate: $lessonDate, ')
          ..write('status: $status, ')
          ..write('content: $content, ')
          ..write('physicalCondition: $physicalCondition, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $StudentsTable students = $StudentsTable(this);
  late final $CoursePackagesTable coursePackages = $CoursePackagesTable(this);
  late final $PurchasesTable purchases = $PurchasesTable(this);
  late final $PaymentsTable payments = $PaymentsTable(this);
  late final $LessonRecordsTable lessonRecords = $LessonRecordsTable(this);
  late final StudentDao studentDao = StudentDao(this as AppDatabase);
  late final LessonDao lessonDao = LessonDao(this as AppDatabase);
  late final PurchaseDao purchaseDao = PurchaseDao(this as AppDatabase);
  late final DashboardDao dashboardDao = DashboardDao(this as AppDatabase);
  late final ReportDao reportDao = ReportDao(this as AppDatabase);
  late final SettingsDao settingsDao = SettingsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    students,
    coursePackages,
    purchases,
    payments,
    lessonRecords,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'course_packages',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('purchases', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'purchases',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('payments', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$StudentsTableCreateCompanionBuilder =
    StudentsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> phone,
      required String joinDate,
      Value<String?> note,
      Value<bool> isActive,
      required String createdAt,
      required String updatedAt,
    });
typedef $$StudentsTableUpdateCompanionBuilder =
    StudentsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> phone,
      Value<String> joinDate,
      Value<String?> note,
      Value<bool> isActive,
      Value<String> createdAt,
      Value<String> updatedAt,
    });

final class $$StudentsTableReferences
    extends BaseReferences<_$AppDatabase, $StudentsTable, StudentRow> {
  $$StudentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PurchasesTable, List<PurchaseRow>>
  _purchasesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.purchases,
    aliasName: 'students__id__purchases__student_id',
  );

  $$PurchasesTableProcessedTableManager get purchasesRefs {
    final manager = $$PurchasesTableTableManager(
      $_db,
      $_db.purchases,
    ).filter((f) => f.studentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_purchasesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LessonRecordsTable, List<LessonRecordRow>>
  _lessonRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.lessonRecords,
    aliasName: 'students__id__lesson_records__student_id',
  );

  $$LessonRecordsTableProcessedTableManager get lessonRecordsRefs {
    final manager = $$LessonRecordsTableTableManager(
      $_db,
      $_db.lessonRecords,
    ).filter((f) => f.studentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_lessonRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StudentsTableFilterComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get joinDate => $composableBuilder(
    column: $table.joinDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> purchasesRefs(
    Expression<bool> Function($$PurchasesTableFilterComposer f) f,
  ) {
    final $$PurchasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableFilterComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> lessonRecordsRefs(
    Expression<bool> Function($$LessonRecordsTableFilterComposer f) f,
  ) {
    final $$LessonRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lessonRecords,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LessonRecordsTableFilterComposer(
            $db: $db,
            $table: $db.lessonRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudentsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get joinDate => $composableBuilder(
    column: $table.joinDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get joinDate =>
      $composableBuilder(column: $table.joinDate, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> purchasesRefs<T extends Object>(
    Expression<T> Function($$PurchasesTableAnnotationComposer a) f,
  ) {
    final $$PurchasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableAnnotationComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> lessonRecordsRefs<T extends Object>(
    Expression<T> Function($$LessonRecordsTableAnnotationComposer a) f,
  ) {
    final $$LessonRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lessonRecords,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LessonRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.lessonRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudentsTable,
          StudentRow,
          $$StudentsTableFilterComposer,
          $$StudentsTableOrderingComposer,
          $$StudentsTableAnnotationComposer,
          $$StudentsTableCreateCompanionBuilder,
          $$StudentsTableUpdateCompanionBuilder,
          (StudentRow, $$StudentsTableReferences),
          StudentRow,
          PrefetchHooks Function({bool purchasesRefs, bool lessonRecordsRefs})
        > {
  $$StudentsTableTableManager(_$AppDatabase db, $StudentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String> joinDate = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
              }) => StudentsCompanion(
                id: id,
                name: name,
                phone: phone,
                joinDate: joinDate,
                note: note,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> phone = const Value.absent(),
                required String joinDate,
                Value<String?> note = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required String createdAt,
                required String updatedAt,
              }) => StudentsCompanion.insert(
                id: id,
                name: name,
                phone: phone,
                joinDate: joinDate,
                note: note,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StudentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({purchasesRefs = false, lessonRecordsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (purchasesRefs) db.purchases,
                    if (lessonRecordsRefs) db.lessonRecords,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (purchasesRefs)
                        await $_getPrefetchedData<
                          StudentRow,
                          $StudentsTable,
                          PurchaseRow
                        >(
                          currentTable: table,
                          referencedTable: $$StudentsTableReferences
                              ._purchasesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudentsTableReferences(
                                db,
                                table,
                                p0,
                              ).purchasesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.studentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (lessonRecordsRefs)
                        await $_getPrefetchedData<
                          StudentRow,
                          $StudentsTable,
                          LessonRecordRow
                        >(
                          currentTable: table,
                          referencedTable: $$StudentsTableReferences
                              ._lessonRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudentsTableReferences(
                                db,
                                table,
                                p0,
                              ).lessonRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.studentId == item.id,
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

typedef $$StudentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudentsTable,
      StudentRow,
      $$StudentsTableFilterComposer,
      $$StudentsTableOrderingComposer,
      $$StudentsTableAnnotationComposer,
      $$StudentsTableCreateCompanionBuilder,
      $$StudentsTableUpdateCompanionBuilder,
      (StudentRow, $$StudentsTableReferences),
      StudentRow,
      PrefetchHooks Function({bool purchasesRefs, bool lessonRecordsRefs})
    >;
typedef $$CoursePackagesTableCreateCompanionBuilder =
    CoursePackagesCompanion Function({
      Value<int> id,
      required String name,
      required int lessonCount,
      required int price,
      Value<bool> isActive,
      Value<int> sortOrder,
      required String createdAt,
      required String updatedAt,
    });
typedef $$CoursePackagesTableUpdateCompanionBuilder =
    CoursePackagesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> lessonCount,
      Value<int> price,
      Value<bool> isActive,
      Value<int> sortOrder,
      Value<String> createdAt,
      Value<String> updatedAt,
    });

final class $$CoursePackagesTableReferences
    extends
        BaseReferences<_$AppDatabase, $CoursePackagesTable, CoursePackageRow> {
  $$CoursePackagesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$PurchasesTable, List<PurchaseRow>>
  _purchasesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.purchases,
    aliasName: 'course_packages__id__purchases__course_package_id',
  );

  $$PurchasesTableProcessedTableManager get purchasesRefs {
    final manager = $$PurchasesTableTableManager(
      $_db,
      $_db.purchases,
    ).filter((f) => f.coursePackageId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_purchasesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CoursePackagesTableFilterComposer
    extends Composer<_$AppDatabase, $CoursePackagesTable> {
  $$CoursePackagesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lessonCount => $composableBuilder(
    column: $table.lessonCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> purchasesRefs(
    Expression<bool> Function($$PurchasesTableFilterComposer f) f,
  ) {
    final $$PurchasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.coursePackageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableFilterComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CoursePackagesTableOrderingComposer
    extends Composer<_$AppDatabase, $CoursePackagesTable> {
  $$CoursePackagesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lessonCount => $composableBuilder(
    column: $table.lessonCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CoursePackagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CoursePackagesTable> {
  $$CoursePackagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get lessonCount => $composableBuilder(
    column: $table.lessonCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> purchasesRefs<T extends Object>(
    Expression<T> Function($$PurchasesTableAnnotationComposer a) f,
  ) {
    final $$PurchasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.coursePackageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableAnnotationComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CoursePackagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CoursePackagesTable,
          CoursePackageRow,
          $$CoursePackagesTableFilterComposer,
          $$CoursePackagesTableOrderingComposer,
          $$CoursePackagesTableAnnotationComposer,
          $$CoursePackagesTableCreateCompanionBuilder,
          $$CoursePackagesTableUpdateCompanionBuilder,
          (CoursePackageRow, $$CoursePackagesTableReferences),
          CoursePackageRow,
          PrefetchHooks Function({bool purchasesRefs})
        > {
  $$CoursePackagesTableTableManager(
    _$AppDatabase db,
    $CoursePackagesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoursePackagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoursePackagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CoursePackagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> lessonCount = const Value.absent(),
                Value<int> price = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
              }) => CoursePackagesCompanion(
                id: id,
                name: name,
                lessonCount: lessonCount,
                price: price,
                isActive: isActive,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int lessonCount,
                required int price,
                Value<bool> isActive = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                required String createdAt,
                required String updatedAt,
              }) => CoursePackagesCompanion.insert(
                id: id,
                name: name,
                lessonCount: lessonCount,
                price: price,
                isActive: isActive,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CoursePackagesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({purchasesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (purchasesRefs) db.purchases],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (purchasesRefs)
                    await $_getPrefetchedData<
                      CoursePackageRow,
                      $CoursePackagesTable,
                      PurchaseRow
                    >(
                      currentTable: table,
                      referencedTable: $$CoursePackagesTableReferences
                          ._purchasesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CoursePackagesTableReferences(
                            db,
                            table,
                            p0,
                          ).purchasesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.coursePackageId == item.id,
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

typedef $$CoursePackagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CoursePackagesTable,
      CoursePackageRow,
      $$CoursePackagesTableFilterComposer,
      $$CoursePackagesTableOrderingComposer,
      $$CoursePackagesTableAnnotationComposer,
      $$CoursePackagesTableCreateCompanionBuilder,
      $$CoursePackagesTableUpdateCompanionBuilder,
      (CoursePackageRow, $$CoursePackagesTableReferences),
      CoursePackageRow,
      PrefetchHooks Function({bool purchasesRefs})
    >;
typedef $$PurchasesTableCreateCompanionBuilder =
    PurchasesCompanion Function({
      Value<int> id,
      required int studentId,
      Value<int?> coursePackageId,
      required String purchaseDate,
      required String packageName,
      required int purchasedLessons,
      required int totalAmount,
      Value<String?> note,
      required String createdAt,
      required String updatedAt,
    });
typedef $$PurchasesTableUpdateCompanionBuilder =
    PurchasesCompanion Function({
      Value<int> id,
      Value<int> studentId,
      Value<int?> coursePackageId,
      Value<String> purchaseDate,
      Value<String> packageName,
      Value<int> purchasedLessons,
      Value<int> totalAmount,
      Value<String?> note,
      Value<String> createdAt,
      Value<String> updatedAt,
    });

final class $$PurchasesTableReferences
    extends BaseReferences<_$AppDatabase, $PurchasesTable, PurchaseRow> {
  $$PurchasesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StudentsTable _studentIdTable(_$AppDatabase db) =>
      db.students.createAlias('purchases__student_id__students__id');

  $$StudentsTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<int>('student_id')!;

    final manager = $$StudentsTableTableManager(
      $_db,
      $_db.students,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CoursePackagesTable _coursePackageIdTable(_$AppDatabase db) => db
      .coursePackages
      .createAlias('purchases__course_package_id__course_packages__id');

  $$CoursePackagesTableProcessedTableManager? get coursePackageId {
    final $_column = $_itemColumn<int>('course_package_id');
    if ($_column == null) return null;
    final manager = $$CoursePackagesTableTableManager(
      $_db,
      $_db.coursePackages,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_coursePackageIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PaymentsTable, List<PaymentRow>>
  _paymentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.payments,
    aliasName: 'purchases__id__payments__purchase_id',
  );

  $$PaymentsTableProcessedTableManager get paymentsRefs {
    final manager = $$PaymentsTableTableManager(
      $_db,
      $_db.payments,
    ).filter((f) => f.purchaseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PurchasesTableFilterComposer
    extends Composer<_$AppDatabase, $PurchasesTable> {
  $$PurchasesTableFilterComposer({
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

  ColumnFilters<String> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get purchasedLessons => $composableBuilder(
    column: $table.purchasedLessons,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$StudentsTableFilterComposer get studentId {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableFilterComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CoursePackagesTableFilterComposer get coursePackageId {
    final $$CoursePackagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coursePackageId,
      referencedTable: $db.coursePackages,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursePackagesTableFilterComposer(
            $db: $db,
            $table: $db.coursePackages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> paymentsRefs(
    Expression<bool> Function($$PaymentsTableFilterComposer f) f,
  ) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.purchaseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableFilterComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PurchasesTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchasesTable> {
  $$PurchasesTableOrderingComposer({
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

  ColumnOrderings<String> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get purchasedLessons => $composableBuilder(
    column: $table.purchasedLessons,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudentsTableOrderingComposer get studentId {
    final $$StudentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableOrderingComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CoursePackagesTableOrderingComposer get coursePackageId {
    final $$CoursePackagesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coursePackageId,
      referencedTable: $db.coursePackages,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursePackagesTableOrderingComposer(
            $db: $db,
            $table: $db.coursePackages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchasesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchasesTable> {
  $$PurchasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get purchasedLessons => $composableBuilder(
    column: $table.purchasedLessons,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$StudentsTableAnnotationComposer get studentId {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableAnnotationComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CoursePackagesTableAnnotationComposer get coursePackageId {
    final $$CoursePackagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coursePackageId,
      referencedTable: $db.coursePackages,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursePackagesTableAnnotationComposer(
            $db: $db,
            $table: $db.coursePackages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> paymentsRefs<T extends Object>(
    Expression<T> Function($$PaymentsTableAnnotationComposer a) f,
  ) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.purchaseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PurchasesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchasesTable,
          PurchaseRow,
          $$PurchasesTableFilterComposer,
          $$PurchasesTableOrderingComposer,
          $$PurchasesTableAnnotationComposer,
          $$PurchasesTableCreateCompanionBuilder,
          $$PurchasesTableUpdateCompanionBuilder,
          (PurchaseRow, $$PurchasesTableReferences),
          PurchaseRow,
          PrefetchHooks Function({
            bool studentId,
            bool coursePackageId,
            bool paymentsRefs,
          })
        > {
  $$PurchasesTableTableManager(_$AppDatabase db, $PurchasesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchasesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<int?> coursePackageId = const Value.absent(),
                Value<String> purchaseDate = const Value.absent(),
                Value<String> packageName = const Value.absent(),
                Value<int> purchasedLessons = const Value.absent(),
                Value<int> totalAmount = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
              }) => PurchasesCompanion(
                id: id,
                studentId: studentId,
                coursePackageId: coursePackageId,
                purchaseDate: purchaseDate,
                packageName: packageName,
                purchasedLessons: purchasedLessons,
                totalAmount: totalAmount,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int studentId,
                Value<int?> coursePackageId = const Value.absent(),
                required String purchaseDate,
                required String packageName,
                required int purchasedLessons,
                required int totalAmount,
                Value<String?> note = const Value.absent(),
                required String createdAt,
                required String updatedAt,
              }) => PurchasesCompanion.insert(
                id: id,
                studentId: studentId,
                coursePackageId: coursePackageId,
                purchaseDate: purchaseDate,
                packageName: packageName,
                purchasedLessons: purchasedLessons,
                totalAmount: totalAmount,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PurchasesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                studentId = false,
                coursePackageId = false,
                paymentsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (paymentsRefs) db.payments],
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
                        if (studentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.studentId,
                                    referencedTable: $$PurchasesTableReferences
                                        ._studentIdTable(db),
                                    referencedColumn: $$PurchasesTableReferences
                                        ._studentIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (coursePackageId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.coursePackageId,
                                    referencedTable: $$PurchasesTableReferences
                                        ._coursePackageIdTable(db),
                                    referencedColumn: $$PurchasesTableReferences
                                        ._coursePackageIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (paymentsRefs)
                        await $_getPrefetchedData<
                          PurchaseRow,
                          $PurchasesTable,
                          PaymentRow
                        >(
                          currentTable: table,
                          referencedTable: $$PurchasesTableReferences
                              ._paymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PurchasesTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.purchaseId == item.id,
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

typedef $$PurchasesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchasesTable,
      PurchaseRow,
      $$PurchasesTableFilterComposer,
      $$PurchasesTableOrderingComposer,
      $$PurchasesTableAnnotationComposer,
      $$PurchasesTableCreateCompanionBuilder,
      $$PurchasesTableUpdateCompanionBuilder,
      (PurchaseRow, $$PurchasesTableReferences),
      PurchaseRow,
      PrefetchHooks Function({
        bool studentId,
        bool coursePackageId,
        bool paymentsRefs,
      })
    >;
typedef $$PaymentsTableCreateCompanionBuilder =
    PaymentsCompanion Function({
      Value<int> id,
      required int purchaseId,
      required String paymentDate,
      required int amount,
      required String paymentMethod,
      Value<String?> note,
      required String createdAt,
    });
typedef $$PaymentsTableUpdateCompanionBuilder =
    PaymentsCompanion Function({
      Value<int> id,
      Value<int> purchaseId,
      Value<String> paymentDate,
      Value<int> amount,
      Value<String> paymentMethod,
      Value<String?> note,
      Value<String> createdAt,
    });

final class $$PaymentsTableReferences
    extends BaseReferences<_$AppDatabase, $PaymentsTable, PaymentRow> {
  $$PaymentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PurchasesTable _purchaseIdTable(_$AppDatabase db) =>
      db.purchases.createAlias('payments__purchase_id__purchases__id');

  $$PurchasesTableProcessedTableManager get purchaseId {
    final $_column = $_itemColumn<int>('purchase_id')!;

    final manager = $$PurchasesTableTableManager(
      $_db,
      $_db.purchases,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_purchaseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableFilterComposer({
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

  ColumnFilters<String> get paymentDate => $composableBuilder(
    column: $table.paymentDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PurchasesTableFilterComposer get purchaseId {
    final $$PurchasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseId,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableFilterComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableOrderingComposer({
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

  ColumnOrderings<String> get paymentDate => $composableBuilder(
    column: $table.paymentDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PurchasesTableOrderingComposer get purchaseId {
    final $$PurchasesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseId,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableOrderingComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get paymentDate => $composableBuilder(
    column: $table.paymentDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PurchasesTableAnnotationComposer get purchaseId {
    final $$PurchasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseId,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableAnnotationComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentsTable,
          PaymentRow,
          $$PaymentsTableFilterComposer,
          $$PaymentsTableOrderingComposer,
          $$PaymentsTableAnnotationComposer,
          $$PaymentsTableCreateCompanionBuilder,
          $$PaymentsTableUpdateCompanionBuilder,
          (PaymentRow, $$PaymentsTableReferences),
          PaymentRow,
          PrefetchHooks Function({bool purchaseId})
        > {
  $$PaymentsTableTableManager(_$AppDatabase db, $PaymentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> purchaseId = const Value.absent(),
                Value<String> paymentDate = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
              }) => PaymentsCompanion(
                id: id,
                purchaseId: purchaseId,
                paymentDate: paymentDate,
                amount: amount,
                paymentMethod: paymentMethod,
                note: note,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int purchaseId,
                required String paymentDate,
                required int amount,
                required String paymentMethod,
                Value<String?> note = const Value.absent(),
                required String createdAt,
              }) => PaymentsCompanion.insert(
                id: id,
                purchaseId: purchaseId,
                paymentDate: paymentDate,
                amount: amount,
                paymentMethod: paymentMethod,
                note: note,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PaymentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({purchaseId = false}) {
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
                    if (purchaseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.purchaseId,
                                referencedTable: $$PaymentsTableReferences
                                    ._purchaseIdTable(db),
                                referencedColumn: $$PaymentsTableReferences
                                    ._purchaseIdTable(db)
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

typedef $$PaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentsTable,
      PaymentRow,
      $$PaymentsTableFilterComposer,
      $$PaymentsTableOrderingComposer,
      $$PaymentsTableAnnotationComposer,
      $$PaymentsTableCreateCompanionBuilder,
      $$PaymentsTableUpdateCompanionBuilder,
      (PaymentRow, $$PaymentsTableReferences),
      PaymentRow,
      PrefetchHooks Function({bool purchaseId})
    >;
typedef $$LessonRecordsTableCreateCompanionBuilder =
    LessonRecordsCompanion Function({
      Value<int> id,
      required int studentId,
      required String lessonDate,
      required String status,
      Value<String?> content,
      Value<String?> physicalCondition,
      Value<String?> note,
      required String createdAt,
      required String updatedAt,
    });
typedef $$LessonRecordsTableUpdateCompanionBuilder =
    LessonRecordsCompanion Function({
      Value<int> id,
      Value<int> studentId,
      Value<String> lessonDate,
      Value<String> status,
      Value<String?> content,
      Value<String?> physicalCondition,
      Value<String?> note,
      Value<String> createdAt,
      Value<String> updatedAt,
    });

final class $$LessonRecordsTableReferences
    extends
        BaseReferences<_$AppDatabase, $LessonRecordsTable, LessonRecordRow> {
  $$LessonRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $StudentsTable _studentIdTable(_$AppDatabase db) =>
      db.students.createAlias('lesson_records__student_id__students__id');

  $$StudentsTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<int>('student_id')!;

    final manager = $$StudentsTableTableManager(
      $_db,
      $_db.students,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LessonRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $LessonRecordsTable> {
  $$LessonRecordsTableFilterComposer({
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

  ColumnFilters<String> get lessonDate => $composableBuilder(
    column: $table.lessonDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get physicalCondition => $composableBuilder(
    column: $table.physicalCondition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$StudentsTableFilterComposer get studentId {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableFilterComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LessonRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $LessonRecordsTable> {
  $$LessonRecordsTableOrderingComposer({
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

  ColumnOrderings<String> get lessonDate => $composableBuilder(
    column: $table.lessonDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get physicalCondition => $composableBuilder(
    column: $table.physicalCondition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudentsTableOrderingComposer get studentId {
    final $$StudentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableOrderingComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LessonRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LessonRecordsTable> {
  $$LessonRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get lessonDate => $composableBuilder(
    column: $table.lessonDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get physicalCondition => $composableBuilder(
    column: $table.physicalCondition,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$StudentsTableAnnotationComposer get studentId {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableAnnotationComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LessonRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LessonRecordsTable,
          LessonRecordRow,
          $$LessonRecordsTableFilterComposer,
          $$LessonRecordsTableOrderingComposer,
          $$LessonRecordsTableAnnotationComposer,
          $$LessonRecordsTableCreateCompanionBuilder,
          $$LessonRecordsTableUpdateCompanionBuilder,
          (LessonRecordRow, $$LessonRecordsTableReferences),
          LessonRecordRow,
          PrefetchHooks Function({bool studentId})
        > {
  $$LessonRecordsTableTableManager(_$AppDatabase db, $LessonRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LessonRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LessonRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LessonRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<String> lessonDate = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> content = const Value.absent(),
                Value<String?> physicalCondition = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
              }) => LessonRecordsCompanion(
                id: id,
                studentId: studentId,
                lessonDate: lessonDate,
                status: status,
                content: content,
                physicalCondition: physicalCondition,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int studentId,
                required String lessonDate,
                required String status,
                Value<String?> content = const Value.absent(),
                Value<String?> physicalCondition = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required String createdAt,
                required String updatedAt,
              }) => LessonRecordsCompanion.insert(
                id: id,
                studentId: studentId,
                lessonDate: lessonDate,
                status: status,
                content: content,
                physicalCondition: physicalCondition,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LessonRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({studentId = false}) {
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
                    if (studentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.studentId,
                                referencedTable: $$LessonRecordsTableReferences
                                    ._studentIdTable(db),
                                referencedColumn: $$LessonRecordsTableReferences
                                    ._studentIdTable(db)
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

typedef $$LessonRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LessonRecordsTable,
      LessonRecordRow,
      $$LessonRecordsTableFilterComposer,
      $$LessonRecordsTableOrderingComposer,
      $$LessonRecordsTableAnnotationComposer,
      $$LessonRecordsTableCreateCompanionBuilder,
      $$LessonRecordsTableUpdateCompanionBuilder,
      (LessonRecordRow, $$LessonRecordsTableReferences),
      LessonRecordRow,
      PrefetchHooks Function({bool studentId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$StudentsTableTableManager get students =>
      $$StudentsTableTableManager(_db, _db.students);
  $$CoursePackagesTableTableManager get coursePackages =>
      $$CoursePackagesTableTableManager(_db, _db.coursePackages);
  $$PurchasesTableTableManager get purchases =>
      $$PurchasesTableTableManager(_db, _db.purchases);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db, _db.payments);
  $$LessonRecordsTableTableManager get lessonRecords =>
      $$LessonRecordsTableTableManager(_db, _db.lessonRecords);
}

mixin _$StudentDaoMixin on DatabaseAccessor<AppDatabase> {
  $StudentsTable get students => attachedDatabase.students;
  $CoursePackagesTable get coursePackages => attachedDatabase.coursePackages;
  $PurchasesTable get purchases => attachedDatabase.purchases;
  $PaymentsTable get payments => attachedDatabase.payments;
  $LessonRecordsTable get lessonRecords => attachedDatabase.lessonRecords;
  StudentDaoManager get managers => StudentDaoManager(this);
}

class StudentDaoManager {
  final _$StudentDaoMixin _db;
  StudentDaoManager(this._db);
  $$StudentsTableTableManager get students =>
      $$StudentsTableTableManager(_db.attachedDatabase, _db.students);
  $$CoursePackagesTableTableManager get coursePackages =>
      $$CoursePackagesTableTableManager(
        _db.attachedDatabase,
        _db.coursePackages,
      );
  $$PurchasesTableTableManager get purchases =>
      $$PurchasesTableTableManager(_db.attachedDatabase, _db.purchases);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db.attachedDatabase, _db.payments);
  $$LessonRecordsTableTableManager get lessonRecords =>
      $$LessonRecordsTableTableManager(_db.attachedDatabase, _db.lessonRecords);
}

mixin _$LessonDaoMixin on DatabaseAccessor<AppDatabase> {
  $StudentsTable get students => attachedDatabase.students;
  $LessonRecordsTable get lessonRecords => attachedDatabase.lessonRecords;
  LessonDaoManager get managers => LessonDaoManager(this);
}

class LessonDaoManager {
  final _$LessonDaoMixin _db;
  LessonDaoManager(this._db);
  $$StudentsTableTableManager get students =>
      $$StudentsTableTableManager(_db.attachedDatabase, _db.students);
  $$LessonRecordsTableTableManager get lessonRecords =>
      $$LessonRecordsTableTableManager(_db.attachedDatabase, _db.lessonRecords);
}

mixin _$PurchaseDaoMixin on DatabaseAccessor<AppDatabase> {
  $StudentsTable get students => attachedDatabase.students;
  $CoursePackagesTable get coursePackages => attachedDatabase.coursePackages;
  $PurchasesTable get purchases => attachedDatabase.purchases;
  $PaymentsTable get payments => attachedDatabase.payments;
  PurchaseDaoManager get managers => PurchaseDaoManager(this);
}

class PurchaseDaoManager {
  final _$PurchaseDaoMixin _db;
  PurchaseDaoManager(this._db);
  $$StudentsTableTableManager get students =>
      $$StudentsTableTableManager(_db.attachedDatabase, _db.students);
  $$CoursePackagesTableTableManager get coursePackages =>
      $$CoursePackagesTableTableManager(
        _db.attachedDatabase,
        _db.coursePackages,
      );
  $$PurchasesTableTableManager get purchases =>
      $$PurchasesTableTableManager(_db.attachedDatabase, _db.purchases);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db.attachedDatabase, _db.payments);
}

mixin _$DashboardDaoMixin on DatabaseAccessor<AppDatabase> {
  $StudentsTable get students => attachedDatabase.students;
  $CoursePackagesTable get coursePackages => attachedDatabase.coursePackages;
  $PurchasesTable get purchases => attachedDatabase.purchases;
  $PaymentsTable get payments => attachedDatabase.payments;
  $LessonRecordsTable get lessonRecords => attachedDatabase.lessonRecords;
  DashboardDaoManager get managers => DashboardDaoManager(this);
}

class DashboardDaoManager {
  final _$DashboardDaoMixin _db;
  DashboardDaoManager(this._db);
  $$StudentsTableTableManager get students =>
      $$StudentsTableTableManager(_db.attachedDatabase, _db.students);
  $$CoursePackagesTableTableManager get coursePackages =>
      $$CoursePackagesTableTableManager(
        _db.attachedDatabase,
        _db.coursePackages,
      );
  $$PurchasesTableTableManager get purchases =>
      $$PurchasesTableTableManager(_db.attachedDatabase, _db.purchases);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db.attachedDatabase, _db.payments);
  $$LessonRecordsTableTableManager get lessonRecords =>
      $$LessonRecordsTableTableManager(_db.attachedDatabase, _db.lessonRecords);
}

mixin _$ReportDaoMixin on DatabaseAccessor<AppDatabase> {
  $StudentsTable get students => attachedDatabase.students;
  $CoursePackagesTable get coursePackages => attachedDatabase.coursePackages;
  $PurchasesTable get purchases => attachedDatabase.purchases;
  $PaymentsTable get payments => attachedDatabase.payments;
  $LessonRecordsTable get lessonRecords => attachedDatabase.lessonRecords;
  ReportDaoManager get managers => ReportDaoManager(this);
}

class ReportDaoManager {
  final _$ReportDaoMixin _db;
  ReportDaoManager(this._db);
  $$StudentsTableTableManager get students =>
      $$StudentsTableTableManager(_db.attachedDatabase, _db.students);
  $$CoursePackagesTableTableManager get coursePackages =>
      $$CoursePackagesTableTableManager(
        _db.attachedDatabase,
        _db.coursePackages,
      );
  $$PurchasesTableTableManager get purchases =>
      $$PurchasesTableTableManager(_db.attachedDatabase, _db.purchases);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db.attachedDatabase, _db.payments);
  $$LessonRecordsTableTableManager get lessonRecords =>
      $$LessonRecordsTableTableManager(_db.attachedDatabase, _db.lessonRecords);
}

mixin _$SettingsDaoMixin on DatabaseAccessor<AppDatabase> {
  $CoursePackagesTable get coursePackages => attachedDatabase.coursePackages;
  $StudentsTable get students => attachedDatabase.students;
  $PurchasesTable get purchases => attachedDatabase.purchases;
  SettingsDaoManager get managers => SettingsDaoManager(this);
}

class SettingsDaoManager {
  final _$SettingsDaoMixin _db;
  SettingsDaoManager(this._db);
  $$CoursePackagesTableTableManager get coursePackages =>
      $$CoursePackagesTableTableManager(
        _db.attachedDatabase,
        _db.coursePackages,
      );
  $$StudentsTableTableManager get students =>
      $$StudentsTableTableManager(_db.attachedDatabase, _db.students);
  $$PurchasesTableTableManager get purchases =>
      $$PurchasesTableTableManager(_db.attachedDatabase, _db.purchases);
}
