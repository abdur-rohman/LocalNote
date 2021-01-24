import 'dart:convert';

extension StringUtil on String {
  String get encode => base64.encode(utf8.encode(this));
  String get decode => utf8.decode(base64.decode(this));
}
