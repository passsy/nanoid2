// ignore_for_file: avoid_print

import 'dart:math';

import 'package:nanoid2/nanoid2.dart';

void main() {
  final String id = nanoid();
  print(id); // 21 characters

  final String longId = nanoid(length: 64);
  print(longId); // 64 characters long

  customAlphabet();
  predictableNanoIds();
}

void customAlphabet() {
  // use your own alphabets
  print(nanoid(alphabet: '13579')); // only odd numbers
  print(nanoid(alphabet: '1234567890abcdef')); // hex lowercase

  // or use any of the existing alphabets
  print(nanoid(alphabet: Alphabet.url)); // default [a-zA-Z0-9_-], 64 chars
  print(nanoid(alphabet: Alphabet.numbers)); // [0-9], 10 chars
  print(nanoid(alphabet: Alphabet.hexadecimalLowercase)); // [0-9a-f], 16 chars
  print(nanoid(alphabet: Alphabet.hexadecimalUppercase)); // [0-9A-F], 16 chars
  print(nanoid(alphabet: Alphabet.lowercase)); // [a-z], 26 chars
  print(nanoid(alphabet: Alphabet.uppercase)); // [A-Z], 26 chars
  print(nanoid(alphabet: Alphabet.alphanumeric)); // [a-zA-Z0-9], 62 chars
  print(nanoid(alphabet: Alphabet.base64)); // [a-zA-Z0-9+/], 64 chars

  // Numbers and english letters without lookalikes: 1, l, I, 0, O, o, u, v, 5, S, s, 2, Z. 49 chars
  print(nanoid(alphabet: Alphabet.noDoppelganger));
  // Numbers and consonants without lookalikes, should never look like an english word, 36 chars
  print(nanoid(alphabet: Alphabet.noDoppelgangerSafe));
}

/// For testing, use a seeded random to generate the same IDs every time.
void predictableNanoIds() {
  final random = Random(42);
  for (int i = 0; i < 3; i++) {
    final id = nanoid(random: random);
    print(id);
  }
  // NI2rPCdXKSZyNNboBnBIy
  // oduoyIeuj6itVcufRe11I
  // 8rnfaUlBaqZ97p13lEhsT

  print(nanoid(length: 10, random: random));
  // RRQMf4U0pJ
}
