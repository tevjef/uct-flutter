import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/lib.dart';
import 'draggable_scrollbar.dart';
import 'rv.dart';
import 'styles.dart';

abstract class BaseView extends ContextProvider {
  void showLoading(bool isLoading);

  void setListData(List<Item> adapterItems);

  void showMessage(String message, [SnackBarAction action]);

  void showErrorMessage(Exception error, [Function retryAction]);
}

abstract class BasePresenter<T extends BaseView> {
  final T view;

  const BasePresenter(this.view);

  BuildContext get context => view.getContext();

  @mustCallSuper
  void onInitState() {
    view.showLoading(true);
  }
}

abstract class ContextProvider {
  BuildContext getContext();
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
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  final ScrollController _scrollController = ScrollController();

  bool isLoading;
  bool isRefreshing;

  Completer<Null> completer;

  BasePresenter get presenter;

  Adapter adapter = Adapter();

  @override
  void initState() {
    super.initState();
    presenter.onInitState();
  }

  bool isList() => true;

  @override
  void showLoading(bool isLoading) {
    this.isLoading = isLoading;
    this.isRefreshing = isLoading;

    if (isRefreshing && (adapter.getItemCount() != 0 || !isList())) {
      refreshIndicatorKey.currentState?.show();
    }

    if (!isRefreshing && completer != null) {
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
  void showErrorMessage(Exception error, [Function retry]) {
    scaffoldKey.currentState?.hideCurrentSnackBar();

    scaffoldKey.currentState
        ?.showSnackBar(Widgets.makeErrorSnackBar(error, retry));
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

  Widget makeAnimatedListView() {
    adapter.setListKey(listKey);

    var list = AnimatedList(
        key: listKey,
        initialItemCount: adapter.getItemCount(),
        padding: EdgeInsets.symmetric(vertical: Dimens.spacingMedium),
        itemBuilder: adapter.onCreateWidgetWithAnimation);

    return Scrollbar(child: list);
    /*
    https://github.com/flutter/flutter/issues/22180
    return DraggableScrollbar.semicircle(
        labelTextBuilder: (double offset) {
          final int currentItem = _scrollController.hasClients
              ? (_scrollController.offset /
                      _scrollController.position.maxScrollExtent *
                      adapter.getItemCount())
                  .floor()
              : 0;

          var label = adapter.getFastScrollLabel(currentItem);

          if (label == null) {
            label = "";
          }

          return Text(label);
        },
        child: list,
        controller: _scrollController);*/
  }

  Widget makeListView() {
    return DraggableScrollbar.semicircle(
        child: ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.only(top: Dimens.spacingMedium),
            itemCount: adapter.getItemCount(),
            itemBuilder: adapter.onCreateWidget),
        controller: _scrollController);
  }

  Widget makeLDEList() {
    return makeLDEWidget(makeAnimatedListView());
  }

  Widget makeLDEWidget(Widget widget) {
    Widget toReturn = widget;

    if (isLoading) {
      toReturn = Widgets.makeLoading();
    } else {
      if (adapter.getItemCount() == 0 && isList()) {
        toReturn = makeEmptyStateWidget();
      }
    }

    return toReturn;
  }

  Widget makeRefreshingList() {
    return RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: handleRefresh,
        child: makeLDEList());
  }

  Widget makeRefreshingWidget(Widget widget) {
    return RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: handleRefresh,
        child: makeLDEWidget(widget));
  }

  BuildContext getContext() {
    return context;
  }

  Widget makeEmptyStateWidget() {}

  void refreshData();
}

enum SnackBarType { error, neutral, success }

class Widgets {
  static SnackBar makeErrorSnackBar(Exception error, Function action) {
    if (error is Retryable && action != null) {
      return makeSnackBar(error.toString(), SnackBarType.error,
          SnackBarAction(label: "Retry", onPressed: action));
    } else {
      return makeSnackBar(error.toString(), SnackBarType.error);
    }
  }

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
