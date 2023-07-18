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
  });
}

void expectCharacters(int length, String characters) {
  final chars = characters.split('');
  final uniqueChars = chars.toSet();
  expect(chars.length, uniqueChars.length, reason: 'found duplicate letter');
  expect(chars.length, length);
}
