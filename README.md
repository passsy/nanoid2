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
Pick a length from the number of ids you will ever create, not from a time span.

![Ids you can create at each length, for four alphabet sizes, marked with a UUIDv4 and a YouTube video id, before a one in a million chance of a single collision](https://raw.githubusercontent.com/passsy/nanoid2/main/doc/collision_risk.svg)

Both axes matter: a longer id buys you more, and so does a larger alphabet.
A digits only id has to be 1.8 times as long as a `url` id to be equally safe, which is why `numbers` sits so far below.

The dashed line is a UUIDv4, which spends 36 characters on 122 random bits.
The default 21 characters is the shortest `url` id that clears it, and it clears it by 4x while being 15 characters shorter.
That is where the default comes from.

Some ids you already know, measured the same way:

| Id | What it is | Ids before a 1 in a million risk |
| --- | --- | --- |
| git short sha | 7 hex characters | 23 |
| YouTube video id | 11 characters of the `url` alphabet | 12 million |
| UUIDv4 | 122 random bits, written as 36 characters | 3.3 quadrillion |
| nanoid default | 21 characters of the `url` alphabet | 13 quadrillion |

git and YouTube both hold far more ids than their row allows, because neither leans on randomness alone.
git keeps the full 160 bit hash and only abbreviates for display, lengthening the prefix once it turns ambiguous.
YouTube is billions of videos past its own line, so it has to be checking.
Every number here is for minting an id blind and never looking.
Writing into a column with a unique index and retrying on conflict buys you a shorter id than the table allows.

The same numbers for the default `url` alphabet, to read off exactly:

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
