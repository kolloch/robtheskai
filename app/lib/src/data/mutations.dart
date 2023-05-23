import 'package:freezed_annotation/freezed_annotation.dart';

import 'id.dart';

part 'mutations.freezed.dart';

sealed class Command {
  const Command._();
}

@freezed
sealed class UpdateValue<T> with _$UpdateValue<T> {
  const UpdateValue._();

  factory UpdateValue.delete(T value) = Delete;
  factory UpdateValue.set(T value) = Set;
}

@freezed
class UpdateField<T> with _$UpdateField<T> {
  factory UpdateField({
    required String name,
    required UpdateValue<T> value,
  }) = _UpdateField;
}

@freezed
class UpdateCommand extends Command with _$UpdateCommand {
  factory UpdateCommand({
    required String table,
    required List<Id> ids,
    required List<UpdateField> fields,
  }) = _UpdateCommand;
}

@freezed
class InsertField<T> with _$InsertField<T> {
  factory InsertField({
    required String name,
    required T value,
  }) = _InsertField;
}

@freezed
class InsertCommand extends Command with _$InsertCommand {
  factory InsertCommand({
    required String table,
    required List<InsertField> fields,
  }) = _InsertCommand;
}

// void main() {
//   final SkaiDb db = SkaiDb();

//   for (var table in db.allTables) {
//     print(table.actualTableName);
//     print(table.primaryKey);
//     table.columnsByName.forEach((key, GeneratedColumn<Object> value) {
//       print(key);
//       print(value);
//       print(value.driftSqlType.name);
//       print(value.clientDefault);
//     });
//   }
// }
