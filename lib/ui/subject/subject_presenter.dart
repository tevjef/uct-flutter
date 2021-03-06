import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';
import 'subject_adapter.dart';

class SubjectPresenter extends BasePresenter<SubjectView> {
  UCTApiClient apiClient;
  RecentSelectionDao recentSelectionDatabase;
  SearchContext searchContext;
  PreferenceDao preferenceDao;
  AnalyticsLogger analyticsLogger;
  AdInitializer adInitializer;

  SubjectPresenter(SubjectView view) : super(view) {
    final injector = Injector.getInjector();
    apiClient = injector.get();
    analyticsLogger = injector.get();
    searchContext = injector.get();
    searchContext.reset();
    adInitializer = injector.get();

    adInitializer.showBanner(true);

    recentSelectionDatabase = injector.get();
    preferenceDao = injector.get();
  }

  void loadSubjects() async {
    var defaultUniversity = await preferenceDao.getDefaultUniversity();
    var defaultSemester = await preferenceDao.getDefaultSemester();

    if (defaultUniversity == null || defaultSemester == null) {
      view.onUniversityNotSet();
      return;
    }

    searchContext.university = defaultUniversity.university;
    searchContext.semester = defaultSemester.semester;

    try {
      var subjects = await apiClient.subjects(
          defaultUniversity.university.topicName,
          defaultSemester.semester.season.toString(),
          defaultSemester.semester.year.toString());

      updateSubjectList(subjects);

      view.setTitle(S.of(context).subjectTitle(
          defaultUniversity.university.abbr,
          TextUtils.upperCaseFirstLetter(
              defaultSemester.semester.season.toString()),
          defaultSemester.semester.year.toString()));
    } catch (e) {
      view.showErrorMessage(e, loadSubjects);
      return;
    }
  }

  void updateSubjectList(List<Subject> subjects) async {
    var recentSubjectSelections = await recentSelectionDatabase
        .getRecentSubjectSelection(searchContext.searchTopicName);

    List<Item> adapterItems = List();

    // Find all the subjects in the list that are have matching entries in the
    // database for the this subject's particular topic name.
    var recentSubjects = subjects.where((it) {
      return recentSubjectSelections.any((recentSelection) {
        return it.topicName == recentSelection.topicName;
      });
    });

    // Subject click callback function
    Function subjectClickCallback = (context, Subject subject) {
      searchContext.updateWith(subject: subject);
      addToRecent(subject.topicName);

      var parameters = {AKeys.IS_RECENT: recentSubjects.contains(subject)};
      analyticsLogger.logEvent(AKeys.EVENT_SUBJECT_CLICKED,
          parameters: parameters);

      view.navigateToCourse();
    };

    // Build list of recent subject that have been clicked.
    var recentSubjectItems = recentSubjects.map((subject) {
      return SubjectTitleItem(subject, subjectClickCallback, hasLabel: false);
    });

    // Add header and all the recent items to the adapter.
    if (recentSubjectItems.isNotEmpty) {
      adapterItems.add(HeaderItem(S.of(context).recents));
      adapterItems.addAll(recentSubjectItems);
    }

    // Add header for all the items in the subject list.
    adapterItems
        .add(HeaderItem(S.of(context).allMeta(subjects.length.toString())));

    // Add all the items for the subject list
    adapterItems.addAll(subjects.map((subject) {
      return SubjectTitleItem(subject, subjectClickCallback);
    }));

    view.setListData(adapterItems);
    view.showLoading(false);
  }

  void addToRecent(String subjectTopicName) async {
    var recentSelection = RecentSelection();
    recentSelection.topicName = subjectTopicName;
    recentSelection.parentTopicName = searchContext.searchTopicName;
    recentSelection =
        await recentSelectionDatabase.insertSubjectSelection(recentSelection);
  }

  @override
  void onInitState() {
    super.onInitState();
    loadSubjects();
  }

  void onSettingsClick() {
    analyticsLogger.logEvent(AKeys.EVENT_SETTINGS_CLICKED);
    view.navigateToOptions();
  }
}

abstract class SubjectView extends BaseView {
  void setTitle(String title);
  void onUniversityNotSet();
  void navigateToOptions();
  void navigateToCourse();
}
