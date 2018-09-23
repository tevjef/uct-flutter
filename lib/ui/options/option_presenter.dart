import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';

class OptionPresenter extends BasePresenter<OptionView> {
  UCTApiClient apiClient;
  RecentSelectionDao recentSelectionDatabase;
  PreferenceDao preferenceDao;
  SearchContext searchContext;

  Function optionClickCallback;

  OptionPresenter(OptionView view) : super(view) {
    final injector = Injector.getInjector();
    apiClient = injector.get();
    searchContext = injector.get();
    recentSelectionDatabase = injector.get();
    preferenceDao = injector.get();
  }

  @override
  void onInitState() {
    super.onInitState();
    loadUniversities();
  }

  void loadUniversities() async {
    var universities = await apiClient.universities();
    var defaultUniversity = await _getDefaultUniversity(universities);
    var defaultSemester = await _getDefaultSemester(defaultUniversity);

    view.onOptionSuccess(universities);
    view.setSelectedUniversity(
        defaultUniversity.university, defaultSemester?.semester);

    view.showLoading(false);
  }

  Future<DefaultSemester> _getDefaultSemester(
      DefaultUniversity defaultUniversity) async {
    var defaultSemester = await preferenceDao.getDefaultSemester();
    if (defaultSemester == null && defaultUniversity.university != null) {
      DefaultSemester ds = DefaultSemester();
      ds.semester = defaultUniversity.university.availableSemesters[0];
      defaultSemester = ds;
      await preferenceDao.insertSemester(ds.semester);
    }

    // There is a semester and university
    if (defaultSemester != null &&
        defaultUniversity.university != null &&
        !defaultUniversity.university.availableSemesters
            .contains(defaultSemester.semester)) {
      DefaultSemester ds = DefaultSemester();
      ds.semester = defaultUniversity.university.availableSemesters[0];
      defaultSemester = ds;
      await preferenceDao.insertSemester(ds.semester);
    }
    return defaultSemester;
  }

  Future<DefaultUniversity> _getDefaultUniversity(
      List<University> universities) async {
    var defaultUniversity = await preferenceDao.getDefaultUniversity();

    if (defaultUniversity == null) {
      DefaultUniversity du = DefaultUniversity();
      defaultUniversity = du;
    }
    return defaultUniversity;
  }

  void updateDefaultUniversity(University university) async {
    var du = await preferenceDao.insertUniversity(university);
    var ds = await _getDefaultSemester(du);

    view.setSelectedUniversity(du.university, ds.semester);
  }

  void updateDefaultSemester(Semester semester) async {
    var ds = await preferenceDao.insertSemester(semester);
    view.setSelectedSemester(ds.semester);
  }
}

abstract class OptionView extends BaseView {
  void setSelectedUniversity(University university, Semester semester);

  void setSelectedSemester(Semester semester);

  void onOptionSuccess(List<University> universities);
}
