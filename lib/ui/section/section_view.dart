import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../data/proto/model.pb.dart';
import '../../dependency_injection.dart';
import '../search_context.dart';
import '../styles.dart';
import 'section_adapter.dart';
import 'section_presenter.dart';

class SectionPage extends StatelessWidget {
  final SearchContext searchContext = Injector().searchContext;

  SectionPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title =
        "${searchContext.course.name} (${searchContext.course.number})";

    var allSections = 0;
    var closedSections = 0;
    searchContext.course.sections.forEach((Section section) {
      if (section.status == "Closed") {
        closedSections++;
      }
      allSections++;
    });

    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        appBar: AppBar(
          leading: new IconButton(
              icon: new Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(
                  Icons.playlist_add,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
          title: new Container(
            child: new Text(title),
          ),
          bottom: PreferredSize(child: Text("AAAAAAAAAAAAAAAA"), preferredSize: Size.infinite),
        ),
      ),
    );
  }
}
