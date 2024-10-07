import 'package:flutter/foundation.dart';

class HomeProvider extends ChangeNotifier {
  /*<<----------->> variables <<----------->>*/
  int _popPressed = 0;

  /*<<----------->> getter <<----------->>*/
  int get popPressed => _popPressed;

  /*<<----------->> setter <<----------->>*/
  Future<void> setPopPressed() async {
    _popPressed++;
    await Future.delayed(const Duration(seconds: 2), () {
      _popPressed = 0;
    });
  }
}
