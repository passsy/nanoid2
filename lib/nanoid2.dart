// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:math';

/// This generator function create a tiny, secure, URL-friendly, unique string ID
///
/// The [length] of the nanoid is adjustable (default is 21 characters).
/// The characters are taken from [alphabet] (Defaults to [Alphabet.url] `[a-zA-Z0-9_-]`) at [random] order.
///
/// Examples:
///
/// ```text
/// BGmaV2KoFx0Ar2yS6zMDc
/// TZGlaZw38c43IILQQ-Jxc
/// n_vyOfT-Q9hwWyYQZSYop
/// nMbnyHZiCV_NGgXNdANLX
/// 0hpndh5fAcjBU3ZTABFdR
/// ```
///
/// nonoid uses [Random.secure] by default. When platforms don't support it, it falls back to [Random].
///
/// For predictable ID generation during tests, you can pass a seeded [random] number generator.
///
/// ```dart
/// final random = Random(42);
/// for (int i = 0; i < 3; i++) {
///   final id = nanoid(random: random);
///   print(id);
/// }
/// // NI2rPCdXKSZyNNboBnBIy
/// // oduoyIeuj6itVcufRe11I
/// // 8rnfaUlBaqZ97p13lEhsT
/// ```
String nanoid({
  int length = 21,
  String? alphabet,
  Random? random,
}) {
  if (length < 2) {
    throw ArgumentError.value(
      length,
      "length",
      "Length must be greater than 2",
    );
  }
  if (length > 255) {
    throw ArgumentError.value(length, "length", "Length must be less than 255");
  }
  int i = length;
  if (alphabet != null && alphabet.isEmpty) {
    throw ArgumentError.value(
      alphabet,
      "alphabet",
      "Alphabet must not be empty",
    );
  }

  final String characters = alphabet ?? Alphabet.url;
  final int alphabetSize = characters.length;
  assert(alphabetSize > 0);

  final Random secureRandom = random ?? Random.secure();
  Random? insecureRandom;

  int nextRandomIndex() {
    try {
      return secureRandom.nextInt(alphabetSize);
      // ignore: avoid_catching_errors
    } on UnsupportedError {
      // Random.secure() is not supported on this platform, fallback to the insecure version
      insecureRandom ??= Random();
      return insecureRandom!.nextInt(alphabetSize);
    }
  }

  final sb = StringBuffer();
  while (0 < i--) {
    final randomIndex = nextRandomIndex();
    final character = characters[randomIndex];
    sb.write(character);
  }
  return sb.toString();
}

/// A collection of useful alphabets that can be used to generate ids.
abstract class Alphabet {
  /// Numbers from 0 to 9. [0-9] (10 chars)
  static const String numbers = '0123456789';

  /// English hexadecimal with lowercase characters. [0-9a-f] (16 chars)
  static const String hexadecimalLowercase = numbers + "abcdef";

  /// English hexadecimal with uppercase characters. [0-9A-F] (16 chars)
  static const String hexadecimalUppercase = numbers + "ABCDEF";

  /// Lowercase English letters. [a-z] (26 chars)
  static const String lowercase = "abcdefghijklmnopqrstuvwxyz";

  /// Uppercase English letters. [A-Z] (26 chars)
  static const String uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

  /// Numbers and english letters without lookalikes: 1, l, I, 0, O, o, u, v, 5, S, s, 2, Z. (49 chars)
  static const String noDoppelganger =
      "346789ABCDEFGHJKLMNPQRTUVWXYabcdefghijkmnpqrtwxyz";

  /// Same as noDoppelganger but with removed vowels (only consonants) and following letters: 3, 4, x, X, V. (36 chars)
  /// This list should protect you from accidentally getting obscene words in generated strings.
  static const String noDoppelgangerSafe =
      "6789BCDFGHJKLMNPQRTWbcdfghjkmnpqrtwz";

  /// Combination of all the lowercase, uppercase characters and numbers from 0 to 9. [a-zA-Z0-9] (62 chars)
  /// Does not include any symbols or special characters.
  static const String alphanumeric = numbers + lowercase + uppercase;

  /// URL friendly characters used by the default generate procedure. [a-zA-Z0-9_-] (64 chars)
  static const String url = "_-" + alphanumeric;

  /// Base64 characters [a-zA-Z0-9+/] (64 chars)
  static const String base64 = "+/" + alphanumeric;

  /// Characters that are valid in a cookie value without quoting or escaping.
  /// ``[a-zA-Z0-9!#$%&'*+.^_`|~-]`` (77 chars)
  ///
  /// This is the token character set of RFC 7230, a subset of what RFC 6265
  /// allows in a cookie value. The characters RFC 6265 permits on top of these
  /// have to be quoted to survive some servers and proxies, so they are left
  /// out.
  static const String cookieSafe = alphanumeric + r"!#$%&'*+-.^_`|~";

  /// Crockford's Base32, uppercase letters and numbers without the lookalikes
  /// I, L and O, and without U. [0-9A-HJKMNP-TV-Z] (32 chars)
  ///
  /// Made to be read and typed by humans, for example when an id is written
  /// down or read out loud. U is left out so that generated ids are less
  /// likely to spell obscene words.
  ///
  /// See https://www.crockford.com/base32.html
  static const String crockfordBase32 = numbers + "ABCDEFGHJKMNPQRSTVWXYZ";

  /// Base58 as used by Bitcoin and IPFS. Letters and numbers without the
  /// lookalikes 0, O, I and l. [1-9A-HJ-NP-Za-km-z] (58 chars)
  ///
  /// Case-sensitive and shorter than [crockfordBase32] for the same entropy,
  /// which makes it a common choice for ids that end up in URLs.
  static const String base58 = "123456789ABCDEFGHJKLMNPQRSTUVWXYZ"
      "abcdefghijkmnopqrstuvwxyz";
}
