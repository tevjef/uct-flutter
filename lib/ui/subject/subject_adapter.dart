import 'package:flutter/material.dart';

import '../../data/proto/model.pb.dart';
import '../../dependency_injection.dart';
import '../home/home_router.dart';
import '../rv.dart';
import '../styles.dart';

class SubjectTitleItem extends Item {
  HomeRouter router;
  Subject subject;

  SubjectTitleItem(this.router, this.subject);

  @override
  int itemType() => 1;

   @override
  Widget create(BuildContext context) {
    final insets = new EdgeInsets.symmetric(
        horizontal: 32.0, vertical: Dimens.spacingStandard);

    return new InkWell(
      onTap: () {
        // Save current search location
        final searchContext = Injector().searchContext;
        searchContext.subject = subject;

        router.gotoCourses(context, subject.topicName);
      },
      child: new Container(
          padding: insets,
          child: new Text(
            "${subject.name} (${subject.number})",
            style: Styles.caption,
          )),
    );
  }
}