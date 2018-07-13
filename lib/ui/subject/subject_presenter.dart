import '../../data/UCTApiClient.dart';
import '../../dependency_injection.dart';
import 'subject_adapter.dart';
import '../widgets/adapter.dart';
import '../rv.dart';
import '../home/home_router.dart';

class SubjectPresenter {
  SubjectView view;
  UCTApiClient apiClient;
  HomeRouter router;

  SubjectPresenter(this.view, this.router) {
    apiClient = new Injector().apiClient;
  }

  void loadSubjects(String universityTopicName, season, year) {
    apiClient.subjects(universityTopicName, season, year).then((subjects) {
      List<Item> adapterItems = List();

      adapterItems.add(HeaderItem("RECENT"));
      adapterItems.add(SubjectTitleItem(router, subjects[0]));
      adapterItems.add(HeaderItem("ALL (${subjects.length})"));
      final addItems = subjects.map((subject) {
        return SubjectTitleItem(router, subject);
      });

      adapterItems.addAll(addItems);
      view.onSubjectSuccess(adapterItems);
    }).catchError((onError) {
      print(onError);
      view.onSubjectError(onError.toString());
    });
  }
}

abstract class SubjectView {
  void onSubjectSuccess(List<Item> adapterItems);

  void onSubjectError(String message);
}
