Changelog

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

This package is a fork of https://pub.dev/packages/nanoid

Many features have been removed to make the API more Dart-like.
Please get support for 1.0.0 from the original package at https://github.com/pd4d10/nanoid-dart.