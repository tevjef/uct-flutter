import 'dart:async';

import 'package:flutter/material.dart';

import 'rv.dart';
import 'styles.dart';

abstract class BaseView {
  void showLoading(bool isLoading);

  void setListData(List<Item> adapterItems);

  void showMessage(String message);

  void showErrorMessage(String message);
}

abstract class LDEViewMixin<T extends StatefulWidget> extends State<T>
    implements BaseView {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  bool isLoading;
  Completer<Null> completer;

  Adapter adapter = Adapter();

  @override
  void showLoading(bool isLoading) {
    this.isLoading = isLoading;
    if (!isLoading && completer != null) {
      completer.complete(null);
    }

    completer = Completer();
  }

  @override
  void setListData(List<Item> adapterItems) {
    setState(() {
      showLoading(false);
      this.adapter.swapData(adapterItems);
    });
  }

  @override
  void showMessage(String message) {
    scaffoldKey.currentState?.showSnackBar(Widgets.makeSnackBar(message));
  }

  @override
  void showErrorMessage(String message) {
    scaffoldKey.currentState
        ?.showSnackBar(Widgets.makeSnackBar(message, SnackBarType.error));
  }

  Future<Null> handleRefresh() {
    showLoading(true);

    refreshData();

    return completer.future;
  }

  ListView getListView() => ListView.builder(
      padding: EdgeInsets.only(top: Dimens.spacingMedium),
      itemCount: adapter.items.length,
      itemBuilder: adapter.onCreateWidget);

  void refreshData();
}

enum SnackBarType { error, neutral, success }

class Widgets {
  static SnackBar makeSnackBar(String message,
      [SnackBarType type = SnackBarType.neutral]) {
    TextStyle style;
    Color color;

    switch (type) {
      case SnackBarType.error:
        style = Styles.body2PrimaryInverse;
        color = Colors.red;
        break;
      case SnackBarType.neutral:
        style = Styles.body2PrimaryInverse;
        color = AppColors.white.shade900;
        break;
      case SnackBarType.success:
        style = Styles.body2PrimaryInverse;
        color = Colors.green;
        break;
    }
    return SnackBar(
        content: Text(message, style: style), backgroundColor: color);
  }

  static Widget makeLoading() {
    return Center(
        child: Padding(
            padding: const EdgeInsets.only(
                left: Dimens.spacingStandard, right: Dimens.spacingStandard),
            child: CircularProgressIndicator(backgroundColor: Colors.black)));
  }
}
