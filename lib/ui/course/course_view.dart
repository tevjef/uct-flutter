import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';
import 'bloc/course_bloc.dart';

class CoursePage extends StatelessWidget {
  final SearchContext searchContext = getIt<SearchContext>();

  CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    final title = AppLocalizations.of(context)!.headerMessage(
        searchContext.course!.name, searchContext.course!.number);

    var allSections = 0;
    var closedSections = 0;
    for (var section in searchContext.course!.sections) {
      if (section.status == AppLocalizations.of(context)!.closedStatus) {
        closedSections++;
      }
      allSections++;
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: Container(
            child: Text(title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface)),
          ),
          bottom: TabBar(
            labelStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
            unselectedLabelStyle: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold),
            tabs: [
              Tab(
                  text: AppLocalizations.of(context)!
                      .allSections(allSections.toString())),
              Tab(
                  text: AppLocalizations.of(context)!
                      .closedSections(closedSections.toString())),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _CourseList(showAll: true),
            _CourseList(showAll: false),
          ],
        ),
      ),
    );
  }
}

class _CourseList extends StatefulWidget {
  final bool showAll;

  const _CourseList({required this.showAll});

  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<_CourseList>
    with LDEViewMixin<_CourseList>
    implements BaseView, ListOps {
  @override
  BasePresenter get presenter => throw UnimplementedError('Using BLoC instead');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CourseBloc(
        searchContext: getIt<SearchContext>(),
        apiClient: getIt<UCTApiClient>(),
        analyticsLogger: getIt<AnalyticsLogger>(),
      )..add(CourseLoadRequested(showAll: widget.showAll)),
      child: BlocConsumer<CourseBloc, CourseState>(
        listener: (context, state) {
          final bloc = context.read<CourseBloc>();
          final nav = bloc.consumeNavigation();
          if (nav != null) {
            if (nav is CourseNavigateToSection) {
              Navigator.of(context)
                  .pushNamed(UCTRoutes.section)
                  .then((changed) {
                if (mounted) {
                  bloc.add(CourseLoadRequested(showAll: widget.showAll));
                }
              });
            }
          }
        },
        builder: (context, state) {
          return AdSafeArea(child: _buildBody(context, state));
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, CourseState state) {
    if (state is CourseLoading || state is CourseInitial) {
      return Widgets.makeLoading(context);
    }

    if (state is CourseError) {
      return Center(child: Text(state.message));
    }

    if (state is CourseLoaded) {
      if (state.items.isEmpty) {
        return makeEmptyStateWidget(context);
      }
      adapter.swapData(state.items);
      return RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: () async {
          context
              .read<CourseBloc>()
              .add(CourseLoadRequested(showAll: widget.showAll));
        },
        child: makeAnimatedListView(context),
      );
    }

    return Container();
  }

  @override
  Widget makeEmptyStateWidget(BuildContext context) {
    return Container();
  }

  @override
  void onRefreshData() {
    context
        .read<CourseBloc>()
        .add(CourseLoadRequested(showAll: widget.showAll));
  }
}
