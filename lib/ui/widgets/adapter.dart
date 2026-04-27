import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/lib.dart';
import '../../data/lib.dart';
import 'rv.dart';
import 'styles.dart';
import 'tracked_status_provider.dart';
import 'dart:io' show Platform;

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
      [Animation<double>? animation]) {
    var widget = Padding(
      padding: insets,
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
            fontWeight: FontWeight.bold,
            fontFeatures: [const FontFeature.notationalForms(0)]),
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
      [Animation<double>? animation]) {
    return Padding(
        padding: const EdgeInsets.only(
            bottom: Dimens.spacingStandard,
            left: Dimens.spacingStandard,
            right: Dimens.spacingStandard),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const Padding(padding: EdgeInsets.all(Dimens.spacingXsmall)),
            Text(
              content,
              style: Theme.of(context).textTheme.labelMedium,
            )
          ],
        ));
  }
}

class SectionItem extends Item {
  SearchContext searchContext;
  late Section section;
  SubscriptionView? subscriptionView;

  bool hasTitle;
  bool canSlide;

  Function onSectionClicked;
  Function onItemDismissed;

  SectionItem(this.searchContext,
      {this.hasTitle = false,
      this.canSlide = false,
      this.subscriptionView,
      required this.onItemDismissed,
      required this.onSectionClicked})
      : super(searchContext.section!.callNumber) {
    section = searchContext.section!;
  }

  @override
  Widget create(BuildContext context, int position, int adapterPosition,
      [Animation<double>? animation]) {
    var table = Table(
      columnWidths: const {
        0: FlexColumnWidth(0.30),
        1: FlexColumnWidth(0.50),
        2: FlexColumnWidth(0.25)
      },
      children: section.meetings.map((meeting) {
        var time = "";
        if (meeting.startTime != "") {
          time = AppLocalizations.of(context)!
              .meetingTime(meeting.startTime, meeting.endTime);
        }
        return TableRow(
          children: <Widget>[
            Text(meeting.day,
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.labelMedium),
            Text(
              time,
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            Text(meeting.room.isEmpty ? meeting.classType : meeting.room,
                textAlign: TextAlign.end,
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.labelMedium),
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

      return AppLocalizations.of(context)!.professorList(acc, s);
    });

    Widget hotnessWidget = Container();

    if (subscriptionView != null) {
      String emoji;
      if (subscriptionView!.isHot) {
        emoji = "🔥🔥🔥";
      } else {
        emoji = "👀";
      }

      String hotnessText = "${subscriptionView!.subscribers} $emoji";

      hotnessWidget = Text(hotnessText,
          textAlign: TextAlign.start,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(fontWeight: FontWeight.bold));

      if (subscriptionView!.subscribers == 0) {
        hotnessWidget = Container();
      }
    }

    Widget bottomStack = Container();

    Widget instructorWidget = Container();

    if (instructors.isNotEmpty) {
      instructorWidget = Text(instructors,
          textAlign: TextAlign.end,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(fontWeight: FontWeight.bold));
    }

    bottomStack = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[hotnessWidget, instructorWidget],
    );

    Widget courseNameWidget = Container();

    if (hasTitle) {
      courseNameWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
              AppLocalizations.of(context)!.headerMessage(
                  searchContext.course!.name, searchContext.course!.number),
              maxLines: 1,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 14.0)),
          const SizedBox(height: Dimens.spacingXsmall),
        ],
      );
    }

    Widget navigationWidget = Container();

    navigationWidget = Positioned.fill(
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          onTap: () {
            var searchContext = getIt<SearchContext>();
            searchContext.updateWithAnother(this.searchContext);

            onSectionClicked(section);
          },
        ),
      ),
    );

    Widget widget = Container(
      margin: const EdgeInsets.only(
          left: Dimens.spacingStandard,
          right: Dimens.spacingStandard,
          top: 6.0,
          bottom: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow,
            blurRadius: 6.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(Dimens.spacingMedium),
            margin: const EdgeInsets.only(left: 60.0),
            child: Column(
              textBaseline: TextBaseline.ideographic,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                courseNameWidget,
                table,
                const SizedBox(height: Dimens.spacingXsmall),
                bottomStack,
              ],
            ),
          ),
          Container(
              height: 48.0,
              width: 48.0,
              margin: const EdgeInsets.all(Dimens.spacingMedium),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    section.status == AppLocalizations.of(context)!.openStatus
                        ? Colors.green
                        : Colors.red,
              ),
              child: Text(
                section.number,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              )),
          navigationWidget
        ],
      ),
    );

    if (canSlide) {
      // var actions = <Widget>[
      //   new IconSlideAction(
      //     caption: AppLocalizations.of(context)!.add,
      //     color: Colors.transparent,
      //     foregroundColor: Colors.black,
      //     icon: Icons.add,
      //     onTap: () =>
      //         Scaffold.of(context).showSnackBar(Widgets.makeSnackBar("onTap")),
      //   ),
      // ];

      // widget = Slidable(
      //   delegate: new SlidableDrawerDelegate(),
      //   actionExtentRatio: 0.25,
      //   child: widget,
      //   secondaryActions: actions,
      // );
      widget = Dismissible(
          onDismissed: (direction) {
            onItemDismissed(searchContext, this, position, adapterPosition);
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
      [Animation<double>? animation]) {
    Widget subscribeSwitch;

    if (Platform.isIOS) {
      subscribeSwitch = Padding(
        padding: const EdgeInsets.only(),
        child: CupertinoSwitch(
            value: statusProvider.trackedStatus(),
            onChanged: (value) {
              callback(statusProvider.trackedStatus());
            }),
      );
    } else {
      subscribeSwitch = Padding(
        padding: const EdgeInsets.only(),
        child: Switch(
          value: statusProvider.trackedStatus(),
          onChanged: (value) {
            callback(statusProvider.trackedStatus());
          },
        ),
      );
    }

    return Material(
        type: MaterialType.transparency,
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            callback(statusProvider.trackedStatus());
          },
          child: Container(
            height: 56.0,
            margin: const EdgeInsets.only(
                left: Dimens.spacingStandard, right: Dimens.spacingStandard),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Theme.of(context).dividerColor,
            ))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)!.subscribeReason,
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                subscribeSwitch
              ],
            ),
          ),
        ));
  }
}

class SpaceItem extends Item {
  final double height;
  final double width;

  SpaceItem({
    this.height = Dimens.spacingStandard,
    this.width = Dimens.spacingStandard,
  })  : assert(height >= 0.0),
        assert(width >= 0.0),
        super("");

  @override
  Widget create(BuildContext context, int position, int adapterPosition,
      [Animation<double>? animation]) {
    return SizedBox(height: height, width: width);
  }
}
