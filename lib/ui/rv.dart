import 'dart:collection';

import 'package:flutter/material.dart';

abstract class Delegate<I extends Item> {
  Widget create(BuildContext context, I item);
}

abstract class Item {
  int itemType();
}

abstract class Adapter<I extends Item> {
  List<I> items = new List();
  HashMap<int, Delegate> delegates = new HashMap();

  Widget onCreateWidget(BuildContext context, int position) {
    int viewType = getItemViewType(position);
    return delegates[viewType].create(context, items[position]);
  }

  int getItemCount() => items.length;

  int getItemViewType(int position) => getItemAt(position).itemType();

  I getItemAt(int position) => items[position];

  void swapData(List<I> items) {
    this.items = items;
  }
}
