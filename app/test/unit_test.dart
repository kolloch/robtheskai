// This is an example unit test.
//
// A unit test tests a single function, method, or class. To learn more about
// writing unit tests, visit
// https://flutter.dev/docs/cookbook/testing/unit/introduction

import 'package:flutter_test/flutter_test.dart';
import 'package:robokru/src/data/id.dart';

void main() {
  group('Id', () {
    test('with the same string should be equal', () {
      final id1 = Id.random();
      final id2 = Id.fromString(id1.toString());

      expect(id1, id2);
    });
  });
}
