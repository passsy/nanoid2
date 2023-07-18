# nanoid2

<img src="https://ai.github.io/nanoid/logo.svg" align="right"
alt="Nano ID logo by Anton Lovchikov" width="180" height="94">

[![pub](https://img.shields.io/pub/v/nanoid2.svg)](https://pub.dartlang.org/packages/nanoid2)

Dart implementation of [ai/nanoid](https://github.com/ai/nanoid).

This is a fork of [package:nanoid](https://pub.dev/packages/nanoid) with a more Dart-like API.

## Install

```bash
dart pub add nanoid2
```

## Usage

```dart
import 'package:nanoid2/nanoid2.dart';

void main() {
  final id = nanoid(); 
  // => LXL0J9b-Uj1C0sZH837Fk, 21 characters
}
```

### Custom length

```dart
import 'package:nanoid2/nanoid2.dart';

void main() {
  final String longId = nanoid(length: 64);
  longId);
  // => sTTAY72ZgB3DFE6oyQlJI5hhvkebrlnheY81wzZHIBbqHHswEyw1LV2hHCrUC6bw, 64 characters
}
```

### Custom alphabet

```dart
import 'package:nanoid/nanoid.dart';

void main() {
  // use your own alphabets
  nanoid(alphabet: '13579'); // only odd numbers
  nanoid(alphabet: '1234567890abcdef'); // hex lowercase

  // or use any of the existing alphabets
  nanoid(alphabet: Alphabet.url); // default [a-zA-Z0-9_-], 64 chars
  nanoid(alphabet: Alphabet.numbers); // [0-9], 10 chars
  nanoid(alphabet: Alphabet.hexadecimalLowercase); // [0-9a-f], 16 chars
  nanoid(alphabet: Alphabet.hexadecimalUppercase); // [0-9A-F], 16 chars
  nanoid(alphabet: Alphabet.lowercase); // [a-z], 26 chars
  nanoid(alphabet: Alphabet.uppercase); // [A-Z], 26 chars
  nanoid(alphabet: Alphabet.alphanumeric); // [a-zA-Z0-9], 62 chars
  nanoid(alphabet: Alphabet.base64); // [a-zA-Z0-9+/], 64 chars

  // Numbers and english letters without lookalikes: 1, l, I, 0, O, o, u, v, 5, S, s, 2, Z. 49 chars
  nanoid(alphabet: Alphabet.noDoppelganger);
  // Numbers and consonants without lookalikes, should never look like an english word, 36 chars
  nanoid(alphabet: Alphabet.noDoppelgangerSafe);
}
```

## License

```
MIT License

Copyright (c) 2023 Pascal Welsch, Rongjian Zhang, Andrey Sitnik

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
