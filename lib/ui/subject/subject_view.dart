import '../../core/lib.dart';
import '../widgets/lib.dart';
import 'subject_presenter.dart';

class SubjectPage extends StatefulWidget {
  SubjectPage({Key key}) : super(key: key);

  @override
  SubjectListState createState() => new SubjectListState();
}

class SubjectListState extends State<SubjectPage>
    with LDEViewMixin
    implements SubjectView {
  SubjectPresenter presenter;

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
            title: new Text(title),
            actions: <Widget>[
              IconButton(
                  icon: new Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(UCTRoutes.options)
                        .then((bool) {
                      presenter.loadSubjects();
                    });
                  }),
            ],
          ),
          body: makeRefreshingList()),
    );
  }

  @override
  void onUniversityNotSet() {
    Navigator.of(context).pushNamed(UCTRoutes.options).then((onValue) {
      handleRefresh();
    });
  }

  @override
  void setTitle(String title) {
    setState(() {
      this.title = title;
    });
  }

  @override
  void refreshData() {
    presenter.loadSubjects();
  }
}
