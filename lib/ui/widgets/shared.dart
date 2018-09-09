import 'dart:async';

import 'package:flutter/material.dart';

import 'rv.dart';
import 'styles.dart';

abstract class BaseView {
  void showLoading(bool isLoading);

  void setListData(List<Item> adapterItems);

  void showMessage(String message, [SnackBarAction action]);

  void showErrorMessage(String message, [SnackBarAction action]);
}

abstract class ListOps {
  void updateItem(Item item);

  Item removeItem(Item item);

  void swapItems(List<Item> items);
}

abstract class LDEViewMixin<T extends StatefulWidget> extends State<T>
    implements BaseView, ListOps {
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
  void setListData(List<Item> items) {
    showLoading(false);
    swapItems(items);
  }

  @override
  void showMessage(String message, [SnackBarAction action]) {
    scaffoldKey.currentState?.hideCurrentSnackBar();

    scaffoldKey.currentState?.showSnackBar(
        Widgets.makeSnackBar(message, SnackBarType.neutral, action));
  }

  @override
  void showErrorMessage(String message, [SnackBarAction action]) {
    scaffoldKey.currentState?.showSnackBar(
        Widgets.makeSnackBar(message, SnackBarType.error, action));
  }

  Future<Null> handleRefresh() {
    showLoading(true);

    refreshData();

    return completer.future;
  }

  void updateItem(Item item) {
    setState(() {
      adapter.updateItem(item);
    });
  }

  @override
  void swapItems(List<Item> items) {
    setState(() {
      adapter.swapData(items);
    });
  }

  Item removeItem(Item item) {
    Item oldItem = adapter.removeItem(item);

    setState(() {});

    return oldItem;
  }

  ListView getListView() => ListView.builder(
      padding: EdgeInsets.only(top: Dimens.spacingMedium),
      itemCount: adapter.getItemCount(),
      itemBuilder: adapter.onCreateWidget);

  void refreshData();
}

enum SnackBarType { error, neutral, success }

class Widgets {
  static SnackBar makeSnackBar(String message,
      [SnackBarType type = SnackBarType.neutral,
      SnackBarAction action,
      Duration duration = const Duration(seconds: 4)]) {
    TextStyle style;
    Color color;

    switch (type) {
      case SnackBarType.error:
        style = Styles.body2PrimaryInverse;
        color = Colors.red;
        duration = Duration(seconds: 30);
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
      action: action,
      content: Text(message, style: style),
      backgroundColor: color,
      duration: duration,
    );
  }

  static Widget makeLoading() {
    return Center(
        child: Padding(
            padding: const EdgeInsets.only(
                left: Dimens.spacingStandard, right: Dimens.spacingStandard),
            child: CircularProgressIndicator(backgroundColor: Colors.black)));
  }

  static Widget makeIconWithBadge(String badgeText, GestureTapCallback onTap) {
    return Container(
      padding: EdgeInsets.only(right: 16.0),
      child: Center(
        child: new Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            const Icon(Icons.inbox),
            new Positioned(
              top: -6.0,
              right: -6.0,
              child: Container(
                padding: EdgeInsets.all(2.0),
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(99.0),
                  color: Colors.white,
                ),
                child: new Container(
                  padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                  decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(99.0),
                      color: Colors.red),
                  child: Center(
                    child: new Text(
                      badgeText,
                      textAlign: TextAlign.center,
                      style: Styles.body1PrimaryInverse,
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(99.0)),
                color: Colors.transparent,
                child: InkWell(onTap: onTap),
              ),
            )
          ],
        ),
      ),
    );
  }
}
