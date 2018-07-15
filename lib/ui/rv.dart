import 'dart:collection';

import 'package:flutter/material.dart';

abstract class Item {

  final int _hashCode;

  const Item(this._hashCode);

  int itemType();
  Widget create(BuildContext context, int position);
}

class Adapter {
  List<Item> items = new List();

  bool notNull(Object o) => o != null;

  Widget onCreateWidget(BuildContext context, int position) {
    Item item = items[position];
    return item.create(context, position);
  }

  int getItemCount() => items.length;

  int getItemViewType(int position) => getItemAt(position).itemType();

  Item getItemAt(int position) => items[position];

  void swapData(List<Item> items) {
    if (items != null) {
      this.items = items.where(notNull).toList();
    }
  }
}
