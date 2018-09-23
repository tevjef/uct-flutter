import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../core/lib.dart';
import '../../data/lib.dart';
import 'rv.dart';
import 'shared.dart';
import 'styles.dart';
import 'tracked_status_provider.dart';

class HeaderItem extends Item {
  String title;
  EdgeInsets insets;

  HeaderItem(this.title,
      {this.insets = const EdgeInsets.only(
          left: Dimens.spacingStandard,
          top: Dimens.spacingMedium,
          bottom: Dimens.spacingMedium,
          right: Dimens.spacingStandard)})
      : super(title);

  @override
  Widget create(BuildContext context, int position, int adapterPosition,
      [Animation<double> animation]) {
    var widget = Padding(
      padding: insets,
      child: Text(
        title,
        style: Styles.sectionHeader,
      ),
    );

    if (animation != null) {
      return FadeTransition(
        opacity: animation,
        child: SizeTransition(
          sizeFactor: animation,
          child: widget,
        ),
      );
    } else {
      return widget;
    }
  }

  @override
  bool shouldAnimateRemove() => true;
}

class MetadataItem extends Item {
  String title;
  String content;

  MetadataItem(this.title, this.content) : super(content);

  @override
  Widget create(BuildContext context, int position, int adapterPosition,
      [Animation<double> animation]) {
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
  SearchContext searchContext;
  Section section;

  bool hasTitle;
  bool navigates;
  bool canSlide;

  Function onReturnFromNavigation;
  Function onItemDismissed;

  SectionItem(this.searchContext,
      {this.hasTitle = false,
      this.navigates = true,
      this.canSlide = false,
      this.onReturnFromNavigation,
      this.onItemDismissed})
      : super(searchContext.section.callNumber) {
    section = searchContext.section;
  }

  @override
  Widget create(BuildContext context, int position, int adapterPosition,
      [Animation<double> animation]) {
    var table = Table(
      columnWidths: {
        0: FlexColumnWidth(0.30),
        1: FlexColumnWidth(0.50),
        2: FlexColumnWidth(0.25)
      },
      children: section.meetings.map((meeting) {
        var time = "";
        if (meeting.startTime != "") {
          time = S.of(context).meetingTime(meeting.startTime, meeting.endTime);
        }
        return TableRow(
          children: <Widget>[
            Text(meeting.day,
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: Styles.body1Primary),
            Text(
              time,
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: Styles.body1Primary,
              textAlign: TextAlign.center,
            ),
            Text(meeting.room.isEmpty ? meeting.classType : meeting.room,
                textAlign: TextAlign.end,
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: Styles.body1Primary),
          ],
        );
      }).toList(),
    );

    String instructors = section.instructors.map((instructor) {
      return instructor.name;
    }).fold("", (acc, s) {
      if (acc == "") {
        return s;
      }

      return S.of(context).professorList(acc, s);
    });

    Widget instructorsWidget = Container();

    if (instructors.isNotEmpty) {
      instructorsWidget = Text(instructors,
          textAlign: TextAlign.end,
          style: Styles.body1Primary.copyWith(fontWeight: FontWeight.bold));
    }

    Widget courseNameWidget = Container();

    if (hasTitle) {
      courseNameWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
              S.of(context).headerMessage(
                  searchContext.course.name, searchContext.course.number),
              maxLines: 1,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: Styles.body1Primary
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 14.0)),
          SizedBox(height: Dimens.spacingXsmall),
        ],
      );
    }

    Widget navigationWidget = Container();

    if (navigates) {
      navigationWidget = Positioned.fill(
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              var searchContext = Injector.getInjector().get<SearchContext>();
              searchContext.updateWithAnother(this.searchContext);

              Navigator.of(context)
                  .pushNamed(UCTRoutes.section)
                  .then((changed) {
                if (onReturnFromNavigation != null) {
                  onReturnFromNavigation(changed);
                }
              });
            },
          ),
        ),
      );
    }

    Widget widget = Container(
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
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                courseNameWidget,
                table,
                SizedBox(height: Dimens.spacingXsmall),
                instructorsWidget,
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
                color: section.status == S.of(context).openStatus
                    ? Colors.green
                    : Colors.red,
              ),
              child: Text(
                section.number,
                textAlign: TextAlign.center,
                style: Styles.caption.copyWith(color: Colors.white),
              )),
          navigationWidget
        ],
      ),
    );

    if (canSlide) {
      var actions = <Widget>[
        new IconSlideAction(
          caption: S.of(context).add,
          color: Colors.transparent,
          foregroundColor: Colors.black,
          icon: Icons.add,
          onTap: () =>
              Scaffold.of(context).showSnackBar(Widgets.makeSnackBar("onTap")),
        ),
      ];

      widget = Slidable(
        delegate: new SlidableDrawerDelegate(),
        actionExtentRatio: 0.25,
        child: widget,
        secondaryActions: actions,
      );
    }

    if (onItemDismissed != null) {
      widget = Dismissible(
          onDismissed: (direction) {
            if (onItemDismissed != null) {
              onItemDismissed(searchContext, this, position, adapterPosition);
            }
          },
          key: Key(section.topicName),
          child: widget);
    }

    return widget;
  }
}

class SubscribeItem extends Item {
  final TrackedStatusProvider statusProvider;
  final Function callback;

  SubscribeItem(this.statusProvider, this.callback) : super("");

  @override
  Widget create(BuildContext context, int position, int adapterPosition,
      [Animation<double> animation]) {
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
                  S.of(context).subscribeReason,
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
  const DividerItem() : super("");

  @override
  Widget create(BuildContext context, int position, int adapterPosition,
      [Animation<double> animation]) {
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
        assert(width >= 0.0),
        super("");

  @override
  Widget create(BuildContext context, int position, int adapterPosition,
      [Animation<double> animation]) {
    return SizedBox(height: height, width: width);
  }
}
