// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mutations.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UpdateValue<T> {
  T get value => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T value) delete,
    required TResult Function(T value) set,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T value)? delete,
    TResult? Function(T value)? set,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T value)? delete,
    TResult Function(T value)? set,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Delete<T> value) delete,
    required TResult Function(Set<T> value) set,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Delete<T> value)? delete,
    TResult? Function(Set<T> value)? set,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Delete<T> value)? delete,
    TResult Function(Set<T> value)? set,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UpdateValueCopyWith<T, UpdateValue<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateValueCopyWith<T, $Res> {
  factory $UpdateValueCopyWith(
          UpdateValue<T> value, $Res Function(UpdateValue<T>) then) =
      _$UpdateValueCopyWithImpl<T, $Res, UpdateValue<T>>;
  @useResult
  $Res call({T value});
}

/// @nodoc
class _$UpdateValueCopyWithImpl<T, $Res, $Val extends UpdateValue<T>>
    implements $UpdateValueCopyWith<T, $Res> {
  _$UpdateValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeleteCopyWith<T, $Res>
    implements $UpdateValueCopyWith<T, $Res> {
  factory _$$DeleteCopyWith(
          _$Delete<T> value, $Res Function(_$Delete<T>) then) =
      __$$DeleteCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({T value});
}

/// @nodoc
class __$$DeleteCopyWithImpl<T, $Res>
    extends _$UpdateValueCopyWithImpl<T, $Res, _$Delete<T>>
    implements _$$DeleteCopyWith<T, $Res> {
  __$$DeleteCopyWithImpl(_$Delete<T> _value, $Res Function(_$Delete<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_$Delete<T>(
      freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$Delete<T> extends Delete<T> {
  _$Delete(this.value) : super._();

  @override
  final T value;

  @override
  String toString() {
    return 'UpdateValue<$T>.delete(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Delete<T> &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteCopyWith<T, _$Delete<T>> get copyWith =>
      __$$DeleteCopyWithImpl<T, _$Delete<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T value) delete,
    required TResult Function(T value) set,
  }) {
    return delete(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T value)? delete,
    TResult? Function(T value)? set,
  }) {
    return delete?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T value)? delete,
    TResult Function(T value)? set,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Delete<T> value) delete,
    required TResult Function(Set<T> value) set,
  }) {
    return delete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Delete<T> value)? delete,
    TResult? Function(Set<T> value)? set,
  }) {
    return delete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Delete<T> value)? delete,
    TResult Function(Set<T> value)? set,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(this);
    }
    return orElse();
  }
}

abstract class Delete<T> extends UpdateValue<T> {
  factory Delete(final T value) = _$Delete<T>;
  Delete._() : super._();

  @override
  T get value;
  @override
  @JsonKey(ignore: true)
  _$$DeleteCopyWith<T, _$Delete<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetCopyWith<T, $Res>
    implements $UpdateValueCopyWith<T, $Res> {
  factory _$$SetCopyWith(_$Set<T> value, $Res Function(_$Set<T>) then) =
      __$$SetCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({T value});
}

/// @nodoc
class __$$SetCopyWithImpl<T, $Res>
    extends _$UpdateValueCopyWithImpl<T, $Res, _$Set<T>>
    implements _$$SetCopyWith<T, $Res> {
  __$$SetCopyWithImpl(_$Set<T> _value, $Res Function(_$Set<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_$Set<T>(
      freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$Set<T> extends Set<T> {
  _$Set(this.value) : super._();

  @override
  final T value;

  @override
  String toString() {
    return 'UpdateValue<$T>.set(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Set<T> &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SetCopyWith<T, _$Set<T>> get copyWith =>
      __$$SetCopyWithImpl<T, _$Set<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T value) delete,
    required TResult Function(T value) set,
  }) {
    return set(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T value)? delete,
    TResult? Function(T value)? set,
  }) {
    return set?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T value)? delete,
    TResult Function(T value)? set,
    required TResult orElse(),
  }) {
    if (set != null) {
      return set(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Delete<T> value) delete,
    required TResult Function(Set<T> value) set,
  }) {
    return set(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Delete<T> value)? delete,
    TResult? Function(Set<T> value)? set,
  }) {
    return set?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Delete<T> value)? delete,
    TResult Function(Set<T> value)? set,
    required TResult orElse(),
  }) {
    if (set != null) {
      return set(this);
    }
    return orElse();
  }
}

