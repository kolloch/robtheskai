// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'copy_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CopyDirectory {
  Directory get sourceDir => throw _privateConstructorUsedError;
  Directory get destDir => throw _privateConstructorUsedError;
  Glob? get glob => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CopyDirectoryCopyWith<CopyDirectory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CopyDirectoryCopyWith<$Res> {
  factory $CopyDirectoryCopyWith(
          CopyDirectory value, $Res Function(CopyDirectory) then) =
      _$CopyDirectoryCopyWithImpl<$Res, CopyDirectory>;
  @useResult
  $Res call({Directory sourceDir, Directory destDir, Glob? glob});
}

/// @nodoc
class _$CopyDirectoryCopyWithImpl<$Res, $Val extends CopyDirectory>
    implements $CopyDirectoryCopyWith<$Res> {
  _$CopyDirectoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourceDir = null,
    Object? destDir = null,
    Object? glob = freezed,
  }) {
    return _then(_value.copyWith(
      sourceDir: null == sourceDir
          ? _value.sourceDir
          : sourceDir // ignore: cast_nullable_to_non_nullable
              as Directory,
      destDir: null == destDir
          ? _value.destDir
          : destDir // ignore: cast_nullable_to_non_nullable
              as Directory,
      glob: freezed == glob
          ? _value.glob
          : glob // ignore: cast_nullable_to_non_nullable
              as Glob?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CopyDirectoriesCopyWith<$Res>
    implements $CopyDirectoryCopyWith<$Res> {
  factory _$$_CopyDirectoriesCopyWith(
          _$_CopyDirectories value, $Res Function(_$_CopyDirectories) then) =
      __$$_CopyDirectoriesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Directory sourceDir, Directory destDir, Glob? glob});
}

/// @nodoc
class __$$_CopyDirectoriesCopyWithImpl<$Res>
    extends _$CopyDirectoryCopyWithImpl<$Res, _$_CopyDirectories>
    implements _$$_CopyDirectoriesCopyWith<$Res> {
  __$$_CopyDirectoriesCopyWithImpl(
      _$_CopyDirectories _value, $Res Function(_$_CopyDirectories) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourceDir = null,
    Object? destDir = null,
    Object? glob = freezed,
  }) {
    return _then(_$_CopyDirectories(
      sourceDir: null == sourceDir
          ? _value.sourceDir
          : sourceDir // ignore: cast_nullable_to_non_nullable
              as Directory,
      destDir: null == destDir
          ? _value.destDir
          : destDir // ignore: cast_nullable_to_non_nullable
              as Directory,
      glob: freezed == glob
          ? _value.glob
          : glob // ignore: cast_nullable_to_non_nullable
              as Glob?,
    ));
  }
}

/// @nodoc

class _$_CopyDirectories implements _CopyDirectories {
  const _$_CopyDirectories(
      {required this.sourceDir, required this.destDir, this.glob});

  @override
  final Directory sourceDir;
  @override
  final Directory destDir;
  @override
  final Glob? glob;

  @override
  String toString() {
    return 'CopyDirectory(sourceDir: $sourceDir, destDir: $destDir, glob: $glob)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CopyDirectories &&
            (identical(other.sourceDir, sourceDir) ||
                other.sourceDir == sourceDir) &&
            (identical(other.destDir, destDir) || other.destDir == destDir) &&
            (identical(other.glob, glob) || other.glob == glob));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sourceDir, destDir, glob);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CopyDirectoriesCopyWith<_$_CopyDirectories> get copyWith =>
      __$$_CopyDirectoriesCopyWithImpl<_$_CopyDirectories>(this, _$identity);
}

abstract class _CopyDirectories implements CopyDirectory {
  const factory _CopyDirectories(
      {required final Directory sourceDir,
      required final Directory destDir,
      final Glob? glob}) = _$_CopyDirectories;

  @override
  Directory get sourceDir;
  @override
  Directory get destDir;
  @override
  Glob? get glob;
  @override
  @JsonKey(ignore: true)
  _$$_CopyDirectoriesCopyWith<_$_CopyDirectories> get copyWith =>
      throw _privateConstructorUsedError;
}
