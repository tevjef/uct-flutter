import 'package:flutter/material.dart';

import 'rv.dart';
import 'styles.dart';

abstract class BaseView {
  void showLoading(bool isLoading);

  void setListData(List<Item> adapterItems);

  void showMessage(String message);

  void showErrorMessage(String message);
}

enum SnackBarType { error, neutral, success }

class Widgets {
  static SnackBar makeSnackBar(String message,
      [SnackBarType type = SnackBarType.neutral]) {
    TextStyle style;
    Color color;

    switch (type) {
      case SnackBarType.error:
        style = Styles.body1SecondaryInverse;
        color = AppColors.uctRed;
        break;
      case SnackBarType.neutral:
        style = Styles.body1SecondaryInverse;
        color = AppColors.white.shade900;
        break;
      case SnackBarType.success:
        style = Styles.body1SecondaryInverse;
        color = AppColors.uctGreen;
        break;
    }
    return SnackBar(
        content: Text(message, style: style), backgroundColor: color);
  }
}
