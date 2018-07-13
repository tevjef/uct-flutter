import 'package:flutter/material.dart';

import '../../data/proto/model.pb.dart';
import '../../dependency_injection.dart';
import '../home/home_router.dart';
import '../rv.dart';
import '../styles.dart';
import '../tracked_status_provider.dart';

class HeaderItem extends Item {
  String title;

  HeaderItem(this.title);

  @override
  int itemType() => 0;

  @override
  Widget create(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(Dimens.spacingStandard),
        child: Text(
          title,
          style: Styles.sectionHeader,
        ));
  }
}

class MetadataItem extends Item {
  String title;
  String content;

  MetadataItem(this.title, this.content);

  @override
  int itemType() => 0;

  @override
  Widget create(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            bottom: Dimens.spacingStandard,
            left: Dimens.spacingStandard,
            right: Dimens.spacingStandard),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title.toUpperCase(),
              style: Styles.sectionHeader,
            ),
            Padding(padding: EdgeInsets.all(Dimens.spacingXsmall)),
            Text(
              content,
              style: Styles.body1Primary,
            )
          ],
        ));
  }
}

class SectionItem extends Item {
  HomeRouter router;
  Section section;

  SectionItem(this.section, this.router);

  @override
  int itemType() => 1;

  @override
  Widget create(BuildContext context) {
    var table = Table(
      columnWidths: {
        0: FlexColumnWidth(0.30),
        1: FlexColumnWidth(0.50),
        2: FlexColumnWidth(0.25)
      },
      children: section.meetings.map((meeting) {
        var time = "";
        if (meeting.startTime != "") {
          time = "${meeting.startTime} - ${meeting.endTime}";
        }
        return TableRow(
          children: <Widget>[
            Text(meeting.day, style: Styles.body1Primary),
            Text(time,
                style: Styles.body1Primary, textAlign: TextAlign.center,),
            Text(meeting.room.isEmpty ? meeting.classType : meeting.room,
                textAlign: TextAlign.end,
                style: Styles.body1Primary),
          ],
        );
      }).toList(),
    );

    var instructors = section.instructors.map((instructor) {
      return instructor.name;
    }).fold("", (acc, s) {
      if (acc == "") {
        return s;
      }

      return acc + " | " + s;
    });


    return Container(
      margin: EdgeInsets.only(
          left: Dimens.spacingStandard,
          right: Dimens.spacingStandard,
          top: 6.0,
          bottom: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(Dimens.spacingMedium),
            margin: EdgeInsets.only(left: 60.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                table,
                SizedBox(height: Dimens.spacingXsmall),
                Text(instructors,
                    textAlign: TextAlign.end,
                    style: Styles.body1Primary
                        .copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Container(
              height: 48.0,
              width: 48.0,
              margin: EdgeInsets.all(Dimens.spacingMedium),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: section.status == "Open" ? Colors.green : Colors.red,
              ),
              child: Text(
                section.number,
                textAlign: TextAlign.center,
                style: Styles.caption.copyWith(color: Colors.white),
              )),
          Positioned.fill(
              child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      // Save current search location
                      final searchContext = Injector().searchContext;
                      searchContext.section = section;

                      router.gotoSection(context, section);
                    },
                  )))
        ],
      ),
    );
  }
}

class SubscribeItem extends Item {
  final TrackedStatusProvider statusProvider;
  final Function callback;

  SubscribeItem(this.statusProvider, this.callback);

  @override
  int itemType() => 3;

  @override
  Widget create(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            callback(statusProvider.trackedStatus());
          },
          child: Container(
            height: 56.0,
            margin: EdgeInsets.only(left: Dimens.spacingStandard),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Theme.of(context).dividerColor,
            ))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Subscribe to recieve notifications",
                  textAlign: TextAlign.start,
                  style: Styles.caption.copyWith(color: Colors.black),
                ),
                Switch(
                    value: statusProvider.trackedStatus(),
                    onChanged: (value) {
                      callback(statusProvider.trackedStatus());
                    })
              ],
            ),
          ),
        ));
  }
}

class DividerItem extends Item {
  @override
  int itemType() => 3;

  @override
  Widget create(BuildContext context) {
    return Divider(
      indent: Dimens.spacingStandard,
    );
  }
}

class SpaceItem extends Item {
  final double height;
  final double width;

  SpaceItem({
    this.height: Dimens.spacingStandard,
    this.width: Dimens.spacingStandard,
  })  : assert(height >= 0.0),
        assert(width >= 0.0);

  @override
  int itemType() => 3;

  @override
  Widget create(BuildContext context) {
    return SizedBox(height: height, width: width);
  }
}
