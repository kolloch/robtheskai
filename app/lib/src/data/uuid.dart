import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

typedef UuidV = List<int>;

const Uuid _uuid = Uuid(options: {'grng': UuidUtil.cryptoRNG});

UuidV randomUuid() {
  return _uuid.v5buffer(null, null, null);
}

UuidV uuidFromString(String uuid) {
  return Uuid.parse(uuid);
}

extension UuidVExtension on UuidV {
  String toShortString() {
    return Uuid.unparse(this);
  }
}

class UuidConverter extends TypeConverter<List<int>, String> {
  const UuidConverter();

  @override
  List<int> fromSql(String fromDb) {
    return Uuid.parse(fromDb);
  }

  @override
  String toSql(List<int> value) {
    return Uuid.unparse(value);
  }
}
