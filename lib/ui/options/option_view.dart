import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';
import 'option_presenter.dart';

class OptionPage extends StatefulWidget {
  OptionPage({Key? key}) : super(key: key);

  @override
  OptionListState createState() => OptionListState();
}

class OptionListState extends State<OptionPage> with LDEViewMixin implements OptionView {
  late OptionPresenter presenter;

  List<University> universities = [];
  List<Semester> semesters = [];

  University? selectedUniversity;
  Semester? selectedSemester;

  OptionListState() {
    presenter = OptionPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    Widget universityButton = DropdownButton<University>(
      value: selectedUniversity,
      onChanged: (University? newValue) {
        presenter.updateDefaultUniversity(newValue!);
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

    Widget? semesterButton = null;
    if (selectedSemester != null && semesters.contains(selectedSemester)) {
      semesterButton = DropdownButton<Semester>(
        value: selectedSemester,
        onChanged: (Semester? newValue) {
          presenter.updateDefaultSemester(newValue!);
        },
        isDense: true,
        items: semesters.map((Semester value) {
          return DropdownMenuItem<Semester>(
            value: value,
            child: Text(
              AppLocalizations.of(context)!
                  .semesterFull(TextUtils.upperCaseFirstLetter(value.season), value.year.toString()),
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
                labelText: AppLocalizations.of(context)!.university,
                hintText: AppLocalizations.of(context)!.selectUniversity,
                helperText: AppLocalizations.of(context)!.selectUniversity,
              ),
              isEmpty: selectedUniversity == null || !universities.contains(selectedUniversity),
              child: universityButton),
        ),
        DropdownButtonHideUnderline(
          child: InputDecorator(
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.semester,
                  hintText: AppLocalizations.of(context)!.selectSemester,
                  helperText: AppLocalizations.of(context)!.selectSemester),
              isEmpty: selectedSemester == null || !semesters.contains(selectedSemester),
              child: semesterButton),
        )
      ],
    );

    Widget ldeWidget = makeRefreshingWidget(context, widget);

    return WillPopScope(
      onWillPop: () {
        showMessage(AppLocalizations.of(context)!.please_select_a_university);
        return Future<bool>.value(selectedUniversity != null && selectedSemester != null);
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          leading: new IconButton(
              icon: new Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: Text(AppLocalizations.of(context)!.options,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onBackground)),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.check,
                  color: Theme.of(context).colorScheme.onBackground,
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
  void setSelectedUniversity(University university, Semester? semester) {
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
