import '../../../core/lib.dart';
import '../../../data/lib.dart';
import '../../widgets/lib.dart';

// --- Events ---

sealed class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object?> get props => [];
}

class CourseLoadRequested extends CourseEvent {
  final bool showAll;

  const CourseLoadRequested({required this.showAll});

  @override
  List<Object?> get props => [showAll];
}

class CourseSectionClicked extends CourseEvent {
  final Section section;

  const CourseSectionClicked({required this.section});

  @override
  List<Object?> get props => [section];
}

// --- States ---

sealed class CourseState extends Equatable {
  final int? timestamp;
  const CourseState({this.timestamp});

  @override
  List<Object?> get props => [timestamp];
}

class CourseInitial extends CourseState {
  const CourseInitial({super.timestamp});
}

class CourseLoading extends CourseState {
  const CourseLoading({super.timestamp});
}

class CourseLoaded extends CourseState {
  final List<Item> items;

  const CourseLoaded({required this.items, super.timestamp});

  @override
  List<Object?> get props => [items, timestamp];
}

class CourseError extends CourseState {
  final String message;

  const CourseError({required this.message, super.timestamp});

  @override
  List<Object?> get props => [message, timestamp];
}

// --- Navigation ---

sealed class CourseNavigation {
  const CourseNavigation();
}

class CourseNavigateToSection extends CourseNavigation {
  const CourseNavigateToSection();
}

// --- BLoC ---

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final SearchContext searchContext;
  final UCTApiClient apiClient;
  final AnalyticsLogger analyticsLogger;

  late Course course;
  bool showAll = true;

  CourseNavigation? _pendingNavigation;
  CourseNavigation? consumeNavigation() {
    final nav = _pendingNavigation;
    _pendingNavigation = null;
    return nav;
  }

  CourseState _cloneStateWithNewTimestamp(CourseState state) {
    final newTimestamp = DateTime.now().millisecondsSinceEpoch;
    if (state is CourseInitial) {
      return CourseInitial(timestamp: newTimestamp);
    } else if (state is CourseLoading) {
      return CourseLoading(timestamp: newTimestamp);
    } else if (state is CourseLoaded) {
      return CourseLoaded(items: state.items, timestamp: newTimestamp);
    } else if (state is CourseError) {
      return CourseError(message: state.message, timestamp: newTimestamp);
    }
    return state;
  }

  CourseBloc({
    required this.searchContext,
    required this.apiClient,
    required this.analyticsLogger,
  }) : super(const CourseInitial()) {
    course = searchContext.course!;
    on<CourseLoadRequested>(_onLoadCourse);
    on<CourseSectionClicked>(_onSectionClicked);
  }

  Future<void> _onLoadCourse(
    CourseLoadRequested event,
    Emitter<CourseState> emit,
  ) async {
    showAll = event.showAll;
    if (state is! CourseLoaded) {
      emit(const CourseLoading());
    }

    final localCourse = searchContext.course!;

    List<SubscriptionView> subscriptionViews = [];
    try {
      subscriptionViews = await apiClient.courseHotness(localCourse.topicName);
    } on Exception catch (e) {
      emit(CourseError(message: e.toString()));
      return;
    }

    List<Item> adapterItems = [];

    List<MetadataItem> metaItems = [];
    if (localCourse.metadata.isNotEmpty) {
      for (var meta in localCourse.metadata) {
        metaItems.add(MetadataItem(meta.title, meta.content));
      }
    }

    List<SectionItem> sectionItems = [];
    if (localCourse.sections.isNotEmpty) {
      for (var section in localCourse.sections) {
        var subscriptionView = subscriptionViews
            .firstWhere((sv) => sv.topicName == section.topicName);

        if (showAll || section.status == "Closed") {
          sectionItems.add(SectionItem(searchContext.copyWith(section: section),
              subscriptionView: subscriptionView,
              onSectionClicked: (section) {
                add(CourseSectionClicked(section: section));
              },
              canSlide: false,
              onItemDismissed: () => {}));
        }
      }
    }

    adapterItems.addAll(metaItems);
    adapterItems.addAll(sectionItems);

    emit(CourseLoaded(items: adapterItems));
  }

  void _onSectionClicked(
    CourseSectionClicked event,
    Emitter<CourseState> emit,
  ) {
    var parameters = {
      AKeys.STATUS: event.section.status,
      AKeys.ORIGIN: AKeys.ORIGIN_COURSE_SECTION_LIST,
    };
    analyticsLogger.logEvent(AKeys.EVENT_SECTION_CLICKED,
        parameters: parameters);

    _pendingNavigation = const CourseNavigateToSection();
    emit(_cloneStateWithNewTimestamp(state));
  }
}
