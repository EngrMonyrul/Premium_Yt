import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum SnackbarType {
  alert,
  success,
  failed;

  bool get isAlert => this == alert;

  bool get isSuccess => this == success;

  bool get isFailed => this == failed;
}

class ScaffoldSnackbarMessage {
  final BuildContext context;

  ScaffoldSnackbarMessage(this.context);

  void showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: _snackbarMessage(),
      ),
    );
  }

  Widget _snackbarMessage() {
    return Container();
  }
}
