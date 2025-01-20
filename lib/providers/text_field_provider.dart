import 'package:flutter/cupertino.dart';

class TextFieldProvider extends ChangeNotifier{
  bool _isObscureText = true;

  bool get isObscureText => _isObscureText;

  void toggleObscureText() {
    _isObscureText = !_isObscureText;
    notifyListeners();
  }
}