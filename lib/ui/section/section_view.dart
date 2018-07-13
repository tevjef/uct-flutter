import 'package:flutter/material.dart';

import '../../data/proto/model.pb.dart';
import '../../dependency_injection.dart';
import '../home/home_router.dart';
import '../rv.dart';
import '../search_context.dart';
import '../styles.dart';
import 'section_presenter.dart';

class SectionDetailsPage extends StatefulWidget {
  final HomeRouter router;
  final SearchContext searchContext = Injector().searchContext;

  SectionDetailsPage({Key key, this.router}) : super(key: key);

  @override
  SectionDetailState createState() => SectionDetailState(router, searchContext);
}

class SectionDetailState extends State<SectionDetailsPage>
    implements SectionView {
  final SearchContext searchContext;
  final HomeRouter router;
  final Adapter adapter = Adapter();

  SectionPresenter presenter;
  Section section;
  bool isLoading = true;
  bool isTracked = false;
  Widget list;

  SectionDetailState(this.router, this.searchContext) {
    presenter = SectionPresenter(this, router);
    section = searchContext.section;
  }

  @override
  void initState() {
    super.initState();
    presenter.loadSection();
  }

  @override
  Widget build(BuildContext context) {
    final title =
        "${searchContext.course.name} (${searchContext.course.number})";

    final section = searchContext.section;

    return Scaffold(
        appBar: PreferredSize(
            child: Stack(
              alignment: const FractionalOffset(0.95, 1.22),
              children: <Widget>[
                AppBar(
                  leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  title: Container(
                    child: Text(title),
                  ),
                  bottom: PreferredSize(
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 72.0,
                            right: 72.0,
                            bottom: Dimens.spacingStandard),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  section.number,
                                  style: Styles.sectionLargeHeader,
                                ),
                                SizedBox(height: 6.0),
                                Text(
                                  "SECTION",
                                  style: Styles.sectionHeaderLight,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  section.callNumber,
                                  style: Styles.sectionLargeHeader,
                                ),
                                SizedBox(height: 6.0),
                                Text(
                                  "INDEX",
                                  style: Styles.sectionHeaderLight,
                                ),
                              ],
                            ),
                            buildCredits()
                          ],
                        ),
                      ),
                      preferredSize: Size.fromHeight(70.0)),
                ),
              ],
            ),
            preferredSize: Size.fromHeight(140.0)),
        body: getListView());
  }

  Widget buildCredits() {
    var defaultCredits = 0.toDouble();
    var credits = double.parse(section.credits) ?? defaultCredits;
    if (credits == defaultCredits) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          credits.round().toString(),
          style: Styles.sectionLargeHeader,
        ),
        SizedBox(height: 6.0),
        Text(
          "CREDITS",
          style: Styles.sectionHeaderLight,
        ),
      ],
    );
  }

  @override
  void onSectionError(String message) {
    // TODO: implement onSectionError
  }

  @override
  void onSectionSuccess(List<Item> adapterItems) {
    setState(() => this.adapter.swapData(adapterItems));
  }

  @override
  void setSectionStatus(bool isTracked) {
    setState(() => this.isTracked = isTracked);
  }

  Widget getListView() {
    return ListView.builder(
        itemCount: adapter.items.length,
        itemBuilder: (BuildContext context, int position) {
          return adapter.onCreateWidget(context, position);
        });
  }

  @override
  bool trackedStatus() => isTracked;
}
