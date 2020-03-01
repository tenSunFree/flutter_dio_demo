import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIos: 1,
    backgroundColor: Color(0xCC4F4F4F),
    textColor: Color(0xFFFFFFFF),
    fontSize: 16,
  );
}
