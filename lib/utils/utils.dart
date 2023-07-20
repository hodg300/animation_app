import 'package:flutter/cupertino.dart';

class Utils {
  /// return width size of device in double
  static double screenWidthSize(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// return height size of device in double
  static double screenHeightSize(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
