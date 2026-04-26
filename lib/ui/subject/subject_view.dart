import '../../core/lib.dart';
import '../widgets/lib.dart';
import 'subject_presenter.dart';

class SubjectPage extends StatefulWidget {
  SubjectPage({Key? key}) : super(key: key);

  @override
  SubjectListState createState() => new SubjectListState();
}

class SubjectListState extends State<SubjectPage> with LDEViewMixin implements SubjectView {
  late SubjectPresenter presenter;

  String title = "";

  SubjectListState() {
    presenter = new SubjectPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future<bool>.value(true);
      },
      child: Scaffold(
          key: scaffoldKey,
          appBar: new AppBar(
            leading: new IconButton(
                icon: new Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            title: Text(title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onBackground)),
            actions: <Widget>[
              IconButton(
                  icon: new Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  onPressed: () {
                    presenter.onSettingsClick();
                  }),
            ],
          ),
          body: AdSafeArea(child: makeRefreshingList(context))),
    );
  }

  @override
  void onUniversityNotSet() {
    Navigator.of(context).pushNamed(UCTRoutes.options).then((onValue) {
      refreshData();
    });
  }

  @override
  void setTitle(String title) {
    setState(() {
      this.title = title;
    });
  }

  @override
  void onRefreshData() {
    presenter.loadSubjects();
  }

  @override
  void navigateToOptions() {
    Navigator.of(context).pushNamed(UCTRoutes.options).then((changed) {
      refreshData();
    });
  }

  @override
  void navigateToCourse() {
    Navigator.of(context).pushNamed(UCTRoutes.courses).then((result) {
      refreshData();
    });
  }
}
