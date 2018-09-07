import 'package:flutter/material.dart';

import '../../data/proto/model.pb.dart';
import '../home/home_router.dart';
import 'option_presenter.dart';

class OptionPage extends StatefulWidget {
  final HomeRouter router;

  OptionPage({Key key, this.router}) : super(key: key);

  @override
  OptionListState createState() => new OptionListState(router);
}

class OptionListState extends State<OptionPage> implements OptionView {
  HomeRouter router;
  OptionPresenter presenter;

  bool isLoading = true;

  List<University> universities = List();
  List<Semester> semesters = List();

  University selectedUniversity;
  Semester selectedSemester;

  OptionListState(HomeRouter router) {
    this.router = router;
    presenter = new OptionPresenter(this, router);
  }

  @override
  void initState() {
    super.initState();
    presenter.loadUniversities();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return new Center(
          child: new Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: new CircularProgressIndicator(
                  backgroundColor: Colors.black)));
    } else {
      return WillPopScope(
        onWillPop: () {
          router.pop(context);
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
                    router.pop(context);
                  }),
            ],
          ),
          body: DropdownButtonHideUnderline(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
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
                          "${_upperCaseFirstLetter(value.season)} ${value
                              .year}",
                          softWrap: true,
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
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
    return '${word.substring(0, 1).toUpperCase()}${word.substring(1)
        .toLowerCase()}';
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
