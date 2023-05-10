import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

typedef UuidV = List<int>;

UuidV createRandomUuid() {
  const uuid = Uuid(options: {'grng': UuidUtil.cryptoRNG});

  return uuid.v5buffer(null, null, null);
}
