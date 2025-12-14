import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

DateTime? _lastPressed;
Widget exitAlert(BuildContext context, Widget child) {
  return PopScope(
    canPop: false,
    onPopInvokedWithResult: (didPop, result) {
      if (!didPop) {
        final canExit = handleDoubleBackToExit(context);
        if (canExit) {
          SystemNavigator.pop();
        }
      }
    },
    child: child,
  );
}

bool handleDoubleBackToExit(BuildContext context) {
  final now = DateTime.now();
  if (_lastPressed == null ||
      now.difference(_lastPressed!) > Duration(seconds: 2)) {
    _lastPressed = now;
    Get.snackbar(
      colorText: Colors.white,
      backgroundColor: Colors.black,
      snackPosition: SnackPosition.BOTTOM,
      "تنبيه",
      "اضغط مرة ثانية للخروج",
      duration: Duration(seconds: 2),
    );

    return false; // ما يطلع
  } else {
    return true; // يطلع
  }
}
