// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'copy_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CopyEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() copyStarted,
    required TResult Function(int numberOfFiles) scanningFiles,
    required TResult Function(
            int totalBytes, int bytesCopied, int totalFiles, int filesCopied)
        copyProgress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? copyStarted,
    TResult? Function(int numberOfFiles)? scanningFiles,
    TResult? Function(
            int totalBytes, int bytesCopied, int totalFiles, int filesCopied)?
        copyProgress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? copyStarted,
    TResult Function(int numberOfFiles)? scanningFiles,
    TResult Function(
            int totalBytes, int bytesCopied, int totalFiles, int filesCopied)?
        copyProgress,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CopyStarted value) copyStarted,
    required TResult Function(ScanningFiles value) scanningFiles,
    required TResult Function(CopyProgress value) copyProgress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CopyStarted value)? copyStarted,
    TResult? Function(ScanningFiles value)? scanningFiles,
    TResult? Function(CopyProgress value)? copyProgress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CopyStarted value)? copyStarted,
    TResult Function(ScanningFiles value)? scanningFiles,
    TResult Function(CopyProgress value)? copyProgress,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CopyEventCopyWith<$Res> {
  factory $CopyEventCopyWith(CopyEvent value, $Res Function(CopyEvent) then) =
      _$CopyEventCopyWithImpl<$Res, CopyEvent>;
}

/// @nodoc
class _$CopyEventCopyWithImpl<$Res, $Val extends CopyEvent>
    implements $CopyEventCopyWith<$Res> {
  _$CopyEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$CopyStartedCopyWith<$Res> {
  factory _$$CopyStartedCopyWith(
          _$CopyStarted value, $Res Function(_$CopyStarted) then) =
      __$$CopyStartedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CopyStartedCopyWithImpl<$Res>
    extends _$CopyEventCopyWithImpl<$Res, _$CopyStarted>
    implements _$$CopyStartedCopyWith<$Res> {
  __$$CopyStartedCopyWithImpl(
      _$CopyStarted _value, $Res Function(_$CopyStarted) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CopyStarted extends CopyStarted {
  const _$CopyStarted() : super._();

  @override
  String toString() {
    return 'CopyEvent.copyStarted()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CopyStarted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() copyStarted,
    required TResult Function(int numberOfFiles) scanningFiles,
    required TResult Function(
            int totalBytes, int bytesCopied, int totalFiles, int filesCopied)
        copyProgress,
  }) {
    return copyStarted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? copyStarted,
    TResult? Function(int numberOfFiles)? scanningFiles,
    TResult? Function(
            int totalBytes, int bytesCopied, int totalFiles, int filesCopied)?
        copyProgress,
  }) {
    return copyStarted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? copyStarted,
    TResult Function(int numberOfFiles)? scanningFiles,
    TResult Function(
            int totalBytes, int bytesCopied, int totalFiles, int filesCopied)?
        copyProgress,
    required TResult orElse(),
  }) {
    if (copyStarted != null) {
      return copyStarted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CopyStarted value) copyStarted,
    required TResult Function(ScanningFiles value) scanningFiles,
    required TResult Function(CopyProgress value) copyProgress,
  }) {
    return copyStarted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CopyStarted value)? copyStarted,
    TResult? Function(ScanningFiles value)? scanningFiles,
    TResult? Function(CopyProgress value)? copyProgress,
  }) {
    return copyStarted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CopyStarted value)? copyStarted,
    TResult Function(ScanningFiles value)? scanningFiles,
    TResult Function(CopyProgress value)? copyProgress,
    required TResult orElse(),
  }) {
    if (copyStarted != null) {
      return copyStarted(this);
    }
    return orElse();
  }
}

abstract class CopyStarted extends CopyEvent {
  const factory CopyStarted() = _$CopyStarted;
  const CopyStarted._() : super._();
}

/// @nodoc
abstract class _$$ScanningFilesCopyWith<$Res> {
  factory _$$ScanningFilesCopyWith(
          _$ScanningFiles value, $Res Function(_$ScanningFiles) then) =
      __$$ScanningFilesCopyWithImpl<$Res>;
  @useResult
  $Res call({int numberOfFiles});
}

