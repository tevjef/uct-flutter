import '../../data/UCTApiClient.dart';
import '../../dependency_injection.dart';
import 'subject_adapter.dart';

class SubjectPresenter {
  SubjectView view;
  UCTApiClient apiClient;

  SubjectPresenter(this.view) {
    apiClient = new Injector().apiClient;
  }

  void loadSubjects(String universityTopicName, season, year) {
    apiClient.subjects(universityTopicName, season, year).then((subjects) {
      List<SubjectItem> adapterItems = List();

      adapterItems.add(HeaderItem("RECENT"));
      adapterItems.add(SubjectTitleItem(subjects[0]));
      adapterItems.add(HeaderItem("ALL (${subjects.length})"));
      final addItems = subjects.map((subject) {
        return SubjectTitleItem(subject);
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
  void onSubjectSuccess(List<SubjectItem> adapterItems);

  void onSubjectError(String message);
}
