import '../../../core/lib.dart';
import '../../../data/lib.dart';
import '../../widgets/lib.dart';

// --- Events ---

sealed class SectionEvent extends Equatable {
  const SectionEvent();

  @override
  List<Object?> get props => [];
}

class SectionLoadRequested extends SectionEvent {
  const SectionLoadRequested();
}

class SectionToggleSubscription extends SectionEvent {
  const SectionToggleSubscription();
}

class SectionPopToTracked extends SectionEvent {
  const SectionPopToTracked();
}

// --- States ---

sealed class SectionState extends Equatable {
  final int? timestamp;
  const SectionState({this.timestamp});

  @override
  List<Object?> get props => [timestamp];
}

class SectionInitial extends SectionState {
  const SectionInitial({super.timestamp});
}

class SectionLoading extends SectionState {
  const SectionLoading({super.timestamp});
}

class SectionLoaded extends SectionState {
  final List<Item> items;
  final bool isTracked;
  final int numTrackedSections;

  const SectionLoaded({
    required this.items,
    required this.isTracked,
    required this.numTrackedSections,
    super.timestamp,
  });

  @override
  List<Object?> get props => [items, isTracked, numTrackedSections, timestamp];
}

class SectionError extends SectionState {
  final String message;

  const SectionError({required this.message, super.timestamp});

  @override
  List<Object?> get props => [message, timestamp];
}

// --- Navigation ---

sealed class SectionNavigation {
  const SectionNavigation();
}

class SectionPopToHome extends SectionNavigation {
  const SectionPopToHome();
}

class SectionShowPastSemesterDialog extends SectionNavigation {
  final Subject subject;

  const SectionShowPastSemesterDialog({required this.subject});
}

// --- TrackedStatusProvider for SubscribeItem ---

class BlocTrackedStatusProvider implements TrackedStatusProvider {
  final bool isTracked;

  BlocTrackedStatusProvider(this.isTracked);

  @override
  bool trackedStatus() => isTracked;
}

// --- BLoC ---

class SectionBloc extends Bloc<SectionEvent, SectionState> {
  final SearchContext searchContext;
  final UCTRepo uctRepo;
  final TrackedSectionDao trackedSectionDatabase;
  final AnalyticsLogger analyticsLogger;
  final AdInitializer adInitializer;

  SectionNavigation? _pendingNavigation;
  SectionNavigation? consumeNavigation() {
    final nav = _pendingNavigation;
    _pendingNavigation = null;
    return nav;
  }

  SectionState _cloneStateWithNewTimestamp(SectionState state) {
    final newTimestamp = DateTime.now().millisecondsSinceEpoch;
    if (state is SectionInitial) {
      return SectionInitial(timestamp: newTimestamp);
    } else if (state is SectionLoading) {
      return SectionLoading(timestamp: newTimestamp);
    } else if (state is SectionLoaded) {
      return SectionLoaded(
        items: state.items,
        isTracked: state.isTracked,
        numTrackedSections: state.numTrackedSections,
        timestamp: newTimestamp,
      );
    } else if (state is SectionError) {
      return SectionError(message: state.message, timestamp: newTimestamp);
    }
    return state;
  }

  SectionBloc({
    required this.searchContext,
    required this.uctRepo,
    required this.trackedSectionDatabase,
    required this.analyticsLogger,
    required this.adInitializer,
  }) : super(const SectionInitial()) {
    on<SectionLoadRequested>(_onLoadSection);
    on<SectionToggleSubscription>(_onToggleSubscription);
    on<SectionPopToTracked>(_onPopToTracked);
  }

  Future<void> _onLoadSection(
    SectionLoadRequested event,
    Emitter<SectionState> emit,
  ) async {
    Section section = searchContext.section!;

    List<Item> adapterItems = [];

    // The subscribe item needs a tracked status provider and callback.
    // We create a placeholder; the view will use BLoC state to determine tracked status.
    var isTracked =
        await trackedSectionDatabase.isSectionTracked(section.topicName);
    var numTrackedSections =
        (await trackedSectionDatabase.getAllTrackedSections()).length;

    adapterItems.add(SubscribeItem(
      BlocTrackedStatusProvider(isTracked),
      (value) {
        add(const SectionToggleSubscription());
      },
    ));

    adapterItems.add(SpaceItem(height: Dimens.spacingStandard));

    List<MetadataItem> metaItems = [];
    if (section.metadata.isNotEmpty) {
      for (var meta in section.metadata) {
        metaItems.add(MetadataItem(meta.title, meta.content));
      }
    }

    adapterItems.addAll(metaItems);
    adapterItems.add(SectionItem(
      searchContext,
      onItemDismissed: () => {},
      onSectionClicked: (Section) => {},
    ));

    emit(SectionLoaded(
      items: adapterItems,
      isTracked: isTracked,
      numTrackedSections: numTrackedSections,
    ));
  }

  Future<void> _onToggleSubscription(
    SectionToggleSubscription event,
    Emitter<SectionState> emit,
  ) async {
    var currentSemester = searchContext.university!.resolvedSemesters.current;
    if (int.parse(searchContext.subject!.year) < currentSemester.year &&
        searchContext.subject!.season != "winter") {
      _pendingNavigation =
          SectionShowPastSemesterDialog(subject: searchContext.subject!);
    }

    try {
      await uctRepo.toggleSection(searchContext);

      var parameters = {AKeys.STATUS: searchContext.section!.status};
      analyticsLogger.logEvent(AKeys.EVENT_SUBSCRIBE, parameters: parameters);

      // Reload section to update subscribe item state
      add(const SectionLoadRequested());
    } on Exception catch (e) {
      emit(SectionError(message: e.toString()));
    }
  }

  void _onPopToTracked(
    SectionPopToTracked event,
    Emitter<SectionState> emit,
  ) {
    var parameters = {AKeys.STATUS: searchContext.section!.status};
    analyticsLogger.logEvent(AKeys.EVENT_POP_TO_TRACKED_SECTIONS,
        parameters: parameters);

    _pendingNavigation = const SectionPopToHome();
    emit(_cloneStateWithNewTimestamp(state));
  }
}
