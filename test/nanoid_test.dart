import 'package:nanoid2/nanoid2.dart';
import 'package:test/test.dart';

void main() {
  test('generates URL-friendly IDs', () {
    for (var i = 0; i < 10; i++) {
      final id = nanoid();
      expect(id.length, equals(21));
      for (var j = 0; j < id.length; j++) {
        expect(Alphabet.url.contains(id[j]), equals(true));
      }
    }
  });

  test(
    'has no collisions',
    () {
      const count = 100 * 1000;
      final used = {};
      for (var i = 0; i < count; i++) {
        final id = nanoid();
        expect(used[id], equals(null));
        used[id] = true;
      }
    },
    retry: 1,
  );
}
