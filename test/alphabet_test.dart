import 'package:nanoid2/nanoid2.dart';
import 'package:test/test.dart';

void main() {
  test('alphabet sizes', () {
    expectCharacters(10, Alphabet.numbers);
    expectCharacters(16, Alphabet.hexadecimalLowercase);
    expectCharacters(16, Alphabet.hexadecimalUppercase);
    expectCharacters(26, Alphabet.lowercase);
    expectCharacters(26, Alphabet.uppercase);
    expectCharacters(49, Alphabet.noDoppelganger);
    expectCharacters(36, Alphabet.noDoppelgangerSafe);
    expectCharacters(62, Alphabet.alphanumeric);
    expectCharacters(64, Alphabet.url);
    expectCharacters(64, Alphabet.base64);
    expectCharacters(32, Alphabet.crockfordBase32);
    expectCharacters(58, Alphabet.base58);
    expectCharacters(77, Alphabet.cookieSafe);
  });

  test('crockfordBase32 excludes lookalikes I, L, O and the letter U', () {
    for (final excluded in ['I', 'L', 'O', 'U']) {
      expect(Alphabet.crockfordBase32, isNot(contains(excluded)));
    }
  });

  test('cookieSafe excludes what needs quoting in a cookie value', () {
    for (final excluded in [' ', '"', ',', ';', r'\', '(', ')', '/', '@']) {
      expect(Alphabet.cookieSafe, isNot(contains(excluded)));
    }
  });

  test('base58 excludes lookalikes 0, O, I and l', () {
    for (final excluded in ['0', 'O', 'I', 'l']) {
      expect(Alphabet.base58, isNot(contains(excluded)));
    }
  });
}

void expectCharacters(int length, String characters) {
  final chars = characters.split('');
  final uniqueChars = chars.toSet();
  expect(chars.length, uniqueChars.length, reason: 'found duplicate letter');
  expect(chars.length, length);
}
