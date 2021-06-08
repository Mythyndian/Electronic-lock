import 'package:flutter/foundation.dart';

class CodeProvider extends ChangeNotifier {
  String _code = '';
  String get code => _code;
  set code(String sequence) {
    this._code = sequence;
    notifyListeners();
  }
}
