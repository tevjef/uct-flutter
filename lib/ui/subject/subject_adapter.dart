import 'package:flutter/material.dart';

import '../rv.dart';

abstract class SubjectItem extends Item {}

abstract class SubjectDelegate<I extends SubjectItem> extends Delegate<I> {}

class SubjectAdapter extends Adapter<SubjectItem> {
  SubjectAdapter() {
    delegates[0] = HeaderDelegate();
    delegates[1] = SubjectTitleDelegate();
  }
}

class HeaderItem extends SubjectItem {
  String title;

  HeaderItem(this.title);

  @override
  int itemType() => 0;
}

class HeaderDelegate extends SubjectDelegate<HeaderItem> {
  @override
  Widget create(HeaderItem item) {
    return new Padding(
        padding: new EdgeInsets.all(10.0),
        child: new Text(
          item.title,
          style: new TextStyle(
              fontFamily: "ProductSans", fontWeight: FontWeight.bold),
        ));
  }
}

class SubjectTitleItem extends SubjectItem {
  String title;

  SubjectTitleItem(this.title);

  @override
  int itemType() => 1;
}

class SubjectTitleDelegate extends SubjectDelegate<SubjectTitleItem> {
  @override
  Widget create(SubjectTitleItem item) {
    return new Padding(
        padding: new EdgeInsets.all(20.0), child: new Text(item.title));
  }
}
