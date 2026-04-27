import 'package:collection/collection.dart';

import '../../../core/lib.dart';
import '../../../data/lib.dart';
import '../../widgets/lib.dart';

// --- Events ---

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeLoadTrackedSections extends HomeEvent {
  const HomeLoadTrackedSections();
}

class HomeSectionDismissed extends HomeEvent {
  final SearchContext searchContext;
  final SectionItem item;

  const HomeSectionDismissed({
    required this.searchContext,
    required this.item,
  });

  @override
  List<Object?> get props => [searchContext, item];
}

class HomeFabClicked extends HomeEvent {
  const HomeFabClicked();
}

class HomeSectionClicked extends HomeEvent {
  final Section section;

  const HomeSectionClicked({required this.section});

  @override
  List<Object?> get props => [section];
}

// --- States ---

sealed class HomeState extends Equatable {
  final int timestamp;
  const HomeState({this.timestamp = 0});

  @override
  List<Object?> get props => [timestamp];
}

class HomeInitial extends HomeState {
  const HomeInitial({super.timestamp = 0});
}

class HomeLoading extends HomeState {
  const HomeLoading({super.timestamp = 0});
}

class HomeLoaded extends HomeState {
  final List<Item> items;

  const HomeLoaded({required this.items, super.timestamp = 0});

  @override
  List<Object?> get props => [items, timestamp];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message, super.timestamp = 0});

  @override
  List<Object?> get props => [message, timestamp];
}

// --- Navigation Side Effects ---

sealed class HomeNavigation {
  const HomeNavigation();
}

class HomeNavigateToSubjects extends HomeNavigation {
  const HomeNavigateToSubjects();
}

class HomeNavigateToSection extends HomeNavigation {
  const HomeNavigateToSection();
}

class HomeSectionRemoved extends HomeNavigation {
  final String message;

  const HomeSectionRemoved({required this.message});
}

// --- BLoC ---

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UCTRepo uctRepo;
  final TrackedSectionDao trackedSectionDatabase;
  final AnalyticsLogger analyticsLogger;
  final AdInitializer adInitializer;

  // Navigation side effects are emitted through a stream the view listens to
  HomeNavigation? _pendingNavigation;
  HomeNavigation? consumeNavigation() {
    final nav = _pendingNavigation;
    _pendingNavigation = null;
    return nav;
  }

  HomeBloc({
    required this.uctRepo,
    required this.trackedSectionDatabase,
    required this.analyticsLogger,
    required this.adInitializer,
  }) : super(const HomeInitial()) {
    on<HomeLoadTrackedSections>(_onLoadTrackedSections);
    on<HomeSectionDismissed>(_onSectionDismissed);
    on<HomeFabClicked>(_onFabClicked);
    on<HomeSectionClicked>(_onSectionClicked);
  }

  Future<void> _onLoadTrackedSections(
    HomeLoadTrackedSections event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeLoaded) {
      emit(const HomeLoading());
    }

    try {
      List<TrackedSection> trackedSections =
          await uctRepo.refreshTrackedSections();

      var searchContexts = trackedSections.map((ts) {
        return ts.toSearchContext();
      }).toList();

      mergeSort(searchContexts, compare: (SearchContext a, SearchContext b) {
        return a.subject!.name.compareTo(b.subject!.name);
      });

      emit(HomeLoaded(items: _buildItems(searchContexts)));
    } on Exception catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  List<Item> _buildItems(List<SearchContext> searchContexts) {
    List<Item> adapterItems = [];

    Map<String, List<SearchContext>> subjectGroups =
        groupBy(searchContexts, (SearchContext context) {
      return context.subject!.name;
    });

    subjectGroups.forEach((number, subjectGroup) {
      var subject = subjectGroup[0].subject;

      var group = GroupItem(subject!.topicName);

      // Note: We can't use AppLocalizations here since we don't have context.
      // The header text will be built in the view layer.
      group.addHeader(HeaderItem(
          '${subject.name} ${subject.number}'.toUpperCase(),
          insets: const EdgeInsets.only(
              left: Dimens.spacingStandard,
              top: Dimens.spacingMedium,
              bottom: Dimens.spacingXsmall,
              right: Dimens.spacingStandard)));

      for (var searchContext in subjectGroup) {
        group.addItem(SectionItem(searchContext, hasTitle: true,
            onSectionClicked: (section) {
          add(HomeSectionClicked(section: section));
        }, onItemDismissed: (searchContext, item, position, adapterPosition) {
          add(HomeSectionDismissed(searchContext: searchContext, item: item));
        }));
      }

      adapterItems.add(group);
    });

    return adapterItems;
  }

  Future<void> _onSectionDismissed(
    HomeSectionDismissed event,
    Emitter<HomeState> emit,
  ) async {
    uctRepo.unsubscribe(event.searchContext.sectionTopicName);

    var parameters = {AKeys.STATUS: event.searchContext.section!.status};
    analyticsLogger.logEvent(AKeys.EVENT_SECTION_REMOVED,
        parameters: parameters);

    _pendingNavigation = HomeSectionRemoved(
      message:
          '${event.searchContext.section!.number} ${event.searchContext.course!.name}',
    );

    // Reload after removal
    add(const HomeLoadTrackedSections());
  }

  HomeState _cloneStateWithNewTimestamp(HomeState currentState) {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (currentState is HomeLoaded) {
      return HomeLoaded(items: currentState.items, timestamp: now);
    } else if (currentState is HomeLoading) {
      return HomeLoading(timestamp: now);
    } else if (currentState is HomeInitial) {
      return HomeInitial(timestamp: now);
    } else if (currentState is HomeError) {
      return HomeError(message: currentState.message, timestamp: now);
    }
    return currentState;
  }

  void _onFabClicked(
    HomeFabClicked event,
    Emitter<HomeState> emit,
  ) {
    analyticsLogger.logEvent(AKeys.EVENT_NEW_SEARCH);
    _pendingNavigation = const HomeNavigateToSubjects();
    // Emit cloned state to trigger listener
    emit(_cloneStateWithNewTimestamp(state));
  }

  void _onSectionClicked(
    HomeSectionClicked event,
    Emitter<HomeState> emit,
  ) {
    var parameters = {
      AKeys.STATUS: event.section.status,
      AKeys.ORIGIN: AKeys.ORIGIN_TRACKED_SECTIONS,
    };
    analyticsLogger.logEvent(AKeys.EVENT_SECTION_CLICKED,
        parameters: parameters);

    _pendingNavigation = const HomeNavigateToSection();
    // Emit cloned state to trigger listener
    emit(_cloneStateWithNewTimestamp(state));
  }
}
