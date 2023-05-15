///
//  Generated code. Do not modify.
//  source: test.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class test extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'test',
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'peter')
    ..hasRequiredFields = false;

  test._() : super();
  factory test({
    $core.String? peter,
  }) {
    final _result = create();
    if (peter != null) {
      _result.peter = peter;
    }
    return _result;
  }
  factory test.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory test.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  test clone() => test()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  test copyWith(void Function(test) updates) =>
      super.copyWith((message) => updates(message as test))
          as test; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static test create() => test._();
  test createEmptyInstance() => create();
  static $pb.PbList<test> createRepeated() => $pb.PbList<test>();
  @$core.pragma('dart2js:noInline')
  static test getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<test>(create);
  static test? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get peter => $_getSZ(0);
  @$pb.TagNumber(1)
  set peter($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPeter() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeter() => clearField(1);
}
