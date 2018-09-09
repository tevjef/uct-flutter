import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';
import 'option_presenter.dart';

class OptionPage extends StatefulWidget {
  OptionPage({Key key}) : super(key: key);

  @override
  OptionListState createState() => new OptionListState();
}

class OptionListState extends State<OptionPage> implements OptionView {
  OptionPresenter presenter;

  bool isLoading = true;

  List<University> universities = List();
  List<Semester> semesters = List();

  University selectedUniversity;
  Semester selectedSemester;

  OptionListState() {
    presenter = new OptionPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    presenter.loadUniversities();
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;

    if (isLoading) {
      widget = Widgets.makeLoading();
    } else {
      widget = DropdownButtonHideUnderline(
        child: ListView(
          padding: const EdgeInsets.all(Dimens.spacingStandard),
          children: <Widget>[
            new InputDecorator(
              decoration: const InputDecoration(
                labelText: 'University',
                hintText: 'Choose an university',
              ),
              isEmpty: selectedUniversity == null,
              child: new DropdownButton<University>(
                value: selectedUniversity,
                isDense: true,
                onChanged: (University newValue) {
                  presenter.updateDefaultUniversity(newValue);
                },
                items: universities.map((University value) {
                  return new DropdownMenuItem<University>(
                      value: value,
                      child: Container(
                          width: MediaQuery.of(context).size.width * .80,
                          child: new Text(
                            value.name,
                            overflow: TextOverflow.ellipsis,
                          )));
                }).toList(),
              ),
            ),
            new InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Semester',
                hintText: 'Choose an semester',
              ),
              isEmpty: selectedSemester == null ||
                  !semesters.contains(selectedSemester),
              child: new DropdownButton<Semester>(
                value: selectedSemester,
                isDense: true,
                onChanged: (Semester newValue) {
                  presenter.updateDefaultSemester(newValue);
                },
                items: semesters.map((Semester value) {
                  return new DropdownMenuItem<Semester>(
                    value: value,
                    child: new Text(
                      "${_upperCaseFirstLetter(value.season)} ${value.year}",
                      softWrap: true,
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: () {
        return Future<bool>.value(
            selectedUniversity != null && selectedSemester != null);
      },
      child: Scaffold(
        appBar: new AppBar(
          title: new Text("Options"),
          actions: <Widget>[
            IconButton(
                icon: new Icon(
                  Icons.check,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                }),
          ],
        ),
        body: widget,
      ),
    );
  }

  @override
  void onOptionError(String message) {
    setState(() {});
  }

  @override
  void onOptionSuccess(List<University> universities) {
    setState(() {
      this.universities = universities;
    });
  }

  String _upperCaseFirstLetter(String word) {
    return '${word.substring(0, 1).toUpperCase()}${word.substring(1).toLowerCase()}';
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
  void setSelectedUniversity(University university) {
    setState(() {
      this.selectedUniversity = university;
      this.semesters = university.availableSemesters;

      if (!semesters.contains(selectedSemester)) {
        selectedSemester = semesters[0];
      }
    });
  }

  @override
  void showLoading(bool isLoading) {
    setState(() {
      this.isLoading = isLoading;
    });
  }
}
