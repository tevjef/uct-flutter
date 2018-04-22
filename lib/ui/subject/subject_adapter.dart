import 'package:flutter/material.dart';

import '../../data/proto/model.pb.dart';
import '../../dependency_injection.dart';
import '../home/home_router.dart';
import '../rv.dart';
import '../styles.dart';

abstract class SubjectItem extends Item {}

abstract class SubjectDelegate<I extends SubjectItem> extends Delegate<I> {}

class SubjectAdapter extends Adapter<SubjectItem> {
  HomeRouter router;

  SubjectAdapter(HomeRouter router) {
    this.router = router;
    delegates[0] = HeaderDelegate();
    delegates[1] = SubjectTitleDelegate(router);
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
  Widget create(BuildContext context, HeaderItem item) {
    return new Padding(
        padding: new EdgeInsets.all(Dimens.spacingStandard),
        child: new Text(
          item.title,
          style: Styles.sectionHeader,
        ));
  }
}

class SubjectTitleItem extends SubjectItem {
  Subject subject;

  SubjectTitleItem(this.subject);

  @override
  int itemType() => 1;
}

class SubjectTitleDelegate extends SubjectDelegate<SubjectTitleItem> {
  HomeRouter router;

  SubjectTitleDelegate(this.router);

  @override
  Widget create(BuildContext context, SubjectTitleItem item) {
    final insets = new EdgeInsets.symmetric(
        horizontal: 32.0, vertical: Dimens.spacingStandard);

    return new InkWell(
      onTap: () {
        // Save current search location
        final searchContext = Injector().searchContext;
        searchContext.subject = item.subject;

        router.gotoCourses(context, item.subject.topicName);
      },
      child: new Container(
          padding: insets,
          child: new Text(
            "${item.subject.name} (${item.subject.number})",
            style: Styles.caption,
          )),
    );
  }
}