abstract class Set<T> extends UpdateValue<T> {
  factory Set(final T value) = _$Set<T>;
  Set._() : super._();

  @override
  T get value;
  @override
  @JsonKey(ignore: true)
  _$$SetCopyWith<T, _$Set<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UpdateField<T> {
  String get name => throw _privateConstructorUsedError;
  UpdateValue<T> get value => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UpdateFieldCopyWith<T, UpdateField<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateFieldCopyWith<T, $Res> {
  factory $UpdateFieldCopyWith(
          UpdateField<T> value, $Res Function(UpdateField<T>) then) =
      _$UpdateFieldCopyWithImpl<T, $Res, UpdateField<T>>;
  @useResult
  $Res call({String name, UpdateValue<T> value});

  $UpdateValueCopyWith<T, $Res> get value;
}

/// @nodoc
class _$UpdateFieldCopyWithImpl<T, $Res, $Val extends UpdateField<T>>
    implements $UpdateFieldCopyWith<T, $Res> {
  _$UpdateFieldCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as UpdateValue<T>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UpdateValueCopyWith<T, $Res> get value {
    return $UpdateValueCopyWith<T, $Res>(_value.value, (value) {
      return _then(_value.copyWith(value: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UpdateFieldCopyWith<T, $Res>
    implements $UpdateFieldCopyWith<T, $Res> {
  factory _$$_UpdateFieldCopyWith(
          _$_UpdateField<T> value, $Res Function(_$_UpdateField<T>) then) =
      __$$_UpdateFieldCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({String name, UpdateValue<T> value});

  @override
  $UpdateValueCopyWith<T, $Res> get value;
}

/// @nodoc
class __$$_UpdateFieldCopyWithImpl<T, $Res>
    extends _$UpdateFieldCopyWithImpl<T, $Res, _$_UpdateField<T>>
    implements _$$_UpdateFieldCopyWith<T, $Res> {
  __$$_UpdateFieldCopyWithImpl(
      _$_UpdateField<T> _value, $Res Function(_$_UpdateField<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? value = null,
  }) {
    return _then(_$_UpdateField<T>(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as UpdateValue<T>,
    ));
  }
}

/// @nodoc

class _$_UpdateField<T> implements _UpdateField<T> {
  _$_UpdateField({required this.name, required this.value});

  @override
  final String name;
  @override
  final UpdateValue<T> value;

  @override
  String toString() {
    return 'UpdateField<$T>(name: $name, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UpdateField<T> &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UpdateFieldCopyWith<T, _$_UpdateField<T>> get copyWith =>
      __$$_UpdateFieldCopyWithImpl<T, _$_UpdateField<T>>(this, _$identity);
}

abstract class _UpdateField<T> implements UpdateField<T> {
  factory _UpdateField(
      {required final String name,
      required final UpdateValue<T> value}) = _$_UpdateField<T>;

  @override
  String get name;
  @override
  UpdateValue<T> get value;
  @override
  @JsonKey(ignore: true)
  _$$_UpdateFieldCopyWith<T, _$_UpdateField<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UpdateCommand {
  String get table => throw _privateConstructorUsedError;
  List<Id> get ids => throw _privateConstructorUsedError;
  List<UpdateField> get fields => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UpdateCommandCopyWith<UpdateCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateCommandCopyWith<$Res> {
  factory $UpdateCommandCopyWith(
          UpdateCommand value, $Res Function(UpdateCommand) then) =
      _$UpdateCommandCopyWithImpl<$Res, UpdateCommand>;
  @useResult
  $Res call({String table, List<Id> ids, List<UpdateField> fields});
}

/// @nodoc
class _$UpdateCommandCopyWithImpl<$Res, $Val extends UpdateCommand>
    implements $UpdateCommandCopyWith<$Res> {
  _$UpdateCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? table = null,
    Object? ids = null,
    Object? fields = null,
  }) {
    return _then(_value.copyWith(
      table: null == table
          ? _value.table
          : table // ignore: cast_nullable_to_non_nullable
              as String,
      ids: null == ids
          ? _value.ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<Id>,
      fields: null == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<UpdateField>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UpdateCommandCopyWith<$Res>
    implements $UpdateCommandCopyWith<$Res> {
  factory _$$_UpdateCommandCopyWith(
          _$_UpdateCommand value, $Res Function(_$_UpdateCommand) then) =
      __$$_UpdateCommandCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String table, List<Id> ids, List<UpdateField> fields});
}

/// @nodoc
class __$$_UpdateCommandCopyWithImpl<$Res>
    extends _$UpdateCommandCopyWithImpl<$Res, _$_UpdateCommand>
    implements _$$_UpdateCommandCopyWith<$Res> {
  __$$_UpdateCommandCopyWithImpl(
      _$_UpdateCommand _value, $Res Function(_$_UpdateCommand) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? table = null,
    Object? ids = null,
    Object? fields = null,
  }) {
    return _then(_$_UpdateCommand(
      table: null == table
          ? _value.table
          : table // ignore: cast_nullable_to_non_nullable
              as String,
      ids: null == ids
          ? _value._ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<Id>,
      fields: null == fields
          ? _value._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<UpdateField>,
    ));
  }
}

/// @nodoc

class _$_UpdateCommand implements _UpdateCommand {
  _$_UpdateCommand(
      {required this.table,
      required final List<Id> ids,
      required final List<UpdateField> fields})
      : _ids = ids,
        _fields = fields;

  @override
  final String table;
  final List<Id> _ids;
  @override
  List<Id> get ids {
    if (_ids is EqualUnmodifiableListView) return _ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ids);
  }

  final List<UpdateField> _fields;
  @override
  List<UpdateField> get fields {
    if (_fields is EqualUnmodifiableListView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fields);
  }

  @override
  String toString() {
    return 'UpdateCommand(table: $table, ids: $ids, fields: $fields)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UpdateCommand &&
            (identical(other.table, table) || other.table == table) &&
            const DeepCollectionEquality().equals(other._ids, _ids) &&
            const DeepCollectionEquality().equals(other._fields, _fields));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      table,
      const DeepCollectionEquality().hash(_ids),
      const DeepCollectionEquality().hash(_fields));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UpdateCommandCopyWith<_$_UpdateCommand> get copyWith =>
      __$$_UpdateCommandCopyWithImpl<_$_UpdateCommand>(this, _$identity);
}

abstract class _UpdateCommand implements UpdateCommand {
  factory _UpdateCommand(
      {required final String table,
      required final List<Id> ids,
      required final List<UpdateField> fields}) = _$_UpdateCommand;

  @override
  String get table;
  @override
  List<Id> get ids;
  @override
  List<UpdateField> get fields;
  @override
  @JsonKey(ignore: true)
  _$$_UpdateCommandCopyWith<_$_UpdateCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$InsertField<T> {
  String get name => throw _privateConstructorUsedError;
  T get value => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InsertFieldCopyWith<T, InsertField<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InsertFieldCopyWith<T, $Res> {
  factory $InsertFieldCopyWith(
          InsertField<T> value, $Res Function(InsertField<T>) then) =
      _$InsertFieldCopyWithImpl<T, $Res, InsertField<T>>;
  @useResult
  $Res call({String name, T value});
}

/// @nodoc
class _$InsertFieldCopyWithImpl<T, $Res, $Val extends InsertField<T>>
    implements $InsertFieldCopyWith<T, $Res> {
  _$InsertFieldCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InsertFieldCopyWith<T, $Res>
    implements $InsertFieldCopyWith<T, $Res> {
  factory _$$_InsertFieldCopyWith(
          _$_InsertField<T> value, $Res Function(_$_InsertField<T>) then) =
      __$$_InsertFieldCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({String name, T value});
}

/// @nodoc
class __$$_InsertFieldCopyWithImpl<T, $Res>
    extends _$InsertFieldCopyWithImpl<T, $Res, _$_InsertField<T>>
    implements _$$_InsertFieldCopyWith<T, $Res> {
  __$$_InsertFieldCopyWithImpl(
      _$_InsertField<T> _value, $Res Function(_$_InsertField<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? value = freezed,
  }) {
    return _then(_$_InsertField<T>(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$_InsertField<T> implements _InsertField<T> {
  _$_InsertField({required this.name, required this.value});

  @override
  final String name;
  @override
  final T value;

  @override
  String toString() {
    return 'InsertField<$T>(name: $name, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InsertField<T> &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InsertFieldCopyWith<T, _$_InsertField<T>> get copyWith =>
      __$$_InsertFieldCopyWithImpl<T, _$_InsertField<T>>(this, _$identity);
}

abstract class _InsertField<T> implements InsertField<T> {
  factory _InsertField({required final String name, required final T value}) =
      _$_InsertField<T>;

  @override
  String get name;
  @override
  T get value;
  @override
  @JsonKey(ignore: true)
  _$$_InsertFieldCopyWith<T, _$_InsertField<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$InsertCommand {
  String get table => throw _privateConstructorUsedError;
  List<InsertField> get fields => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InsertCommandCopyWith<InsertCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InsertCommandCopyWith<$Res> {
  factory $InsertCommandCopyWith(
          InsertCommand value, $Res Function(InsertCommand) then) =
      _$InsertCommandCopyWithImpl<$Res, InsertCommand>;
  @useResult
  $Res call({String table, List<InsertField> fields});
}

/// @nodoc
class _$InsertCommandCopyWithImpl<$Res, $Val extends InsertCommand>
    implements $InsertCommandCopyWith<$Res> {
  _$InsertCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? table = null,
    Object? fields = null,
  }) {
    return _then(_value.copyWith(
      table: null == table
          ? _value.table
          : table // ignore: cast_nullable_to_non_nullable
              as String,
      fields: null == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<InsertField>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InsertCommandCopyWith<$Res>
    implements $InsertCommandCopyWith<$Res> {
  factory _$$_InsertCommandCopyWith(
          _$_InsertCommand value, $Res Function(_$_InsertCommand) then) =
      __$$_InsertCommandCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String table, List<InsertField> fields});
}

/// @nodoc
class __$$_InsertCommandCopyWithImpl<$Res>
    extends _$InsertCommandCopyWithImpl<$Res, _$_InsertCommand>
    implements _$$_InsertCommandCopyWith<$Res> {
  __$$_InsertCommandCopyWithImpl(
      _$_InsertCommand _value, $Res Function(_$_InsertCommand) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? table = null,
    Object? fields = null,
  }) {
    return _then(_$_InsertCommand(
      table: null == table
          ? _value.table
          : table // ignore: cast_nullable_to_non_nullable
              as String,
      fields: null == fields
          ? _value._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<InsertField>,
    ));
  }
}

/// @nodoc

class _$_InsertCommand implements _InsertCommand {
  _$_InsertCommand(
      {required this.table, required final List<InsertField> fields})
      : _fields = fields;

  @override
  final String table;
  final List<InsertField> _fields;
  @override
  List<InsertField> get fields {
    if (_fields is EqualUnmodifiableListView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fields);
  }

  @override
  String toString() {
    return 'InsertCommand(table: $table, fields: $fields)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InsertCommand &&
            (identical(other.table, table) || other.table == table) &&
            const DeepCollectionEquality().equals(other._fields, _fields));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, table, const DeepCollectionEquality().hash(_fields));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InsertCommandCopyWith<_$_InsertCommand> get copyWith =>
      __$$_InsertCommandCopyWithImpl<_$_InsertCommand>(this, _$identity);
}

abstract class _InsertCommand implements InsertCommand {
  factory _InsertCommand(
      {required final String table,
      required final List<InsertField> fields}) = _$_InsertCommand;

  @override
  String get table;
  @override
  List<InsertField> get fields;
  @override
  @JsonKey(ignore: true)
  _$$_InsertCommandCopyWith<_$_InsertCommand> get copyWith =>
      throw _privateConstructorUsedError;
}
