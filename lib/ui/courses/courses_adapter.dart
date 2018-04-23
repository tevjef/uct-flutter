import 'package:flutter/material.dart';

import '../../data/proto/model.pb.dart';
import '../../dependency_injection.dart';
import '../home/home_router.dart';
import '../rv.dart';
import '../styles.dart';

abstract class CourseItem extends Item {}

abstract class CourseDelegate<I extends CourseItem> extends Delegate<I> {}

class CourseAdapter extends Adapter<CourseItem> {
  HomeRouter router;

  CourseAdapter(HomeRouter router) {
    delegates[0] = HeaderDelegate();
    delegates[1] = CourseTitleDelegate(router);
  }
}

class HeaderItem extends CourseItem {
  String title;

  HeaderItem(this.title);

  @override
  int itemType() => 0;
}

class HeaderDelegate extends CourseDelegate<HeaderItem> {
  @override
  Widget create(BuildContext context, HeaderItem item) {
    return new Padding(
        padding: new EdgeInsets.all(Dimens.spacingStandard),
        child: new Text(
          item.title,
          style: Styles.sectionHeader,
        ));
  }
}

class CourseTitleItem extends CourseItem {
  String title;
  String number;
  int open;
  int total;
  Course course;

  CourseTitleItem(this.title, this.number, this.open, this.total, this.course);

  @override
  int itemType() => 1;
}

class CourseTitleDelegate extends CourseDelegate<CourseTitleItem> {
  HomeRouter router;

  CourseTitleDelegate(this.router);

  @override
  Widget create(BuildContext context, CourseTitleItem item) {
    double percent = 0.0;
    if (item.total != 0) {
      percent = item.open.toDouble() / item.total.toDouble();
    }

    return new Container(
      margin:
          new EdgeInsets.only(left: 16.0, right: 16.0, top: 6.0, bottom: 6.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: new Offset(0.0, 2.0),
          ),
        ],
      ),
      child: new Stack(
        children: <Widget>[
          new Container(
              padding: new EdgeInsets.all(12.0),
              child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      "${item.title} (${item.number})",
                      style: Styles.caption,
                      overflow: TextOverflow.fade,
                    ),
                    new Text(
                      "${item.open} open sections of ${item.total}",
                      style: Styles.body1Secondary,
                    )
                  ])),
          //https://github.com/flutter/flutter/issues/3782#issuecomment-309079424
          new Positioned.fill(
              child: new Material(
                  borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
                  color: Colors.transparent,
                  child: new Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: <Widget>[
                        new Container(
                          height: 4.0,
                          alignment: Alignment.bottomRight,
                          child: new FractionallySizedBox(
                            widthFactor: 1 - percent,
                            child: new Container(
                                padding: new EdgeInsets.all(4.0),
                                color: Colors.red),
                          ),
                        ),
                        new Container(
                          height: 4.0,
                          child: new FractionallySizedBox(
                            widthFactor: percent,
                            child: new Container(
                                padding: new EdgeInsets.all(4.0),
                                color: Colors.green),
                          ),
                        ),
                        new InkWell(
                          onTap: () {
                            // Save current search location
                            final searchContext = new Injector().searchContext;
                            searchContext.course = item.course;

                            router.gotoCourse(context, item.course);
                          },
                        )
                      ])))
        ],
      ),
    );
  }
}
