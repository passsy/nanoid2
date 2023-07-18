import 'package:nanoid2/nanoid2.dart';
import 'package:test/test.dart';

void main() {
  test('has options', () {
    expect(nanoid(alphabet: 'a', length: 5), equals('aaaaa'));
  });

  test('has flat distribution', () {
    const count = 100 * 1000;
    const length = 5;
    const alphabet = 'abcdefghijklmnopqrstuvwxyz';

    final Map<String, int> chars = {};
    for (var i = 0; i < count; i++) {
      final id = nanoid(alphabet: alphabet, length: length);
      for (var j = 0; j < id.length; j++) {
        final char = id[j];
        if (chars[char] == null) chars[char] = 0;
        chars[char] = chars[char]! + 1;
      }
    }

    chars.forEach((k, _) {
      final distribution = (chars[k]! * alphabet.length) / (count * length);
      expect(distribution, closeTo(1, 0.1));
    });
  });
}
