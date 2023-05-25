// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model.dart';

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
    required TResult Function(CopyProgress lastEvent) copyCancelled,
    required TResult Function(int numberOfFiles) scanningFiles,
    required TResult Function(
            int totalBytes, int bytesCopied, int totalFiles, int filesCopied)
        copyProgress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? copyStarted,
    TResult? Function(CopyProgress lastEvent)? copyCancelled,
    TResult? Function(int numberOfFiles)? scanningFiles,
    TResult? Function(
            int totalBytes, int bytesCopied, int totalFiles, int filesCopied)?
        copyProgress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? copyStarted,
    TResult Function(CopyProgress lastEvent)? copyCancelled,
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
    required TResult Function(CopyCancelled value) copyCancelled,
    required TResult Function(ScanningFiles value) scanningFiles,
    required TResult Function(CopyProgress value) copyProgress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CopyStarted value)? copyStarted,
    TResult? Function(CopyCancelled value)? copyCancelled,
    TResult? Function(ScanningFiles value)? scanningFiles,
    TResult? Function(CopyProgress value)? copyProgress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CopyStarted value)? copyStarted,
    TResult Function(CopyCancelled value)? copyCancelled,
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
    required TResult Function(CopyProgress lastEvent) copyCancelled,
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
    TResult? Function(CopyProgress lastEvent)? copyCancelled,
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
    TResult Function(CopyProgress lastEvent)? copyCancelled,
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
    required TResult Function(CopyCancelled value) copyCancelled,
    required TResult Function(ScanningFiles value) scanningFiles,
    required TResult Function(CopyProgress value) copyProgress,
  }) {
    return copyStarted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CopyStarted value)? copyStarted,
    TResult? Function(CopyCancelled value)? copyCancelled,
    TResult? Function(ScanningFiles value)? scanningFiles,
    TResult? Function(CopyProgress value)? copyProgress,
  }) {
    return copyStarted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CopyStarted value)? copyStarted,
    TResult Function(CopyCancelled value)? copyCancelled,
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
abstract class _$$CopyCancelledCopyWith<$Res> {
  factory _$$CopyCancelledCopyWith(
          _$CopyCancelled value, $Res Function(_$CopyCancelled) then) =
      __$$CopyCancelledCopyWithImpl<$Res>;
  @useResult
  $Res call({CopyProgress lastEvent});
}

/// @nodoc
class __$$CopyCancelledCopyWithImpl<$Res>
    extends _$CopyEventCopyWithImpl<$Res, _$CopyCancelled>
    implements _$$CopyCancelledCopyWith<$Res> {
  __$$CopyCancelledCopyWithImpl(
      _$CopyCancelled _value, $Res Function(_$CopyCancelled) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastEvent = null,
  }) {
    return _then(_$CopyCancelled(
      null == lastEvent
          ? _value.lastEvent
          : lastEvent // ignore: cast_nullable_to_non_nullable
              as CopyProgress,
    ));
  }
}

/// @nodoc

class _$CopyCancelled extends CopyCancelled {
  const _$CopyCancelled(this.lastEvent) : super._();

  @override
  final CopyProgress lastEvent;

  @override
  String toString() {
    return 'CopyEvent.copyCancelled(lastEvent: $lastEvent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CopyCancelled &&
            (identical(other.lastEvent, lastEvent) ||
                other.lastEvent == lastEvent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lastEvent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CopyCancelledCopyWith<_$CopyCancelled> get copyWith =>
      __$$CopyCancelledCopyWithImpl<_$CopyCancelled>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() copyStarted,
    required TResult Function(CopyProgress lastEvent) copyCancelled,
    required TResult Function(int numberOfFiles) scanningFiles,
    required TResult Function(
            int totalBytes, int bytesCopied, int totalFiles, int filesCopied)
        copyProgress,
  }) {
    return copyCancelled(lastEvent);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? copyStarted,
    TResult? Function(CopyProgress lastEvent)? copyCancelled,
    TResult? Function(int numberOfFiles)? scanningFiles,
    TResult? Function(
            int totalBytes, int bytesCopied, int totalFiles, int filesCopied)?
        copyProgress,
  }) {
    return copyCancelled?.call(lastEvent);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? copyStarted,
    TResult Function(CopyProgress lastEvent)? copyCancelled,
    TResult Function(int numberOfFiles)? scanningFiles,
    TResult Function(
            int totalBytes, int bytesCopied, int totalFiles, int filesCopied)?
        copyProgress,
    required TResult orElse(),
  }) {
    if (copyCancelled != null) {
      return copyCancelled(lastEvent);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CopyStarted value) copyStarted,
    required TResult Function(CopyCancelled value) copyCancelled,
    required TResult Function(ScanningFiles value) scanningFiles,
    required TResult Function(CopyProgress value) copyProgress,
  }) {
    return copyCancelled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CopyStarted value)? copyStarted,
    TResult? Function(CopyCancelled value)? copyCancelled,
    TResult? Function(ScanningFiles value)? scanningFiles,
    TResult? Function(CopyProgress value)? copyProgress,
  }) {
    return copyCancelled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CopyStarted value)? copyStarted,
    TResult Function(CopyCancelled value)? copyCancelled,
    TResult Function(ScanningFiles value)? scanningFiles,
    TResult Function(CopyProgress value)? copyProgress,
    required TResult orElse(),
  }) {
    if (copyCancelled != null) {
      return copyCancelled(this);
    }
    return orElse();
  }
}

