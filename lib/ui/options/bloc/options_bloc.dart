import '../../../core/lib.dart';
import '../../../data/lib.dart';

// --- Events ---

sealed class OptionsEvent extends Equatable {
  const OptionsEvent();

  @override
  List<Object?> get props => [];
}

class OptionsLoadUniversities extends OptionsEvent {
  const OptionsLoadUniversities();
}

class OptionsUniversityChanged extends OptionsEvent {
  final University university;

  const OptionsUniversityChanged({required this.university});

  @override
  List<Object?> get props => [university];
}

class OptionsSemesterChanged extends OptionsEvent {
  final Semester semester;

  const OptionsSemesterChanged({required this.semester});

  @override
  List<Object?> get props => [semester];
}

// --- States ---

sealed class OptionsState extends Equatable {
  const OptionsState();

  @override
  List<Object?> get props => [];
}

class OptionsInitial extends OptionsState {
  const OptionsInitial();
}

class OptionsLoading extends OptionsState {
  const OptionsLoading();
}

class OptionsLoaded extends OptionsState {
  final List<University> universities;
  final University? selectedUniversity;
  final List<Semester> semesters;
  final Semester? selectedSemester;

  const OptionsLoaded({
    required this.universities,
    this.selectedUniversity,
    required this.semesters,
    this.selectedSemester,
  });

  @override
  List<Object?> get props =>
      [universities, selectedUniversity, semesters, selectedSemester];
}

class OptionsError extends OptionsState {
  final String message;

  const OptionsError({required this.message});

  @override
  List<Object?> get props => [message];
}

// --- BLoC ---

class OptionsBloc extends Bloc<OptionsEvent, OptionsState> {
  final UCTApiClient apiClient;
  final PreferenceDao preferenceDao;
  final AnalyticsLogger analyticsLogger;
  final AdInitializer adInitializer;

  OptionsBloc({
    required this.apiClient,
    required this.preferenceDao,
    required this.analyticsLogger,
    required this.adInitializer,
  }) : super(const OptionsInitial()) {
    on<OptionsLoadUniversities>(_onLoadUniversities);
    on<OptionsUniversityChanged>(_onUniversityChanged);
    on<OptionsSemesterChanged>(_onSemesterChanged);
  }

  Future<void> _onLoadUniversities(
    OptionsLoadUniversities event,
    Emitter<OptionsState> emit,
  ) async {
    emit(const OptionsLoading());

    try {
      var universities = await apiClient.universities();
      var defaultUniversity = await _getDefaultUniversity(universities);
      var defaultSemester = await _getDefaultSemester(defaultUniversity);

      emit(OptionsLoaded(
        universities: universities,
        selectedUniversity: defaultUniversity.university,
        semesters: defaultUniversity.university?.availableSemesters ?? [],
        selectedSemester: defaultSemester.semester,
      ));
    } on Exception catch (e) {
      emit(OptionsError(message: e.toString()));
    }
  }

  Future<void> _onUniversityChanged(
    OptionsUniversityChanged event,
    Emitter<OptionsState> emit,
  ) async {
    analyticsLogger.logEvent(AKeys.EVENT_UNIVERSITY_CHANGED);

    var du = await preferenceDao.insertUniversity(event.university);
    var ds = await _getDefaultSemester(du);

    final currentState = state;
    if (currentState is OptionsLoaded) {
      emit(OptionsLoaded(
        universities: currentState.universities,
        selectedUniversity: du.university,
        semesters: du.university?.availableSemesters ?? [],
        selectedSemester: ds.semester,
      ));
    }
  }

  Future<void> _onSemesterChanged(
    OptionsSemesterChanged event,
    Emitter<OptionsState> emit,
  ) async {
    analyticsLogger.logEvent(AKeys.EVENT_SEMESTER_CHANGED);

    var ds = await preferenceDao.insertSemester(event.semester);

    final currentState = state;
    if (currentState is OptionsLoaded) {
      emit(OptionsLoaded(
        universities: currentState.universities,
        selectedUniversity: currentState.selectedUniversity,
        semesters: currentState.semesters,
        selectedSemester: ds.semester,
      ));
    }
  }

  Future<DefaultSemester> _getDefaultSemester(
      DefaultUniversity defaultUniversity) async {
    var defaultSemester = await preferenceDao.getDefaultSemester();
    if (defaultSemester == null && defaultUniversity.university != null) {
      DefaultSemester ds = DefaultSemester();
      ds.semester = defaultUniversity.university?.availableSemesters[0];
      defaultSemester = ds;
      await preferenceDao.insertSemester(ds.semester!);
    }

    if (defaultSemester != null &&
        defaultUniversity.university != null &&
        !defaultUniversity.university!.availableSemesters
            .contains(defaultSemester.semester)) {
      DefaultSemester ds = DefaultSemester();
      ds.semester = defaultUniversity.university!.availableSemesters[0];
      defaultSemester = ds;
      await preferenceDao.insertSemester(ds.semester!);
    }
    return defaultSemester!;
  }

  Future<DefaultUniversity> _getDefaultUniversity(
      List<University> universities) async {
    var defaultUniversity = await preferenceDao.getDefaultUniversity();

    if (defaultUniversity != null) {
      var updatedUniversity = universities
          .where((university) =>
              university.topicName == defaultUniversity!.university!.topicName)
          .elementAt(0);
      defaultUniversity =
          await preferenceDao.insertUniversity(updatedUniversity);
    }

    if (defaultUniversity == null) {
      DefaultUniversity du = DefaultUniversity();
      defaultUniversity = du;
      defaultUniversity.university = universities[0];
    }
    return defaultUniversity;
  }
}
