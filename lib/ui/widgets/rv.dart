import 'dart:collection';

import 'package:flutter/material.dart';

class GroupItem extends Item with ListMixin<Item> {
  Item header;

  List<Item> _items = new List();

  GroupItem(int id) : super(id);

  int getItemCount() => _items.length + getHeaderCount();

  bool update(Item item) {
    var index = _items.indexOf(item);

    if (index == -1) {
      return false;
    }

    _items.replaceRange(index, index + 1, [item]);

    return true;
  }

  void addItems(List<Item> items) {
    _items.addAll(items);
  }

  void addItem(Item item) {
    _items.add(item);
  }

  @override
  Widget create(BuildContext context, int position, int adapterPosition) {}

  Item getItem(int index) => index == 0 ? header : _items[index - 1];

  int getItemPosition(Item item) => _items.indexOf(item);

  void addHeader(Item item) {
    this.header = item;
  }

  void updateHeader(Item item) {
    this.header = item;
  }

  int getHeaderCount() {
    if (hasHeader()) {
      return 1;
    }

    return 0;
  }

  bool hasHeader() {
    return length != 0 && header != null;
  }

  Item removeItem(Item item) {
    var index = _items.indexOf(item);
    if (index == -1) {
      return null;
    }
    return _items.removeAt(index);
  }

  @override
  int get length => _items.length;

  @override
  set length(int newLength) => _items.length = newLength;

  @override
  Item operator [](int index) => _items[index];

  @override
  void operator []=(int index, Item value) => _items[index] = value;
}

abstract class Item {
  final int _id;

  const Item(this._id);

  int getId() => _id;

  Widget create(BuildContext context, int position, int adapterPosition);

  @override
  bool operator ==(other) =>
      this.runtimeType == other.runtimeType && other._id == _id;

  int get hashCode => _id.hashCode;
}

class Adapter {
  List<Item> _items = new List();

  bool notNull(Object o) => o != null;

  Widget onCreateWidget(BuildContext context, int adapterPosition) {
    int count = 0;
    for (var index = 0; index < _items.length; index++) {
      var item = _items[index];

      if (item is GroupItem) {
        var groupCount = item.getItemCount();
        if (adapterPosition < count + groupCount) {
          var groupItem = item.getItem(adapterPosition - count);
          var idx = item.getItemPosition(groupItem);
          return groupItem.create(context, idx, adapterPosition);
        } else {
          count += groupCount;
        }
      } else {
        if (count == adapterPosition) {
          Item ungroupedItem = _items[index];
          return ungroupedItem.create(context, index, adapterPosition);
        } else {
          count += 1;
        }
      }
    }

    return null;
  }

  int getItemCount() {
    var count = 0;

    for (Item i in _items) {
      if (i is GroupItem) {
        count += i.getItemCount();
      } else {
        count += 1;
      }
    }

    return count;
  }

  bool updateItem(Item item) {
    bool updated = false;

    for (var index = 0; index < _items.length; index++) {
      var i = _items[index];
      if (!updated) {
        if (i == item && i is GroupItem) {
          _items[index] = item;
          return true;
        } else if (i is GroupItem) {
          updated = i.update(item);
        } else {
          var index = _items.indexOf(item);
          if (index == -1) {
            updated = false;
          } else {
            _items.replaceRange(index, index + 1, [item]);
            updated = true;
          }
        }
      }

      if (updated) {
        return updated;
      }
    }

    return updated;
  }

  Item removeItem(Item item) {
    Item removed;
    for (Item i in _items) {
      if (i is GroupItem) {
        removed = i.removeItem(item);
      } else {
        var index = _items.indexOf(item);
        if (index != -1) {
          removed = _items.removeAt(index);
        }
      }

      if (removed != null) {
        return removed;
      }
    }
    return removed;
  }

  Item getItemAt(int position) => _items[position];

  void swapData(List<Item> items) {
    if (items != null) {
      this._items = items.where(notNull).toList();
    }
  }
}
