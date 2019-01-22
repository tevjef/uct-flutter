import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';
import 'section_presenter.dart';

class SectionDetailsPage extends StatefulWidget {
  SectionDetailsPage({Key key}) : super(key: key);

  @override
  SectionDetailState createState() => SectionDetailState();
}

class SectionDetailState extends State<SectionDetailsPage>
    with LDEViewMixin
    implements SectionView {
  SearchContext searchContext;

  // Used to determine if the Home screen should be undated.
  bool initialTrackedStatus;
  bool isTracked = false;
  int numTrackedSections;

  SectionPresenter presenter;

  SectionDetailState() {
    searchContext = Injector.getInjector().get();
    presenter = SectionPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    presenter.loadSection();
  }

  @override
  Widget build(BuildContext context) {
    final title = S
        .of(context)
        .headerMessage(searchContext.course.name, searchContext.course.number);

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
                        Navigator.of(context)
                            .pop(initialTrackedStatus != isTracked);
                      }),
                  actions: <Widget>[
                    Widgets.makeIconWithBadge(numTrackedSections.toString(), () {
                      presenter.onTrackedSectionsClicked();
                    }),
                  ],
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
                                  S.of(context).section,
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
                                  S.of(context).index,
                                  style: Styles.sectionHeaderLight,
                                ),
                              ],
                            ),
                            buildCredits(section)
                          ],
                        ),
                      ),
                      preferredSize: Size.fromHeight(70.0)),
                ),
              ],
            ),
            preferredSize: Size.fromHeight(140.0)),
        body: makeListView());
  }

  Widget buildCredits(Section section) {
    var defaultCredits = 0.toDouble();
    var credits = double.parse(section.credits) ?? defaultCredits;
    if (credits == defaultCredits || credits == -1.0) {
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
          S.of(context).credits,
          style: Styles.sectionHeaderLight,
        ),
      ],
    );
  }

  @override
  void setSectionStatus(bool isTracked) {
    setState(() {
      if (initialTrackedStatus != null) {
        initialTrackedStatus = isTracked;
      }

      this.isTracked = isTracked;
    });
  }

  @override
  bool trackedStatus() => isTracked;

  @override
  void refreshData() {
    presenter.loadSection();
  }

  @override
  void onPopToTrackedSections() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        UCTRoutes.home, (Route<dynamic> route) => false);
  }

  @override
  void setNumTrackedSections(int numTrackedSections) {
    setState(() {
      this.numTrackedSections = numTrackedSections;
    });
  }
}
