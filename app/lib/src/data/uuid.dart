import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

typedef UuidV = List<int>;

UuidV createRandomUuid() {
  const uuid = Uuid(options: {'grng': UuidUtil.cryptoRNG});

  return uuid.v5buffer(null, null, null);
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
