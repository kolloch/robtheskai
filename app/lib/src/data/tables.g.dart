// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tables.dart';

// ignore_for_file: type=lint
class $ProjectsTable extends Projects with TableInfo<$ProjectsTable, Project> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumnWithTypeConverter<Id, String> id =
      GeneratedColumn<String>('id', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Id>($ProjectsTable.$converterid);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, description];
  @override
  String get aliasedName => _alias ?? 'projects';
  @override
  String get actualTableName => 'projects';
  @override
  VerificationContext validateIntegrity(Insertable<Project> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    context.handle(_idMeta, const VerificationResult.success());
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Project map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Project(
      id: $ProjectsTable.$converterid.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
    );
  }

  @override
  $ProjectsTable createAlias(String alias) {
    return $ProjectsTable(attachedDatabase, alias);
  }

  static TypeConverter<Id, String> $converterid = const UuidConverter();
}

class Project extends DataClass implements Insertable<Project> {
  final Id id;
  final String name;
  final String description;
  const Project(
      {required this.id, required this.name, required this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      final converter = $ProjectsTable.$converterid;
      map['id'] = Variable<String>(converter.toSql(id));
    }
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    return map;
  }

  ProjectsCompanion toCompanion(bool nullToAbsent) {
    return ProjectsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
    );
  }

  factory Project.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Project(
      id: serializer.fromJson<Id>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<Id>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
    };
  }

  Project copyWith({Id? id, String? name, String? description}) => Project(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('Project(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Project &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description);
}

class ProjectsCompanion extends UpdateCompanion<Project> {
  final Value<Id> id;
  final Value<String> name;
  final Value<String> description;
  final Value<int> rowid;
  const ProjectsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProjectsCompanion.insert({
    required Id id,
    required String name,
    required String description,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        description = Value(description);
  static Insertable<Project> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProjectsCompanion copyWith(
      {Value<Id>? id,
      Value<String>? name,
      Value<String>? description,
      Value<int>? rowid}) {
    return ProjectsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      final converter = $ProjectsTable.$converterid;
      map['id'] = Variable<String>(converter.toSql(id.value));
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
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
    return (StringBuffer('ProjectsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocationsTable extends Locations
    with TableInfo<$LocationsTable, Location> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumnWithTypeConverter<Id, String> id =
      GeneratedColumn<String>('id', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Id>($LocationsTable.$converterid);
  static const VerificationMeta _projectIdMeta =
      const VerificationMeta('projectId');
  @override
  late final GeneratedColumnWithTypeConverter<Id, String> projectId =
      GeneratedColumn<String>('project_id', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: true,
              defaultConstraints: GeneratedColumn.constraintIsAlways(
                  'REFERENCES projects (id)'))
          .withConverter<Id>($LocationsTable.$converterprojectId);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, projectId, name];
  @override
  String get aliasedName => _alias ?? 'locations';
  @override
  String get actualTableName => 'locations';
  @override
  VerificationContext validateIntegrity(Insertable<Location> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    context.handle(_idMeta, const VerificationResult.success());
    context.handle(_projectIdMeta, const VerificationResult.success());
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Location map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Location(
      id: $LocationsTable.$converterid.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!),
      projectId: $LocationsTable.$converterprojectId.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}project_id'])!),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $LocationsTable createAlias(String alias) {
    return $LocationsTable(attachedDatabase, alias);
  }

  static TypeConverter<Id, String> $converterid = const UuidConverter();
  static TypeConverter<Id, String> $converterprojectId = const UuidConverter();
}

class Location extends DataClass implements Insertable<Location> {
  final Id id;
  final Id projectId;
  final String name;
  const Location(
      {required this.id, required this.projectId, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      final converter = $LocationsTable.$converterid;
      map['id'] = Variable<String>(converter.toSql(id));
    }
    {
      final converter = $LocationsTable.$converterprojectId;
      map['project_id'] = Variable<String>(converter.toSql(projectId));
    }
    map['name'] = Variable<String>(name);
    return map;
  }

  LocationsCompanion toCompanion(bool nullToAbsent) {
    return LocationsCompanion(
      id: Value(id),
      projectId: Value(projectId),
      name: Value(name),
    );
  }

  factory Location.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Location(
      id: serializer.fromJson<Id>(json['id']),
      projectId: serializer.fromJson<Id>(json['projectId']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<Id>(id),
      'projectId': serializer.toJson<Id>(projectId),
      'name': serializer.toJson<String>(name),
    };
  }

  Location copyWith({Id? id, Id? projectId, String? name}) => Location(
        id: id ?? this.id,
        projectId: projectId ?? this.projectId,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Location(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, projectId, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Location &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.name == this.name);
}

class LocationsCompanion extends UpdateCompanion<Location> {
  final Value<Id> id;
  final Value<Id> projectId;
  final Value<String> name;
  final Value<int> rowid;
  const LocationsCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocationsCompanion.insert({
    required Id id,
    required Id projectId,
    required String name,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        projectId = Value(projectId),
        name = Value(name);
  static Insertable<Location> custom({
    Expression<String>? id,
    Expression<String>? projectId,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocationsCompanion copyWith(
      {Value<Id>? id,
      Value<Id>? projectId,
      Value<String>? name,
      Value<int>? rowid}) {
    return LocationsCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      final converter = $LocationsTable.$converterid;
      map['id'] = Variable<String>(converter.toSql(id.value));
    }
    if (projectId.present) {
      final converter = $LocationsTable.$converterprojectId;
      map['project_id'] = Variable<String>(converter.toSql(projectId.value));
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationsCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ScenesTable extends Scenes with TableInfo<$ScenesTable, Scene> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScenesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumnWithTypeConverter<Id, String> id =
      GeneratedColumn<String>('id', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Id>($ScenesTable.$converterid);
  static const VerificationMeta _projectIdMeta =
      const VerificationMeta('projectId');
  @override
  late final GeneratedColumnWithTypeConverter<Id, String> projectId =
      GeneratedColumn<String>('project_id', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: true,
              defaultConstraints: GeneratedColumn.constraintIsAlways(
                  'REFERENCES projects (id)'))
          .withConverter<Id>($ScenesTable.$converterprojectId);
  static const VerificationMeta _locationIdMeta =
      const VerificationMeta('locationId');
  @override
  late final GeneratedColumnWithTypeConverter<Id, String> locationId =
      GeneratedColumn<String>('location_id', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: true,
              defaultConstraints: GeneratedColumn.constraintIsAlways(
                  'REFERENCES locations (id)'))
          .withConverter<Id>($ScenesTable.$converterlocationId);
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
      'number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, projectId, locationId, number, name];
  @override
  String get aliasedName => _alias ?? 'scenes';
  @override
  String get actualTableName => 'scenes';
  @override
  VerificationContext validateIntegrity(Insertable<Scene> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    context.handle(_idMeta, const VerificationResult.success());
    context.handle(_projectIdMeta, const VerificationResult.success());
    context.handle(_locationIdMeta, const VerificationResult.success());
    if (data.containsKey('number')) {
      context.handle(_numberMeta,
          number.isAcceptableOrUnknown(data['number']!, _numberMeta));
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Scene map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Scene(
      id: $ScenesTable.$converterid.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!),
      projectId: $ScenesTable.$converterprojectId.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}project_id'])!),
      locationId: $ScenesTable.$converterlocationId.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location_id'])!),
      number: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}number'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $ScenesTable createAlias(String alias) {
    return $ScenesTable(attachedDatabase, alias);
  }

  static TypeConverter<Id, String> $converterid = const UuidConverter();
  static TypeConverter<Id, String> $converterprojectId = const UuidConverter();
  static TypeConverter<Id, String> $converterlocationId = const UuidConverter();
}

class Scene extends DataClass implements Insertable<Scene> {
  final Id id;
  final Id projectId;
  final Id locationId;
  final String number;
  final String name;
  const Scene(
      {required this.id,
      required this.projectId,
      required this.locationId,
      required this.number,
      required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      final converter = $ScenesTable.$converterid;
      map['id'] = Variable<String>(converter.toSql(id));
    }
    {
      final converter = $ScenesTable.$converterprojectId;
      map['project_id'] = Variable<String>(converter.toSql(projectId));
    }
    {
      final converter = $ScenesTable.$converterlocationId;
      map['location_id'] = Variable<String>(converter.toSql(locationId));
    }
    map['number'] = Variable<String>(number);
    map['name'] = Variable<String>(name);
    return map;
  }

  ScenesCompanion toCompanion(bool nullToAbsent) {
    return ScenesCompanion(
      id: Value(id),
      projectId: Value(projectId),
      locationId: Value(locationId),
      number: Value(number),
      name: Value(name),
    );
  }

  factory Scene.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Scene(
      id: serializer.fromJson<Id>(json['id']),
      projectId: serializer.fromJson<Id>(json['projectId']),
      locationId: serializer.fromJson<Id>(json['locationId']),
      number: serializer.fromJson<String>(json['number']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<Id>(id),
      'projectId': serializer.toJson<Id>(projectId),
      'locationId': serializer.toJson<Id>(locationId),
      'number': serializer.toJson<String>(number),
      'name': serializer.toJson<String>(name),
    };
  }

  Scene copyWith(
          {Id? id,
          Id? projectId,
          Id? locationId,
          String? number,
          String? name}) =>
      Scene(
        id: id ?? this.id,
        projectId: projectId ?? this.projectId,
        locationId: locationId ?? this.locationId,
        number: number ?? this.number,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Scene(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('locationId: $locationId, ')
          ..write('number: $number, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, projectId, locationId, number, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Scene &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.locationId == this.locationId &&
          other.number == this.number &&
          other.name == this.name);
}

class ScenesCompanion extends UpdateCompanion<Scene> {
  final Value<Id> id;
  final Value<Id> projectId;
  final Value<Id> locationId;
  final Value<String> number;
  final Value<String> name;
  final Value<int> rowid;
  const ScenesCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.locationId = const Value.absent(),
    this.number = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScenesCompanion.insert({
    required Id id,
    required Id projectId,
    required Id locationId,
    required String number,
    required String name,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        projectId = Value(projectId),
        locationId = Value(locationId),
        number = Value(number),
        name = Value(name);
  static Insertable<Scene> custom({
    Expression<String>? id,
    Expression<String>? projectId,
    Expression<String>? locationId,
    Expression<String>? number,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (locationId != null) 'location_id': locationId,
      if (number != null) 'number': number,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScenesCompanion copyWith(
      {Value<Id>? id,
      Value<Id>? projectId,
      Value<Id>? locationId,
      Value<String>? number,
      Value<String>? name,
      Value<int>? rowid}) {
    return ScenesCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      locationId: locationId ?? this.locationId,
      number: number ?? this.number,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      final converter = $ScenesTable.$converterid;
      map['id'] = Variable<String>(converter.toSql(id.value));
    }
    if (projectId.present) {
      final converter = $ScenesTable.$converterprojectId;
      map['project_id'] = Variable<String>(converter.toSql(projectId.value));
    }
    if (locationId.present) {
      final converter = $ScenesTable.$converterlocationId;
      map['location_id'] = Variable<String>(converter.toSql(locationId.value));
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScenesCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('locationId: $locationId, ')
          ..write('number: $number, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShotsTable extends Shots with TableInfo<$ShotsTable, Shot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumnWithTypeConverter<Id, String> id =
      GeneratedColumn<String>('id', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Id>($ShotsTable.$converterid);
  static const VerificationMeta _sceneIdMeta =
      const VerificationMeta('sceneId');
  @override
  late final GeneratedColumnWithTypeConverter<Id, String> sceneId =
      GeneratedColumn<String>('scene_id', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: true,
              defaultConstraints:
                  GeneratedColumn.constraintIsAlways('REFERENCES scenes (id)'))
          .withConverter<Id>($ShotsTable.$convertersceneId);
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
      'number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, sceneId, number, name];
  @override
  String get aliasedName => _alias ?? 'shots';
  @override
  String get actualTableName => 'shots';
  @override
  VerificationContext validateIntegrity(Insertable<Shot> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    context.handle(_idMeta, const VerificationResult.success());
    context.handle(_sceneIdMeta, const VerificationResult.success());
    if (data.containsKey('number')) {
      context.handle(_numberMeta,
          number.isAcceptableOrUnknown(data['number']!, _numberMeta));
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Shot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Shot(
      id: $ShotsTable.$converterid.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!),
      sceneId: $ShotsTable.$convertersceneId.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}scene_id'])!),
      number: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}number'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $ShotsTable createAlias(String alias) {
    return $ShotsTable(attachedDatabase, alias);
  }

  static TypeConverter<Id, String> $converterid = const UuidConverter();
  static TypeConverter<Id, String> $convertersceneId = const UuidConverter();
}

class Shot extends DataClass implements Insertable<Shot> {
  final Id id;
  final Id sceneId;
  final int number;
  final String name;
  const Shot(
      {required this.id,
      required this.sceneId,
      required this.number,
      required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      final converter = $ShotsTable.$converterid;
      map['id'] = Variable<String>(converter.toSql(id));
    }
    {
      final converter = $ShotsTable.$convertersceneId;
      map['scene_id'] = Variable<String>(converter.toSql(sceneId));
    }
    map['number'] = Variable<int>(number);
    map['name'] = Variable<String>(name);
    return map;
  }

  ShotsCompanion toCompanion(bool nullToAbsent) {
    return ShotsCompanion(
      id: Value(id),
      sceneId: Value(sceneId),
      number: Value(number),
      name: Value(name),
    );
  }

  factory Shot.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Shot(
      id: serializer.fromJson<Id>(json['id']),
      sceneId: serializer.fromJson<Id>(json['sceneId']),
      number: serializer.fromJson<int>(json['number']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<Id>(id),
      'sceneId': serializer.toJson<Id>(sceneId),
      'number': serializer.toJson<int>(number),
      'name': serializer.toJson<String>(name),
    };
  }

  Shot copyWith({Id? id, Id? sceneId, int? number, String? name}) => Shot(
        id: id ?? this.id,
        sceneId: sceneId ?? this.sceneId,
        number: number ?? this.number,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Shot(')
          ..write('id: $id, ')
          ..write('sceneId: $sceneId, ')
          ..write('number: $number, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sceneId, number, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Shot &&
          other.id == this.id &&
          other.sceneId == this.sceneId &&
          other.number == this.number &&
          other.name == this.name);
}

class ShotsCompanion extends UpdateCompanion<Shot> {
  final Value<Id> id;
  final Value<Id> sceneId;
  final Value<int> number;
  final Value<String> name;
  final Value<int> rowid;
  const ShotsCompanion({
    this.id = const Value.absent(),
    this.sceneId = const Value.absent(),
    this.number = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShotsCompanion.insert({
    required Id id,
    required Id sceneId,
    required int number,
    required String name,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        sceneId = Value(sceneId),
        number = Value(number),
        name = Value(name);
  static Insertable<Shot> custom({
    Expression<String>? id,
    Expression<String>? sceneId,
    Expression<int>? number,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sceneId != null) 'scene_id': sceneId,
      if (number != null) 'number': number,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShotsCompanion copyWith(
      {Value<Id>? id,
      Value<Id>? sceneId,
      Value<int>? number,
      Value<String>? name,
      Value<int>? rowid}) {
    return ShotsCompanion(
      id: id ?? this.id,
      sceneId: sceneId ?? this.sceneId,
      number: number ?? this.number,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      final converter = $ShotsTable.$converterid;
      map['id'] = Variable<String>(converter.toSql(id.value));
    }
    if (sceneId.present) {
      final converter = $ShotsTable.$convertersceneId;
      map['scene_id'] = Variable<String>(converter.toSql(sceneId.value));
    }
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShotsCompanion(')
          ..write('id: $id, ')
          ..write('sceneId: $sceneId, ')
          ..write('number: $number, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$SkaiDb extends GeneratedDatabase {
  _$SkaiDb(QueryExecutor e) : super(e);
  late final $ProjectsTable projects = $ProjectsTable(this);
  late final $LocationsTable locations = $LocationsTable(this);
  late final $ScenesTable scenes = $ScenesTable(this);
  late final $ShotsTable shots = $ShotsTable(this);
  late final ProjectsDao projectsDao = ProjectsDao(this as SkaiDb);
  late final LocationsDao locationsDao = LocationsDao(this as SkaiDb);
  late final ScenesDao scenesDao = ScenesDao(this as SkaiDb);
  late final ShotsDao shotsDao = ShotsDao(this as SkaiDb);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [projects, locations, scenes, shots];
}