/// @nodoc
class __$$ScanningFilesCopyWithImpl<$Res>
    extends _$CopyEventCopyWithImpl<$Res, _$ScanningFiles>
    implements _$$ScanningFilesCopyWith<$Res> {
  __$$ScanningFilesCopyWithImpl(
      _$ScanningFiles _value, $Res Function(_$ScanningFiles) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? numberOfFiles = null,
  }) {
    return _then(_$ScanningFiles(
      numberOfFiles: null == numberOfFiles
          ? _value.numberOfFiles
          : numberOfFiles // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ScanningFiles extends ScanningFiles {
  const _$ScanningFiles({required this.numberOfFiles}) : super._();

  @override
  final int numberOfFiles;

  @override
  String toString() {
    return 'CopyEvent.scanningFiles(numberOfFiles: $numberOfFiles)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScanningFiles &&
            (identical(other.numberOfFiles, numberOfFiles) ||
                other.numberOfFiles == numberOfFiles));
  }

  @override
  int get hashCode => Object.hash(runtimeType, numberOfFiles);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScanningFilesCopyWith<_$ScanningFiles> get copyWith =>
      __$$ScanningFilesCopyWithImpl<_$ScanningFiles>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() copyStarted,
    required TResult Function(int numberOfFiles) scanningFiles,
    required TResult Function(
            int totalBytes, int bytesCopied, int totalFiles, int filesCopied)
        copyProgress,
  }) {
    return scanningFiles(numberOfFiles);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? copyStarted,
    TResult? Function(int numberOfFiles)? scanningFiles,
    TResult? Function(
            int totalBytes, int bytesCopied, int totalFiles, int filesCopied)?
        copyProgress,
  }) {
    return scanningFiles?.call(numberOfFiles);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? copyStarted,
    TResult Function(int numberOfFiles)? scanningFiles,
    TResult Function(
            int totalBytes, int bytesCopied, int totalFiles, int filesCopied)?
        copyProgress,
    required TResult orElse(),
  }) {
    if (scanningFiles != null) {
      return scanningFiles(numberOfFiles);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CopyStarted value) copyStarted,
    required TResult Function(ScanningFiles value) scanningFiles,
    required TResult Function(CopyProgress value) copyProgress,
  }) {
    return scanningFiles(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CopyStarted value)? copyStarted,
    TResult? Function(ScanningFiles value)? scanningFiles,
    TResult? Function(CopyProgress value)? copyProgress,
  }) {
    return scanningFiles?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CopyStarted value)? copyStarted,
    TResult Function(ScanningFiles value)? scanningFiles,
    TResult Function(CopyProgress value)? copyProgress,
    required TResult orElse(),
  }) {
    if (scanningFiles != null) {
      return scanningFiles(this);
    }
    return orElse();
  }
}

abstract class ScanningFiles extends CopyEvent {
  const factory ScanningFiles({required final int numberOfFiles}) =
      _$ScanningFiles;
  const ScanningFiles._() : super._();

