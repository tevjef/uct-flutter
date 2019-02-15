import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';
import 'option_presenter.dart';

class OptionPage extends StatefulWidget {
  OptionPage({Key key}) : super(key: key);

  @override
  OptionListState createState() => OptionListState();
}

class OptionListState extends State<OptionPage>
    with LDEViewMixin
    implements OptionView {
  OptionPresenter presenter;

  List<University> universities = List();
  List<Semester> semesters = List();

  University selectedUniversity;
  Semester selectedSemester;

  OptionListState() {
    presenter = OptionPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    Widget universityButton = DropdownButton<University>(
      value: selectedUniversity,
      onChanged: (University newValue) {
        presenter.updateDefaultUniversity(newValue);
      },
      isDense: true,
      items: universities.map((University value) {
        return DropdownMenuItem<University>(
            value: value,
            child: Container(
                width: MediaQuery.of(context).size.width * .80,
                child: Text(
                  value.name,
                  overflow: TextOverflow.ellipsis,
                )));
      }).toList(),
    );

    Widget semesterButton;
    if (selectedSemester != null && semesters.contains(selectedSemester)) {
      semesterButton = DropdownButton<Semester>(
        value: selectedSemester,
        onChanged: (Semester newValue) {
          presenter.updateDefaultSemester(newValue);
        },
        isDense: true,
        items: semesters.map((Semester value) {
          return DropdownMenuItem<Semester>(
            value: value,
            child: Text(
              S.of(context).semesterFull(
                  TextUtils.upperCaseFirstLetter(value.season),
                  value.year.toString()),
              softWrap: true,
            ),
          );
        }).toList(),
      );
    }

    Widget widget = ListView(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingStandard),
      children: <Widget>[
        DropdownButtonHideUnderline(
          child: InputDecorator(
              decoration: InputDecoration(
                labelText: S.of(context).university,
                hintText: S.of(context).selectUniversity,
                helperText: S.of(context).selectUniversity,
              ),
              isEmpty: selectedUniversity == null ||
                  !universities.contains(selectedUniversity),
              child: universityButton),
        ),
        DropdownButtonHideUnderline(
          child: InputDecorator(
              decoration: InputDecoration(
                  labelText: S.of(context).semester,
                  hintText: S.of(context).selectSemester,
                  helperText: S.of(context).selectSemester),
              isEmpty: selectedSemester == null ||
                  !semesters.contains(selectedSemester),
              child: semesterButton),
        )
      ],
    );

    Widget ldeWidget = makeRefreshingWidget(widget);

    return WillPopScope(
      onWillPop: () {
        showMessage(S.of(context).please_select_a_university);
        return Future<bool>.value(
            selectedUniversity != null && selectedSemester != null);
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(S.of(context).options),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.check,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                }),
          ],
        ),
        body: ldeWidget,
      ),
    );
  }

  @override
  void onOptionSuccess(List<University> universities) {
    setState(() {
      this.universities = universities;
    });
  }

  @override
  void setSelectedSemester(Semester semester) {
    if (semesters.contains(semester)) {
      setState(() {
        this.selectedSemester = semester;
      });
    }
  }

  @override
  void setSelectedUniversity(University university, Semester semester) {
    if (university == null) {
      return;
    }

    setState(() {
      this.selectedUniversity = university;
      this.semesters = university.availableSemesters;
      this.selectedSemester = semester;
    });
  }

  @override
  void onRefreshData() {
    presenter.loadUniversities();
  }
}
