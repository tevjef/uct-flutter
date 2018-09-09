import '../../core/lib.dart';
import '../widgets/lib.dart';
import 'subject_presenter.dart';

class SubjectPage extends StatefulWidget {
  SubjectPage({Key key}) : super(key: key);

  @override
  SubjectListState createState() => new SubjectListState();
}

class SubjectListState extends State<SubjectPage> implements SubjectView {
  SubjectPresenter presenter;
  Adapter adapter = Adapter();
  bool isLoading;
  Widget list;
  String title = "";

  bool initialied = true;

  SubjectListState() {
    presenter = new SubjectPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    presenter.loadSubjects();
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;

    if (!initialied) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pushNamed(UCTRoutes.options).then((onValue) {
          presenter.loadSubjects();
        });
        setState(() {
          initialied = true;
        });
      });

      widget = Widgets.makeLoading();
    } else {
      if (isLoading) {
        widget = Widgets.makeLoading();
      } else {
        widget = getListView();
      }
    }

    return WillPopScope(
      onWillPop: () {
        return Future<bool>.value(true);
      },
      child: Scaffold(
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
          body: widget),
    );
  }

  @override
  void onSubjectError(String message) {
    setState(() {
      this.isLoading = false;
    });
  }

  @override
  void onSubjectSuccess(List<Item> adapterItems) {
    setState(() {
      this.isLoading = false;
      initialied = true;
      this.adapter.swapData(adapterItems);
    });
  }

  Widget getListView() => ListView.builder(
      padding: EdgeInsets.only(top: Dimens.spacingMedium),
      itemCount: adapter.getItemCount(),
      itemBuilder: adapter.onCreateWidget);

  @override
  void onDefaultError() {
    setState(() {
      initialied = false;
    });
  }

  @override
  void setTitle(String title) {
    setState(() {
      this.title = title;
    });
  }
}
