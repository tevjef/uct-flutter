import 'package:flutter/material.dart';

import '../../data/proto/model.pb.dart';
import '../rv.dart';
import '../styles.dart';

abstract class CourseItem extends Item {}

abstract class CourseDelegate<I extends CourseItem> extends Delegate<I> {}

class CourseAdapter extends Adapter<CourseItem> {
  CourseAdapter() {
    delegates[0] = MetadataDelegate();
    delegates[1] = SectionDelegate();
  }
}

class MetadataItem extends CourseItem {
  String title;
  String content;

  MetadataItem(this.title, this.content);

  @override
  int itemType() => 0;
}

class MetadataDelegate extends CourseDelegate<MetadataItem> {
  @override
  Widget create(BuildContext context, MetadataItem item) {
    return new Padding(
        padding: new EdgeInsets.only(
            bottom: Dimens.spacingStandard,
            left: Dimens.spacingStandard,
            right: Dimens.spacingStandard),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              item.title.toUpperCase(),
              style: Styles.sectionHeader,
            ),
            new Padding(padding: new EdgeInsets.all(Dimens.spacingXsmall)),
            new Text(
              item.content,
              style: Styles.body1Primary,
            )
          ],
        ));
  }
}

class SectionItem extends CourseItem {
  Section section;

  SectionItem(this.section);

  @override
  int itemType() => 1;
}

class SectionDelegate extends CourseDelegate<SectionItem> {
  @override
  Widget create(BuildContext context, SectionItem item) {
    List<Widget> meetings = List();
    for (Meeting meeting in item.section.meetings) {
      meetings.add(new Container(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
            new Text(meeting.day, style: Styles.body1Primary),
            new Text("${meeting.startTime} ${meeting.endTime}",
                style: Styles.body1Primary),
            new Text(meeting.room.isEmpty ? meeting.classType : meeting.room,
                style: Styles.body1Primary),
          ])));
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
            padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.only(left: 60.0),
            child: new Column(
              children: meetings,
            ),
          ),
          new Container(
              height: 48.0,
              width: 48.0,
              margin: EdgeInsets.all(12.0),
              alignment: Alignment.center,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                color:
                    item.section.status == "Open" ? Colors.green : Colors.red,
              ),
              child: new Text(
                item.section.number,
                textAlign: TextAlign.center,
                style: Styles.caption.copyWith(color: Colors.white),
              )),
          new Positioned.fill(
              child: new Material(
                  borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
                  color: Colors.transparent,
                  child: new InkWell(
                    onTap: () {
                      // Save current search location
                    },
                  )))
        ],
      ),
    );
  }
}
