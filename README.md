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
  // => LXL0J9b-Uj1C0sZH837Fk
  // 21 characters
}
```

### Custom length

```dart
import 'package:nanoid2/nanoid2.dart';

void main() {
  final String longId = nanoid(length: 64);
  // => sTTAY72ZgB3DFE6oyQlJI5hhvkebrlnheY81wzZHIBbqHHswEyw1LV2hHCrUC6bw
  // 64 characters
}
```

### Which alphabet?

Every alphabet trades away characters to gain some property, and pays for it in entropy per character.
Pick the constraint you actually have, then use the length that keeps you at 126 bits, the same collision resistance as UUID v4 and as the 21 character default.

| Alphabet | Characters | Bits per char | Length for 126 bits | You need |
| --- | --- | --- | --- | --- |
| `cookieSafe` | ``[a-zA-Z0-9!#$%&'*+.^_`\|~-]``, 77 chars | 6.27 | 21 | To put the id in a cookie value |
| `url` | `[a-zA-Z0-9_-]`, 64 chars | 6.00 | 21 | Nothing in particular, this is the default |
| `base64` | `[a-zA-Z0-9+/]`, 64 chars | 6.00 | 21 | The classic Base64 symbols `+/` instead of `_-` |
| `alphanumeric` | `[a-zA-Z0-9]`, 62 chars | 5.95 | 22 | Letters and digits, no symbols at all |
| `base58` | `[1-9A-HJ-NP-Za-km-z]`, 58 chars | 5.86 | 22 | A short id for a URL that nobody dictates |
| `noDoppelganger` | `[346-9A-HJ-NP-RT-Ya-kmnp-rtw-z]`, 49 chars | 5.61 | 23 | No lookalikes, but vowels are fine |
| `noDoppelgangerSafe` | `[6-9B-DF-HJ-NP-RTWb-df-hjkmnp-rtwz]`, 36 chars | 5.17 | 25 | An id that can never resemble a word |
| `crockfordBase32` | `[0-9A-HJKMNP-TV-Z]`, 32 chars | 5.00 | 26 | An id that survives being read out loud or typed back in |
| `lowercase` | `[a-z]`, 26 chars | 4.70 | 27 | Case-insensitive storage, such as a hostname or a bucket name |
| `uppercase` | `[A-Z]`, 26 chars | 4.70 | 27 | The same, where the surrounding text is uppercase |
| `hexadecimalLowercase` | `[0-9a-f]`, 16 chars | 4.00 | 32 | To interoperate with something that parses hex |
| `hexadecimalUppercase` | `[0-9A-F]`, 16 chars | 4.00 | 32 | The same, where the reader expects uppercase hex |
| `numbers` | `[0-9]`, 10 chars | 3.32 | 38 | Digits only, for a PIN or a numeric code |

Rows run from the most to the least entropy per character.
A smaller alphabet is not weaker, it just needs a longer id to hold the same 126 bits.

### Collisions

Ids collide the way birthdays do.
With `N` possible ids you get roughly `sqrt(N)` of them before a collision is likely, and every way of phrasing the question lands within a small factor of that.
For the 21 character default there are 2^126 possible ids, so the first collision is expected after about 1.25 times `sqrt(N)`, which is 12 quintillion ids.

Pick a length from the number of ids you will ever create, not from a time span.
This table is for the default `url` alphabet, at a one in a million risk of a single collision ever happening.

| Length | Ids you can create | Which is |
| --- | --- | --- |
| 6 | 371 | too few to use |
| 8 | 24 thousand | a hobby project |
| 10 | 1.5 million | one table in one database |
| 12 | 97 million | a busy table |
| 14 | 6 billion | one id every second for 197 years |
| 16 | 398 billion | a thousand ids a second for 12 years |
| 21 (default) | 13 quadrillion | a billion ids a day for 36,000 years |

Below 12 characters the numbers get small enough to matter, so check them.
At the default they are far enough away that nothing you build will reach them.

Shortening the alphabet costs you the same way shortening the id does, so keep the length from the table above and add the characters the `Which alphabet?` table asks for.

### Custom alphabet

```dart
import 'package:nanoid2/nanoid2.dart';

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
  nanoid(alphabet: Alphabet.base58); // [1-9A-HJ-NP-Za-km-z], 58 chars
  nanoid(alphabet: Alphabet.cookieSafe); // [a-zA-Z0-9!#$%&'*+.^_`|~-], 77 chars
  nanoid(alphabet: Alphabet.crockfordBase32); // [0-9A-HJKMNP-TV-Z], 32 chars

  // Numbers and english letters without lookalikes: 1, l, I, 0, O, o, u, v, 5, S, s, 2, Z. 49 chars
  nanoid(alphabet: Alphabet.noDoppelganger);
  // Numbers and consonants without lookalikes, should never look like an english word, 36 chars
  nanoid(alphabet: Alphabet.noDoppelgangerSafe);
}
```

## License

```text
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
