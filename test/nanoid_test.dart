import 'dart:math';

import 'package:nanoid2/nanoid2.dart';
import 'package:test/fake.dart';
import 'package:test/test.dart';

void main() {
  test('generates URL-friendly IDs', () {
    for (var i = 0; i < 10; i++) {
      final id = nanoid();
      expect(id.length, equals(21));
      for (var j = 0; j < id.length; j++) {
        expect(
          Alphabet.url.split(''),
          contains(id[j]),
          reason: '$id should contain only url friendly characters',
        );
      }
    }
  });

  test('requires min length of 2', () {
    expect(() => nanoid(length: 0), throwsArgumentError);
    expect(() => nanoid(length: 1), throwsArgumentError);
    nanoid(length: 2);
  });

  test('max length is 255', () {
    nanoid(length: 255);
    expect(() => nanoid(length: 256), throwsArgumentError);
  });

  test('custom alphabet', () {
    expect(nanoid(alphabet: 'a', length: 5), equals('aaaaa'));
  });

  test('empty alphabet is illegal', () {
    expect(() => nanoid(alphabet: ''), throwsArgumentError);
  });

  test('custom Random', () {
    final Random seeded = Random(42);
    expect(nanoid(random: seeded), 'NI2rPCdXKSZyNNboBnBIy');
    expect(nanoid(random: seeded), 'oduoyIeuj6itVcufRe11I');
    expect(nanoid(random: seeded), '8rnfaUlBaqZ97p13lEhsT');
  });

  test(
      'Automatically fallback to Random() when random or Random.secure() fails',
      () {
    final throws = UnsupportedSecureRandom();
    expect(nanoid(random: throws), isNotEmpty);
    expect(throws.hasThrown, isTrue);
  });
}

class UnsupportedSecureRandom with Fake implements Random {
  bool hasThrown = false;

  @override
  int nextInt(int max) {
    hasThrown = true;
    throw UnsupportedError('Platform does not support secure random');
  }
}