  int get numberOfFiles;
  @JsonKey(ignore: true)
  _$$ScanningFilesCopyWith<_$ScanningFiles> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CopyProgressCopyWith<$Res> {
  factory _$$CopyProgressCopyWith(
          _$CopyProgress value, $Res Function(_$CopyProgress) then) =
      __$$CopyProgressCopyWithImpl<$Res>;
  @useResult
  $Res call({int totalBytes, int bytesCopied, int totalFiles, int filesCopied});
}

/// @nodoc
class __$$CopyProgressCopyWithImpl<$Res>
    extends _$CopyEventCopyWithImpl<$Res, _$CopyProgress>
    implements _$$CopyProgressCopyWith<$Res> {
  __$$CopyProgressCopyWithImpl(
      _$CopyProgress _value, $Res Function(_$CopyProgress) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalBytes = null,
    Object? bytesCopied = null,
    Object? totalFiles = null,
    Object? filesCopied = null,
  }) {
    return _then(_$CopyProgress(
      totalBytes: null == totalBytes
          ? _value.totalBytes
          : totalBytes // ignore: cast_nullable_to_non_nullable
              as int,
      bytesCopied: null == bytesCopied
          ? _value.bytesCopied
          : bytesCopied // ignore: cast_nullable_to_non_nullable
              as int,
      totalFiles: null == totalFiles
          ? _value.totalFiles
          : totalFiles // ignore: cast_nullable_to_non_nullable
              as int,
      filesCopied: null == filesCopied
          ? _value.filesCopied
          : filesCopied // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$CopyProgress extends CopyProgress {
  const _$CopyProgress(
      {required this.totalBytes,
      required this.bytesCopied,
      required this.totalFiles,
      required this.filesCopied})
      : super._();

  @override
  final int totalBytes;
  @override
  final int bytesCopied;
  @override
  final int totalFiles;
  @override
  final int filesCopied;

  @override
  String toString() {
    return 'CopyEvent.copyProgress(totalBytes: $totalBytes, bytesCopied: $bytesCopied, totalFiles: $totalFiles, filesCopied: $filesCopied)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CopyProgress &&
            (identical(other.totalBytes, totalBytes) ||
                other.totalBytes == totalBytes) &&
            (identical(other.bytesCopied, bytesCopied) ||
                other.bytesCopied == bytesCopied) &&
            (identical(other.totalFiles, totalFiles) ||
                other.totalFiles == totalFiles) &&
            (identical(other.filesCopied, filesCopied) ||
                other.filesCopied == filesCopied));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, totalBytes, bytesCopied, totalFiles, filesCopied);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CopyProgressCopyWith<_$CopyProgress> get copyWith =>
      __$$CopyProgressCopyWithImpl<_$CopyProgress>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() copyStarted,
    required TResult Function(int numberOfFiles) scanningFiles,
    required TResult Function(
            int totalBytes, int bytesCopied, int totalFiles, int filesCopied)
        copyProgress,
  }) {
    return copyProgress(totalBytes, bytesCopied, totalFiles, filesCopied);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? copyStarted,
    TResult? Function(int numberOfFiles)? scanningFiles,
    TResult? Function(
            int totalBytes, int bytesCopied, int totalFiles, int filesCopied)?
        copyProgress,
  }) {
    return copyProgress?.call(totalBytes, bytesCopied, totalFiles, filesCopied);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? copyStarted,
    TResult Function(int numberOfFiles)? scanningFiles,
    TResult Function(
            int totalBytes, int bytesCopied, int totalFiles, int filesCopied)?
        copyProgress,
    required TResult orElse(),
  }) {
    if (copyProgress != null) {
      return copyProgress(totalBytes, bytesCopied, totalFiles, filesCopied);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CopyStarted value) copyStarted,
    required TResult Function(ScanningFiles value) scanningFiles,
    required TResult Function(CopyProgress value) copyProgress,
  }) {
    return copyProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CopyStarted value)? copyStarted,
    TResult? Function(ScanningFiles value)? scanningFiles,
    TResult? Function(CopyProgress value)? copyProgress,
  }) {
    return copyProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CopyStarted value)? copyStarted,
    TResult Function(ScanningFiles value)? scanningFiles,
    TResult Function(CopyProgress value)? copyProgress,
    required TResult orElse(),
  }) {
    if (copyProgress != null) {
      return copyProgress(this);
    }
    return orElse();
  }
}

abstract class CopyProgress extends CopyEvent {
  const factory CopyProgress(
      {required final int totalBytes,
      required final int bytesCopied,
      required final int totalFiles,
      required final int filesCopied}) = _$CopyProgress;
  const CopyProgress._() : super._();

  int get totalBytes;
  int get bytesCopied;
  int get totalFiles;
  int get filesCopied;
  @JsonKey(ignore: true)
  _$$CopyProgressCopyWith<_$CopyProgress> get copyWith =>
      throw _privateConstructorUsedError;
}
