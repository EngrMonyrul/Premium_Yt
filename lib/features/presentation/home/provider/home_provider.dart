import 'package:flutter/foundation.dart';
import 'package:tubebuddy_3/core/enums/media_options.dart';

class HomeProvider extends ChangeNotifier {
  /*<<----------->> variables <<----------->>*/
  int _popPressed = 0;
  String _fileName = "";
  String _fileUrl = "";
  MediaOptions? _mediaOptions;
  bool _willNavigate = true;

  /*<<----------->> getter <<----------->>*/
  int get popPressed => _popPressed;

  String get fileName => _fileName;

  String get fileUrl => _fileUrl;

  MediaOptions? get mediaOptions => _mediaOptions;

  bool get willNavigate => _willNavigate;

  /*<<----------->> setter <<----------->>*/
  Future<void> setPopPressed() async {
    _popPressed++;
    await Future.delayed(const Duration(seconds: 2), () {
      _popPressed = 0;
    });

    notifyListeners();
  }

  void setFileName({required String name}) {
    _fileName = name;
    notifyListeners();
  }

  void setFileUrl({required String url}) {
    _fileUrl = url;
    notifyListeners();
  }

  void setMediaOption({MediaOptions? option}) {
    _mediaOptions = option;
    notifyListeners();
  }

  void setWillNavigate({required bool navigate}) {
    _willNavigate = navigate;
    notifyListeners();
  }
}
