import '../../../core/lib.dart';
import '../../../data/lib.dart';
import '../../widgets/lib.dart';
import '../courses_adapter.dart';

// --- Events ---

sealed class CoursesEvent extends Equatable {
  const CoursesEvent();

  @override
  List<Object?> get props => [];
}

class CoursesLoadRequested extends CoursesEvent {
  const CoursesLoadRequested();
}

class CourseSelected extends CoursesEvent {
  final Course course;

  const CourseSelected({required this.course});

  @override
  List<Object?> get props => [course];
}

// --- States ---

sealed class CoursesState extends Equatable {
  final int? timestamp;
  const CoursesState({this.timestamp});

  @override
  List<Object?> get props => [timestamp];
}

class CoursesInitial extends CoursesState {
  const CoursesInitial({super.timestamp});
}

class CoursesLoading extends CoursesState {
  const CoursesLoading({super.timestamp});
}

class CoursesLoaded extends CoursesState {
  final List<Item> items;

  const CoursesLoaded({required this.items, super.timestamp});

  @override
  List<Object?> get props => [items, timestamp];
}

class CoursesError extends CoursesState {
  final String message;

  const CoursesError({required this.message, super.timestamp});

  @override
  List<Object?> get props => [message, timestamp];
}

// --- Navigation ---

sealed class CoursesNavigation {
  const CoursesNavigation();
}

class CoursesNavigateToCourse extends CoursesNavigation {
  const CoursesNavigateToCourse();
}

// --- BLoC ---

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  final UCTApiClient apiClient;
  final SearchContext searchContext;
  final RecentSelectionDao recentSelectionDatabase;
  final AnalyticsLogger analyticsLogger;
  final AdInitializer adInitializer;

  CoursesNavigation? _pendingNavigation;
  CoursesNavigation? consumeNavigation() {
    final nav = _pendingNavigation;
    _pendingNavigation = null;
    return nav;
  }

  CoursesState _cloneStateWithNewTimestamp(CoursesState state) {
    final newTimestamp = DateTime.now().millisecondsSinceEpoch;
    if (state is CoursesInitial) {
      return CoursesInitial(timestamp: newTimestamp);
    } else if (state is CoursesLoading) {
      return CoursesLoading(timestamp: newTimestamp);
    } else if (state is CoursesLoaded) {
      return CoursesLoaded(items: state.items, timestamp: newTimestamp);
    } else if (state is CoursesError) {
      return CoursesError(message: state.message, timestamp: newTimestamp);
    }
    return state;
  }

  CoursesBloc({
    required this.apiClient,
    required this.searchContext,
    required this.recentSelectionDatabase,
    required this.analyticsLogger,
    required this.adInitializer,
  }) : super(const CoursesInitial()) {
    on<CoursesLoadRequested>(_onLoadCourses);
    on<CourseSelected>(_onCourseSelected);
  }

  Future<void> _onLoadCourses(
    CoursesLoadRequested event,
    Emitter<CoursesState> emit,
  ) async {
    if (state is! CoursesLoaded) {
      emit(const CoursesLoading());
    }

    try {
      final subject = searchContext.subject!;
      var courses = await apiClient.courses(subject.topicName);
      var items = await _buildCourseItems(courses, subject);
      emit(CoursesLoaded(items: items));
    } on Exception catch (e) {
      emit(CoursesError(message: e.toString()));
    }
  }

  Future<List<Item>> _buildCourseItems(List<Course> courses, Subject subject) async {
    var recent = await recentSelectionDatabase
        .getRecentCourseSelection(subject.topicName);

    List<Item> adapterItems = [];

    var recentCourses = courses.where((it) {
      return recent.any((recentSelection) {
        return it.topicName == recentSelection.topicName;
      });
    });

    courseClickCallback(context, Course course) {
      add(CourseSelected(course: course));
    }

    var recentCourseItems = recentCourses.map((course) {
      return CourseTitleItem(course, courseClickCallback);
    });

    if (recentCourseItems.isNotEmpty && courses.length > 5) {
      adapterItems.add(HeaderItem('Recents'));
      adapterItems.addAll(recentCourseItems);
    }

    adapterItems.add(HeaderItem('All (${courses.length})'));

    final addItems = courses.map((course) {
      return CourseTitleItem(course, courseClickCallback);
    });

    adapterItems.addAll(addItems);
    return adapterItems;
  }

  Future<void> _onCourseSelected(
    CourseSelected event,
    Emitter<CoursesState> emit,
  ) async {
    searchContext.updateWith(course: event.course);
    await _addToRecent(event.course.topicName);

    var parameters = {AKeys.IS_RECENT: 'false'};
    analyticsLogger.logEvent(AKeys.EVENT_COURSE_CLICKED,
        parameters: parameters);

    _pendingNavigation = const CoursesNavigateToCourse();
    emit(_cloneStateWithNewTimestamp(state));
  }

  Future<void> _addToRecent(String courseTopicName) async {
    var recentSelection = RecentSelection();
    recentSelection.topicName = courseTopicName;
    recentSelection.parentTopicName = searchContext.subject!.topicName;
    await recentSelectionDatabase.insertCourseSelection(recentSelection);
  }
}
