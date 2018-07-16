import '../../data/UCTApiClient.dart';
import '../../data/db/recent.dart';
import '../../data/proto/model.pb.dart';
import '../../dependency_injection.dart';
import '../home/home_router.dart';
import '../rv.dart';
import '../search_context.dart';
import '../widgets/adapter.dart';
import 'subject_adapter.dart';

class SubjectPresenter {
  SubjectView view;
  UCTApiClient apiClient;
  HomeRouter router;
  RecentSelectionDao recentSelectionDatabase;
  SearchContext searchContext;

  List<Subject> subjects;

  Function subjectClickCallback;

  SubjectPresenter(this.view, this.router) {
    apiClient = new Injector().apiClient;
    searchContext = new Injector().searchContext;
    recentSelectionDatabase = new Injector().recentSelectionDatabase;

    subjectClickCallback = (context, Subject subject) {
      searchContext.subject = subject;
      addToRecent(subject.topicName);
      router.gotoCourses(context, subject.topicName);
      updateSubjectList();
    };
  }

  void loadSubjects(String universityTopicName, season, year) async {
    apiClient.subjects(universityTopicName, season, year).then((subjects) {
      this.subjects = subjects;
      updateSubjectList();
    }).catchError((onError) {
      print(onError);
      view.onSubjectError(onError.toString());
    });
  }

  void updateSubjectList() async {
    var recent = await recentSelectionDatabase
        .getRecentSubjectSelection(searchContext.searchTopicName);

    List<Item> adapterItems = List();


    var recentSubjects = subjects.where((it) {
      return recent.any((recentSelection) {
        return it.topicName == recentSelection.topicName;
      });
    });

    var recentSubjectItems = recentSubjects.map((subject) {
      return SubjectTitleItem(subject, subjectClickCallback);
    });

    if (recentSubjectItems.isNotEmpty) {
      adapterItems.add(HeaderItem("RECENT"));
    }

    adapterItems.addAll(recentSubjectItems);

    adapterItems.add(HeaderItem("ALL (${subjects.length})"));
    final addItems = subjects.map((subject) {
      return SubjectTitleItem(subject, subjectClickCallback);
    });

    adapterItems.addAll(addItems);
    view.onSubjectSuccess(adapterItems);
  }

  void addToRecent(String subjectTopicName) async {
    var recentSelection = RecentSelection();
    recentSelection.topicName = subjectTopicName;
    recentSelection.parentTopicName = searchContext.searchTopicName;
    recentSelection =
        await recentSelectionDatabase.insertSubjectSelection(recentSelection);
  }
}

abstract class SubjectView {
  void onSubjectSuccess(List<Item> adapterItems);

  void onSubjectError(String message);
}
