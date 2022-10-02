import 'package:minion/minion.dart';
import 'package:test/test.dart';

void main() {
  test('stdin ...', () async {
    final minion = MinionStdin();
    const value = 'Hello World';
    minion.writeLineSync(value);

    final line = minion.readLineSync();

    expect(line, equals(value));
  });

  test('stdin - 100 lines', () async {
    final minion = MinionStdin();
    const value = 'Hello World';

    for (var i = 0; i < 100; i++) {
      minion.writeLineSync('$value $i');
    }

    for (var i = 0; i < 100; i++) {
      final line = minion.readLineSync();

      expect(line, equals('$value $i'));
    }
  });

  test('stdin - eof', () async {
    final minion = MinionStdin();
    const value = 'Hello World';

    for (var i = 0; i < 100; i++) {
      minion.writeLineSync('$value $i');
    }
    minion.close();

    var i = 0;
    String? line;
    while ((line = minion.readLineSync()) != null) {
      expect(line, equals('$value $i'));
      i++;
    }
    expect(i, equals(100));
  });
}