abstract class CopyCancelled extends CopyEvent {
  const factory CopyCancelled(final CopyProgress lastEvent) = _$CopyCancelled;
  const CopyCancelled._() : super._();

  CopyProgress get lastEvent;
  @JsonKey(ignore: true)
  _$$CopyCancelledCopyWith<_$CopyCancelled> get copyWith =>
      throw _privateConstructorUsedError;
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
    required TResult Function(CopyProgress lastEvent) copyCancelled,
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
    TResult? Function(CopyProgress lastEvent)? copyCancelled,
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
    TResult Function(CopyProgress lastEvent)? copyCancelled,
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
    required TResult Function(CopyCancelled value) copyCancelled,
    required TResult Function(ScanningFiles value) scanningFiles,
    required TResult Function(CopyProgress value) copyProgress,
  }) {
    return scanningFiles(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CopyStarted value)? copyStarted,
    TResult? Function(CopyCancelled value)? copyCancelled,
    TResult? Function(ScanningFiles value)? scanningFiles,
    TResult? Function(CopyProgress value)? copyProgress,
  }) {
    return scanningFiles?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CopyStarted value)? copyStarted,
    TResult Function(CopyCancelled value)? copyCancelled,
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
    required TResult Function(CopyProgress lastEvent) copyCancelled,
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
    TResult? Function(CopyProgress lastEvent)? copyCancelled,
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
    TResult Function(CopyProgress lastEvent)? copyCancelled,
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
    required TResult Function(CopyCancelled value) copyCancelled,
    required TResult Function(ScanningFiles value) scanningFiles,
    required TResult Function(CopyProgress value) copyProgress,
  }) {
    return copyProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CopyStarted value)? copyStarted,
    TResult? Function(CopyCancelled value)? copyCancelled,
    TResult? Function(ScanningFiles value)? scanningFiles,
    TResult? Function(CopyProgress value)? copyProgress,
  }) {
    return copyProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CopyStarted value)? copyStarted,
    TResult Function(CopyCancelled value)? copyCancelled,
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

