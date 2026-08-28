Changelog

## 2.1.0

- **New** `Alphabet.crockfordBase32`, [Crockford's Base32](https://www.crockford.com/base32.html), for ids a human reads out loud or types back in.
  Drops the lookalikes `I` `L` `O`, and `U` so ids are less likely to spell words (32 chars) [#5](https://github.com/passsy/nanoid2/pull/5)

  ```dart
  nanoid(alphabet: Alphabet.crockfordBase32, length: 26); // F6J399SP385YMNBFMNEA1YB2YW
  ```

- **New** `Alphabet.base58`, as used by Bitcoin and IPFS.
  Drops the lookalikes `0` `O` `I` `l` and stays case sensitive, so it is shorter than Base32 at the same entropy (58 chars) [#5](https://github.com/passsy/nanoid2/pull/5)

  ```dart
  nanoid(alphabet: Alphabet.base58, length: 22); // yKBEBzwwHC7pygkBPJkW52
  ```

- **New** `Alphabet.cookieSafe`, valid in a cookie value without quoting or escaping (77 chars) [#5](https://github.com/passsy/nanoid2/pull/5)
- **Fix** The `length` `ArgumentError` messages named the wrong bounds, calling 2 and 255 invalid when both generate ids [#3](https://github.com/passsy/nanoid2/pull/3)
- **Fix** `repository` pointed at the repository's old name, so pub.dev could not verify it. Added `issue_tracker`
- The README gained a `Which alphabet?` table listing every alphabet with its entropy per character [#5](https://github.com/passsy/nanoid2/pull/5), and a `Collisions` section that charts how many ids each alphabet and length is good for [#7](https://github.com/passsy/nanoid2/pull/7)

[diff v2.0.1...v2.1.0](https://github.com/passsy/nanoid2/compare/v2.0.1...v2.1.0)

## 2.0.1

- Update pubspec topics description and repo link

## 2.0.0

Official Dart 3 support, breaking changes, and new Alphabet API.

Breaking changes:
- `nanoid(10)` is now `nanoid(length: 10)`. The `length` parameter has been changed from an optional positional to an optional named parameter.
- The async API `import 'package:nanoid/async.dart';` has been removed. Call `await Future(() {});` or  before calling `nanoid()` to achieve the same effect.
- Changed package name from `import 'package:nanoid/nanoid.dart';` to `import 'package:nanoid2/nanoid2.dart';`
- The insecure API `import 'package:nanoid/non-secure.dart';` has been removed. Call `nanoid(random: Random());` instead to force a non-secure (and faster) random number generator.
  `nonoid()` automatically uses `Random()` instead of `Random.secure()` on platforms that do not provide a cryptographically secure source of random numbers.
- Removed the `customAlphabet('custom', 10)` API. Use `nanoid(alphabet: 'custom', length: 10);` instead.

New APIs:
- The `Alphabet` class provides a set of predefined alphabets for various use cases.

## 1.0.0

This package is a fork of [package:nanoid](https://pub.dev/packages/nanoid)

Many features have been removed to make the API more Dart-like.
Please get support for 1.0.0 from the original package at [pd4d10/nanoid-dart](https://github.com/pd4d10/nanoid-dart).
