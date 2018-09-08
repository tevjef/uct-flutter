import '../../core/lib.dart';
import '../../data/lib.dart';

class OptionPresenter {
  OptionView view;
  UCTApiClient apiClient;
  HomeRouter router;
  RecentSelectionDao recentSelectionDatabase;
  PreferenceDao preferenceDao;
  SearchContext searchContext;

  Function optionClickCallback;

  OptionPresenter(this.view, this.router) {
    apiClient = new Injector().apiClient;
    searchContext = new Injector().searchContext;
    recentSelectionDatabase = new Injector().recentSelectionDatabase;
    preferenceDao = new Injector().preferenceDao;
  }

  void loadUniversities() async {
    view.showLoading(true);

    var universities = await apiClient.universities();
    var defaultUniversity = await getDefaultUniversity(universities);
    var defaultSemester = await getDefaultSemester(defaultUniversity);

    view.onOptionSuccess(universities);
    view.setSelectedUniversity(defaultUniversity.university);
    view.setSelectedSemester(defaultSemester.semester);

    view.showLoading(false);
  }

  Future<DefaultSemester> getDefaultSemester(
      DefaultUniversity defaultUniversity) async {
    var defaultSemester = await preferenceDao.getDefaultSemester();
    if (defaultSemester == null) {
      DefaultSemester ds = DefaultSemester();
      ds.semester = defaultUniversity.university.availableSemesters[0];
      defaultSemester = ds;
    }
    return defaultSemester;
  }

  Future<DefaultUniversity> getDefaultUniversity(
      List<University> universities) async {
    var defaultUniversity = await preferenceDao.getDefaultUniversity();

    if (defaultUniversity == null) {
      DefaultUniversity du = DefaultUniversity();
      du.university = universities[0];
      defaultUniversity = du;
    }
    return defaultUniversity;
  }

  void updateDefaultUniversity(University university) async {
    var du = await preferenceDao.insertUniversity(university);
    view.setSelectedUniversity(du.university);

    var ds = await getDefaultSemester(du);
    view.setSelectedSemester(ds.semester);
  }

  void updateDefaultSemester(Semester semester) async {
    var ds = await preferenceDao.insertSemester(semester);
    view.setSelectedSemester(ds.semester);
  }
}

abstract class OptionView {
  void setSelectedUniversity(University university);

  void setSelectedSemester(Semester semester);

  void onOptionSuccess(List<University> universities);

  void onOptionError(String message);

  void showLoading(bool isLoading);
}