/// @nodoc
mixin _$CopyFiles {
  Directory get srcVolume => throw _privateConstructorUsedError;
  Directory get dstVolume => throw _privateConstructorUsedError;
  CopyRule get rule => throw _privateConstructorUsedError;
  CancellationToken get token => throw _privateConstructorUsedError;
  AsyncValue<CopyEvent> get lastEvent => throw _privateConstructorUsedError;
  CopyFiles? get followUp => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CopyFilesCopyWith<CopyFiles> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CopyFilesCopyWith<$Res> {
  factory $CopyFilesCopyWith(CopyFiles value, $Res Function(CopyFiles) then) =
      _$CopyFilesCopyWithImpl<$Res, CopyFiles>;
  @useResult
  $Res call(
      {Directory srcVolume,
      Directory dstVolume,
      CopyRule rule,
      CancellationToken token,
      AsyncValue<CopyEvent> lastEvent,
      CopyFiles? followUp});

  $CopyRuleCopyWith<$Res> get rule;
  $CopyFilesCopyWith<$Res>? get followUp;
}

/// @nodoc
class _$CopyFilesCopyWithImpl<$Res, $Val extends CopyFiles>
    implements $CopyFilesCopyWith<$Res> {
  _$CopyFilesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? srcVolume = null,
    Object? dstVolume = null,
    Object? rule = null,
    Object? token = null,
    Object? lastEvent = null,
    Object? followUp = freezed,
  }) {
    return _then(_value.copyWith(
      srcVolume: null == srcVolume
          ? _value.srcVolume
          : srcVolume // ignore: cast_nullable_to_non_nullable
              as Directory,
      dstVolume: null == dstVolume
          ? _value.dstVolume
          : dstVolume // ignore: cast_nullable_to_non_nullable
              as Directory,
      rule: null == rule
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as CopyRule,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as CancellationToken,
      lastEvent: null == lastEvent
          ? _value.lastEvent
          : lastEvent // ignore: cast_nullable_to_non_nullable
              as AsyncValue<CopyEvent>,
      followUp: freezed == followUp
          ? _value.followUp
          : followUp // ignore: cast_nullable_to_non_nullable
              as CopyFiles?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CopyRuleCopyWith<$Res> get rule {
    return $CopyRuleCopyWith<$Res>(_value.rule, (value) {
      return _then(_value.copyWith(rule: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CopyFilesCopyWith<$Res>? get followUp {
    if (_value.followUp == null) {
      return null;
    }

    return $CopyFilesCopyWith<$Res>(_value.followUp!, (value) {
      return _then(_value.copyWith(followUp: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CopyFilesCopyWith<$Res> implements $CopyFilesCopyWith<$Res> {
  factory _$$_CopyFilesCopyWith(
          _$_CopyFiles value, $Res Function(_$_CopyFiles) then) =
      __$$_CopyFilesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Directory srcVolume,
      Directory dstVolume,
      CopyRule rule,
      CancellationToken token,
      AsyncValue<CopyEvent> lastEvent,
      CopyFiles? followUp});

  @override
  $CopyRuleCopyWith<$Res> get rule;
  @override
  $CopyFilesCopyWith<$Res>? get followUp;
}

/// @nodoc
class __$$_CopyFilesCopyWithImpl<$Res>
    extends _$CopyFilesCopyWithImpl<$Res, _$_CopyFiles>
    implements _$$_CopyFilesCopyWith<$Res> {
  __$$_CopyFilesCopyWithImpl(
      _$_CopyFiles _value, $Res Function(_$_CopyFiles) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? srcVolume = null,
    Object? dstVolume = null,
    Object? rule = null,
    Object? token = null,
    Object? lastEvent = null,
    Object? followUp = freezed,
  }) {
    return _then(_$_CopyFiles(
      srcVolume: null == srcVolume
          ? _value.srcVolume
          : srcVolume // ignore: cast_nullable_to_non_nullable
              as Directory,
      dstVolume: null == dstVolume
          ? _value.dstVolume
          : dstVolume // ignore: cast_nullable_to_non_nullable
              as Directory,
      rule: null == rule
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as CopyRule,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as CancellationToken,
      lastEvent: null == lastEvent
          ? _value.lastEvent
          : lastEvent // ignore: cast_nullable_to_non_nullable
              as AsyncValue<CopyEvent>,
      followUp: freezed == followUp
          ? _value.followUp
          : followUp // ignore: cast_nullable_to_non_nullable
              as CopyFiles?,
    ));
  }
}

/// @nodoc

class _$_CopyFiles implements _CopyFiles {
  const _$_CopyFiles(
      {required this.srcVolume,
      required this.dstVolume,
      required this.rule,
      required this.token,
      this.lastEvent = const AsyncValue.loading(),
      this.followUp});

  @override
  final Directory srcVolume;
  @override
  final Directory dstVolume;
  @override
  final CopyRule rule;
  @override
  final CancellationToken token;
  @override
  @JsonKey()
  final AsyncValue<CopyEvent> lastEvent;
  @override
  final CopyFiles? followUp;

  @override
  String toString() {
    return 'CopyFiles(srcVolume: $srcVolume, dstVolume: $dstVolume, rule: $rule, token: $token, lastEvent: $lastEvent, followUp: $followUp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CopyFiles &&
            (identical(other.srcVolume, srcVolume) ||
                other.srcVolume == srcVolume) &&
            (identical(other.dstVolume, dstVolume) ||
                other.dstVolume == dstVolume) &&
            (identical(other.rule, rule) || other.rule == rule) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.lastEvent, lastEvent) ||
                other.lastEvent == lastEvent) &&
            (identical(other.followUp, followUp) ||
                other.followUp == followUp));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, srcVolume, dstVolume, rule, token, lastEvent, followUp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CopyFilesCopyWith<_$_CopyFiles> get copyWith =>
      __$$_CopyFilesCopyWithImpl<_$_CopyFiles>(this, _$identity);
}

abstract class _CopyFiles implements CopyFiles {
  const factory _CopyFiles(
      {required final Directory srcVolume,
      required final Directory dstVolume,
      required final CopyRule rule,
      required final CancellationToken token,
      final AsyncValue<CopyEvent> lastEvent,
      final CopyFiles? followUp}) = _$_CopyFiles;

  @override
  Directory get srcVolume;
  @override
  Directory get dstVolume;
  @override
  CopyRule get rule;
  @override
  CancellationToken get token;
  @override
  AsyncValue<CopyEvent> get lastEvent;
  @override
  CopyFiles? get followUp;
  @override
  @JsonKey(ignore: true)
  _$$_CopyFilesCopyWith<_$_CopyFiles> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CopyRule {
  Glob get srcGlob => throw _privateConstructorUsedError;
  String? get dstSubPath => throw _privateConstructorUsedError;
  bool get flatten => throw _privateConstructorUsedError;
  bool get byDate => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CopyRuleCopyWith<CopyRule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CopyRuleCopyWith<$Res> {
  factory $CopyRuleCopyWith(CopyRule value, $Res Function(CopyRule) then) =
      _$CopyRuleCopyWithImpl<$Res, CopyRule>;
  @useResult
  $Res call({Glob srcGlob, String? dstSubPath, bool flatten, bool byDate});
}

/// @nodoc
class _$CopyRuleCopyWithImpl<$Res, $Val extends CopyRule>
    implements $CopyRuleCopyWith<$Res> {
  _$CopyRuleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? srcGlob = null,
    Object? dstSubPath = freezed,
    Object? flatten = null,
    Object? byDate = null,
  }) {
    return _then(_value.copyWith(
      srcGlob: null == srcGlob
          ? _value.srcGlob
          : srcGlob // ignore: cast_nullable_to_non_nullable
              as Glob,
      dstSubPath: freezed == dstSubPath
          ? _value.dstSubPath
          : dstSubPath // ignore: cast_nullable_to_non_nullable
              as String?,
      flatten: null == flatten
          ? _value.flatten
          : flatten // ignore: cast_nullable_to_non_nullable
              as bool,
      byDate: null == byDate
          ? _value.byDate
          : byDate // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CopyRuleCopyWith<$Res> implements $CopyRuleCopyWith<$Res> {
  factory _$$_CopyRuleCopyWith(
          _$_CopyRule value, $Res Function(_$_CopyRule) then) =
      __$$_CopyRuleCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Glob srcGlob, String? dstSubPath, bool flatten, bool byDate});
}

/// @nodoc
class __$$_CopyRuleCopyWithImpl<$Res>
    extends _$CopyRuleCopyWithImpl<$Res, _$_CopyRule>
    implements _$$_CopyRuleCopyWith<$Res> {
  __$$_CopyRuleCopyWithImpl(
      _$_CopyRule _value, $Res Function(_$_CopyRule) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? srcGlob = null,
    Object? dstSubPath = freezed,
    Object? flatten = null,
    Object? byDate = null,
  }) {
    return _then(_$_CopyRule(
      srcGlob: null == srcGlob
          ? _value.srcGlob
          : srcGlob // ignore: cast_nullable_to_non_nullable
              as Glob,
      dstSubPath: freezed == dstSubPath
          ? _value.dstSubPath
          : dstSubPath // ignore: cast_nullable_to_non_nullable
              as String?,
      flatten: null == flatten
          ? _value.flatten
          : flatten // ignore: cast_nullable_to_non_nullable
              as bool,
      byDate: null == byDate
          ? _value.byDate
          : byDate // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_CopyRule implements _CopyRule {
  const _$_CopyRule(
      {required this.srcGlob,
      this.dstSubPath,
      this.flatten = false,
      this.byDate = false});

  @override
  final Glob srcGlob;
  @override
  final String? dstSubPath;
  @override
  @JsonKey()
  final bool flatten;
  @override
  @JsonKey()
  final bool byDate;

  @override
  String toString() {
    return 'CopyRule(srcGlob: $srcGlob, dstSubPath: $dstSubPath, flatten: $flatten, byDate: $byDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CopyRule &&
            (identical(other.srcGlob, srcGlob) || other.srcGlob == srcGlob) &&
            (identical(other.dstSubPath, dstSubPath) ||
                other.dstSubPath == dstSubPath) &&
            (identical(other.flatten, flatten) || other.flatten == flatten) &&
            (identical(other.byDate, byDate) || other.byDate == byDate));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, srcGlob, dstSubPath, flatten, byDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CopyRuleCopyWith<_$_CopyRule> get copyWith =>
      __$$_CopyRuleCopyWithImpl<_$_CopyRule>(this, _$identity);
}

abstract class _CopyRule implements CopyRule {
  const factory _CopyRule(
      {required final Glob srcGlob,
      final String? dstSubPath,
      final bool flatten,
      final bool byDate}) = _$_CopyRule;

  @override
  Glob get srcGlob;
  @override
  String? get dstSubPath;
  @override
  bool get flatten;
  @override
  bool get byDate;
  @override
  @JsonKey(ignore: true)
  _$$_CopyRuleCopyWith<_$_CopyRule> get copyWith =>
      throw _privateConstructorUsedError;
}
