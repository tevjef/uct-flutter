import 'dart:async';

import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';

import '../../core/lib.dart';
import '../../data/lib.dart';
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

mixin LDEViewMixin<T extends StatefulWidget> on State<T> implements BaseView, ListOps {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  final ScrollController _scrollController = ScrollController();

  bool isFullLoading = false;
  bool isRefreshing = false;

  Completer<Null> completer = Completer();

  bool isList = true;

  BasePresenter get presenter;

  Adapter adapter = Adapter();

  @override
  void initState() {
    super.initState();
    presenter.onInitState();
  }

  @override
  void showLoading(bool isLoading) {
    setState(() {
      this.isFullLoading = isLoading && (!isList || adapter.getItemCount() == 0);
      this.isRefreshing = isLoading;

      if (isRefreshing) {
        refreshIndicatorKey.currentState?.show();
      }

      if (!isRefreshing) {
        completer.complete(null);
      }

      completer = Completer();
    });
  }

  @override
  void setListData(List<Item> items) {
    swapItems(items);
  }

  @override
  void showMessage(String message, [SnackBarAction? action]) {
    // scaffoldKey.currentState?.hideCurrentSnackBar();

    // scaffoldKey.currentState?.showSnackBar(
    // Widgets.makeSnackBar(message, SnackBarType.neutral, action));
  }

  @override
  void showErrorMessage(Exception error, [Function? retry]) {
    // scaffoldKey.currentState?.hideCurrentSnackBar();

    // scaffoldKey.currentState
    //     ?.showSnackBar(Widgets.makeErrorSnackBar(error, retry));
  }

  Future<Null> handleRefresh() {
    showLoading(true);

    onRefreshData();

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

  Widget makeAnimatedListView(BuildContext context) {
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

  Widget makeLDEWidget(BuildContext context, Widget widget) {
    Widget toReturn = widget;

    if (isFullLoading) {
      toReturn = Widgets.makeLoading(context);
    } else {
      if (adapter.getItemCount() == 0 && isList) {
        toReturn = makeEmptyStateWidget(context);
      }
    }

    return toReturn;
  }

  Widget makeRefreshingList(BuildContext context) {
    return RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: handleRefresh,
        child: makeLDEWidget(context, makeAnimatedListView(context)));
  }

  Widget makeRefreshingWidget(BuildContext context, Widget widget) {
    this.isList = false;
    return RefreshIndicator(key: refreshIndicatorKey, onRefresh: handleRefresh, child: makeLDEWidget(context, widget));
  }

  BuildContext getContext() {
    return context;
  }

  Widget makeEmptyStateWidget(BuildContext context) {
    return Text("");
  }

  void onRefreshData();

  void refreshData() {
    showLoading(true);
  }
}

enum SnackBarType { error, neutral, success }

class Widgets {
  static SnackBar makeErrorSnackBar(BuildContext context, Exception error, VoidCallback action) {
    if (error is Retryable) {
      return makeSnackBar(
          context, error.toString(), SnackBarType.error, SnackBarAction(label: "Retry", onPressed: action));
    } else {
      return makeSnackBar(context, error.toString(), SnackBarType.error);
    }
  }

  static SnackBar makeSnackBar(BuildContext context, String message,
      [SnackBarType type = SnackBarType.neutral,
      SnackBarAction? action,
      Duration duration = const Duration(seconds: 4)]) {
    TextStyle style;
    Color color;

    switch (type) {
      case SnackBarType.error:
        style = Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white, fontWeight: FontWeight.bold);
        color = Colors.red;
        duration = Duration(seconds: 30);
        break;
      case SnackBarType.neutral:
        style = Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white, fontWeight: FontWeight.bold);
        color = AppColors.white.shade900;
        break;
      case SnackBarType.success:
        style = Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white, fontWeight: FontWeight.bold);
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

  static Widget makeLoading(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: Dimens.spacingStandard, right: Dimens.spacingStandard),
        child: CircularProgressIndicator(),
      ),
    );
  }

  static Widget makeIconWithBadge(BuildContext context, String badgeText, GestureTapCallback onTap) {
    return Container(
      width: Dimens.spacingXxlarge,
      height: Dimens.spacingXxlarge,
      margin: EdgeInsets.only(right: Dimens.spacingStandard),
      child: new Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Icon(Icons.inbox, color: Theme.of(context).colorScheme.onBackground),
          new Positioned(
            top: -2.0,
            right: -2.0,
            child: Container(
              padding: EdgeInsets.all(2.0),
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(99.0),
                color: Theme.of(context).colorScheme.background,
              ),
              child: new Container(
                padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(99.0), color: Colors.red),
                child: Center(
                  child: new Text(
                    badgeText,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkResponse(
                containedInkWell: true,
                radius: Dimens.spacingStandard,
                borderRadius: BorderRadius.circular(Dimens.spacingStandard),
                onTap: onTap),
          )
        ],
      ),
    );
  }
}
