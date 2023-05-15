// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scenes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SceneWithLocation {
  Scene get scene => throw _privateConstructorUsedError;
  Location get location => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SceneWithLocationCopyWith<SceneWithLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SceneWithLocationCopyWith<$Res> {
  factory $SceneWithLocationCopyWith(
          SceneWithLocation value, $Res Function(SceneWithLocation) then) =
      _$SceneWithLocationCopyWithImpl<$Res, SceneWithLocation>;
  @useResult
  $Res call({Scene scene, Location location});
}

/// @nodoc
class _$SceneWithLocationCopyWithImpl<$Res, $Val extends SceneWithLocation>
    implements $SceneWithLocationCopyWith<$Res> {
  _$SceneWithLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scene = freezed,
    Object? location = freezed,
  }) {
    return _then(_value.copyWith(
      scene: freezed == scene
          ? _value.scene
          : scene // ignore: cast_nullable_to_non_nullable
              as Scene,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Location,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SceneWithLocationCopyWith<$Res>
    implements $SceneWithLocationCopyWith<$Res> {
  factory _$$_SceneWithLocationCopyWith(_$_SceneWithLocation value,
          $Res Function(_$_SceneWithLocation) then) =
      __$$_SceneWithLocationCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Scene scene, Location location});
}

/// @nodoc
class __$$_SceneWithLocationCopyWithImpl<$Res>
    extends _$SceneWithLocationCopyWithImpl<$Res, _$_SceneWithLocation>
    implements _$$_SceneWithLocationCopyWith<$Res> {
  __$$_SceneWithLocationCopyWithImpl(
      _$_SceneWithLocation _value, $Res Function(_$_SceneWithLocation) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scene = freezed,
    Object? location = freezed,
  }) {
    return _then(_$_SceneWithLocation(
      scene: freezed == scene
          ? _value.scene
          : scene // ignore: cast_nullable_to_non_nullable
              as Scene,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Location,
    ));
  }
}

/// @nodoc

class _$_SceneWithLocation extends _SceneWithLocation {
  const _$_SceneWithLocation({required this.scene, required this.location})
      : super._();

  @override
  final Scene scene;
  @override
  final Location location;

  @override
  String toString() {
    return 'SceneWithLocation(scene: $scene, location: $location)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SceneWithLocation &&
            const DeepCollectionEquality().equals(other.scene, scene) &&
            const DeepCollectionEquality().equals(other.location, location));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(scene),
      const DeepCollectionEquality().hash(location));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SceneWithLocationCopyWith<_$_SceneWithLocation> get copyWith =>
      __$$_SceneWithLocationCopyWithImpl<_$_SceneWithLocation>(
          this, _$identity);
}

abstract class _SceneWithLocation extends SceneWithLocation {
  const factory _SceneWithLocation(
      {required final Scene scene,
      required final Location location}) = _$_SceneWithLocation;
  const _SceneWithLocation._() : super._();

  @override
  Scene get scene;
  @override
  Location get location;
  @override
  @JsonKey(ignore: true)
  _$$_SceneWithLocationCopyWith<_$_SceneWithLocation> get copyWith =>
      throw _privateConstructorUsedError;
}
