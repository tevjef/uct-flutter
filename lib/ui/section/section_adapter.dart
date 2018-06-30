import 'package:flutter/material.dart';

import '../../data/proto/model.pb.dart';
import '../rv.dart';
import '../styles.dart';

abstract class SectionDetailItem extends Item {}

abstract class CourseDelegate<I extends SectionDetailItem> extends Delegate<I> {
}

class SectionAdapter extends Adapter<SectionDetailItem> {
  SectionAdapter() {
    delegates[0] = MetadataDelegate();
  }
}

class MetadataItem extends SectionDetailItem {
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

class SectionItem extends SectionDetailItem {
  Section section;

  SectionItem(this.section);

  @override
  int itemType() => 1;
}
