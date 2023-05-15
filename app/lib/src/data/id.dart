import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'id.freezed.dart';

@freezed
class Id with _$Id {
  const Id._();

  @Assert('value.length == 16')
  const factory Id(List<int> value) = _Id;

  factory Id.random() {
    return Id(_uuid.v5buffer(null, null, null));
  }

  factory Id.fromString(String uuid) => Id(Uuid.parse(uuid));

  @override
  String toString() {
    return Uuid.unparse(value);
  }
}

const Uuid _uuid = Uuid(options: {'grng': UuidUtil.cryptoRNG});
