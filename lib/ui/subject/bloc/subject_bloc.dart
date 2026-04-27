import '../../../core/lib.dart';
import '../../../data/lib.dart';
import '../../widgets/lib.dart';
import '../subject_adapter.dart';

// --- Events ---

sealed class SubjectEvent extends Equatable {
  const SubjectEvent();

  @override
  List<Object?> get props => [];
}

class SubjectLoadRequested extends SubjectEvent {
  const SubjectLoadRequested();
}

class SubjectSelected extends SubjectEvent {
  final Subject subject;

  const SubjectSelected({required this.subject});

  @override
  List<Object?> get props => [subject];
}

class SubjectSettingsClicked extends SubjectEvent {
  const SubjectSettingsClicked();
}

// --- States ---

sealed class SubjectState extends Equatable {
  final int? timestamp;
  const SubjectState({this.timestamp});

  @override
  List<Object?> get props => [timestamp];
}

class SubjectInitial extends SubjectState {
  const SubjectInitial({super.timestamp});
}

class SubjectLoading extends SubjectState {
  const SubjectLoading({super.timestamp});
}

class SubjectLoaded extends SubjectState {
  final List<Item> items;
  final String title;

  const SubjectLoaded(
      {required this.items, required this.title, super.timestamp});

  @override
  List<Object?> get props => [items, title, timestamp];
}

class SubjectUniversityNotSet extends SubjectState {
  const SubjectUniversityNotSet({super.timestamp});
}

class SubjectError extends SubjectState {
  final String message;

  const SubjectError({required this.message, super.timestamp});

  @override
  List<Object?> get props => [message, timestamp];
}

// --- Navigation Side Effects ---

sealed class SubjectNavigation {
  const SubjectNavigation();
}

class SubjectNavigateToOptions extends SubjectNavigation {
  const SubjectNavigateToOptions();
}

class SubjectNavigateToCourse extends SubjectNavigation {
  const SubjectNavigateToCourse();
}

// --- BLoC ---

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  final UCTApiClient apiClient;
  final RecentSelectionDao recentSelectionDatabase;
  final SearchContext searchContext;
  final PreferenceDao preferenceDao;
  final AnalyticsLogger analyticsLogger;
  final AdInitializer adInitializer;

  SubjectNavigation? _pendingNavigation;
  SubjectNavigation? consumeNavigation() {
    final nav = _pendingNavigation;
    _pendingNavigation = null;
    return nav;
  }

  SubjectState _cloneStateWithNewTimestamp(SubjectState state) {
    final newTimestamp = DateTime.now().millisecondsSinceEpoch;
    if (state is SubjectInitial) {
      return SubjectInitial(timestamp: newTimestamp);
    } else if (state is SubjectLoading) {
      return SubjectLoading(timestamp: newTimestamp);
    } else if (state is SubjectLoaded) {
      return SubjectLoaded(
        items: state.items,
        title: state.title,
        timestamp: newTimestamp,
      );
    } else if (state is SubjectUniversityNotSet) {
      return SubjectUniversityNotSet(timestamp: newTimestamp);
    } else if (state is SubjectError) {
      return SubjectError(message: state.message, timestamp: newTimestamp);
    }
    return state;
  }

  SubjectBloc({
    required this.apiClient,
    required this.recentSelectionDatabase,
    required this.searchContext,
    required this.preferenceDao,
    required this.analyticsLogger,
    required this.adInitializer,
  }) : super(const SubjectInitial()) {
    on<SubjectLoadRequested>(_onLoadSubjects);
    on<SubjectSelected>(_onSubjectSelected);
    on<SubjectSettingsClicked>(_onSettingsClicked);
  }

  Future<void> _onLoadSubjects(
    SubjectLoadRequested event,
    Emitter<SubjectState> emit,
  ) async {
    if (state is! SubjectLoaded) {
      emit(const SubjectLoading());
    }

    var defaultUniversity = await preferenceDao.getDefaultUniversity();
    var defaultSemester = await preferenceDao.getDefaultSemester();

    if (defaultUniversity == null || defaultSemester == null) {
      emit(const SubjectUniversityNotSet());
      return;
    }

    searchContext.university = defaultUniversity.university;
    searchContext.semester = defaultSemester.semester;

    try {
      var subjects = await apiClient.subjects(
          defaultUniversity.university!.topicName,
          defaultSemester.semester!.season.toString(),
          defaultSemester.semester!.year.toString());

      var title =
          '${defaultUniversity.university!.abbr} ${TextUtils.upperCaseFirstLetter(defaultSemester.semester!.season.toString())} ${defaultSemester.semester!.year}';

      var items = await _buildSubjectItems(subjects);

      emit(SubjectLoaded(items: items, title: title));
    } on Exception catch (e) {
      emit(SubjectError(message: e.toString()));
    }
  }

  Future<List<Item>> _buildSubjectItems(List<Subject> subjects) async {
    var recentSubjectSelections = await recentSelectionDatabase
        .getRecentSubjectSelection(searchContext.searchTopicName);

    List<Item> adapterItems = [];

    var recentSubjects = subjects.where((it) {
      return recentSubjectSelections.any((recentSelection) {
        return it.topicName == recentSelection.topicName;
      });
    });

    subjectClickCallback(context, Subject subject) {
      add(SubjectSelected(subject: subject));
    }

    var recentSubjectItems = recentSubjects.map((subject) {
      return SubjectTitleItem(subject, subjectClickCallback, hasLabel: false);
    });

    if (recentSubjectItems.isNotEmpty) {
      adapterItems.add(HeaderItem('Recents'));
      adapterItems.addAll(recentSubjectItems);
    }

    adapterItems.add(HeaderItem('All (${subjects.length})'));

    adapterItems.addAll(subjects.map((subject) {
      return SubjectTitleItem(subject, subjectClickCallback);
    }));

    return adapterItems;
  }

  Future<void> _onSubjectSelected(
    SubjectSelected event,
    Emitter<SubjectState> emit,
  ) async {
    searchContext.updateWith(subject: event.subject);
    await _addToRecent(event.subject.topicName);

    var parameters = {AKeys.IS_RECENT: 'false'};
    analyticsLogger.logEvent(AKeys.EVENT_SUBJECT_CLICKED,
        parameters: parameters);

    _pendingNavigation = const SubjectNavigateToCourse();
    emit(_cloneStateWithNewTimestamp(state));
  }

  Future<void> _addToRecent(String subjectTopicName) async {
    var recentSelection = RecentSelection();
    recentSelection.topicName = subjectTopicName;
    recentSelection.parentTopicName = searchContext.searchTopicName;
    await recentSelectionDatabase.insertSubjectSelection(recentSelection);
  }

  void _onSettingsClicked(
    SubjectSettingsClicked event,
    Emitter<SubjectState> emit,
  ) {
    analyticsLogger.logEvent(AKeys.EVENT_SETTINGS_CLICKED);
    _pendingNavigation = const SubjectNavigateToOptions();
    emit(_cloneStateWithNewTimestamp(state));
  }
}
