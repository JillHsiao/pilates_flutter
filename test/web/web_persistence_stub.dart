import 'package:flutter_test/flutter_test.dart';

void runWebPersistenceTests() {
  test(
    'SQLite WASM persistence is exercised by the Chrome test target',
    () {},
    skip: 'Browser-only test',
  );
}
