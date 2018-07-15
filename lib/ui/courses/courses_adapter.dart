import 'package:flutter/material.dart';

import '../../data/proto/model.pb.dart';
import '../../dependency_injection.dart';
import '../home/home_router.dart';
import '../rv.dart';
import '../styles.dart';

class CourseTitleItem extends Item {
  Course course;
  Function callback;

  CourseTitleItem(
      this.course,
      this.callback) : super(course.hashCode);

  @override
  int itemType() => 1;

  @override
  Widget create(BuildContext context, int position) {
    int total = course.sections.length;
    int open = 0;
    course.sections.forEach((section) {
      if (section.status == "Open") {
        open++;
      }
    });

    double percent = 0.0;
    if (total != 0) {
      percent = open.toDouble() / total.toDouble();
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
                      "${course.name} (${course.number})",
                      style: Styles.caption,
                      overflow: TextOverflow.fade,
                    ),
                    new Text(
                      "${open} open sections of ${total}",
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
                           callback(context, course);
                          },
                        )
                      ])))
        ],
      ),
    );
  }
}