import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';
import 'bloc/courses_bloc.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  CoursesListState createState() => CoursesListState();
}

class CoursesListState extends State<CoursesPage>
    with LDEViewMixin
    implements BaseView, ListOps {
  @override
  BasePresenter get presenter => throw UnimplementedError('Using BLoC instead');

  @override
  Widget build(BuildContext context) {
    final SearchContext searchContext = getIt<SearchContext>();

    var title = AppLocalizations.of(context)!.headerMessage(
        searchContext.subject!.name, searchContext.subject!.number);

    return BlocProvider(
      create: (_) => CoursesBloc(
        apiClient: getIt<UCTApiClient>(),
        searchContext: getIt<SearchContext>(),
        recentSelectionDatabase: getIt<RecentSelectionDao>(),
        analyticsLogger: getIt<AnalyticsLogger>(),
        adInitializer: getIt<AdInitializer>(),
      )..add(const CoursesLoadRequested()),
      child: BlocConsumer<CoursesBloc, CoursesState>(
        listener: (context, state) {
          final bloc = context.read<CoursesBloc>();
          final nav = bloc.consumeNavigation();
          if (nav != null) {
            _handleNavigation(bloc, nav);
          }
        },
        builder: (context, state) {
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              title: Text(title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface)),
            ),
            body: AdSafeArea(child: _buildBody(context, state)),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, CoursesState state) {
    if (state is CoursesLoading || state is CoursesInitial) {
      return Widgets.makeLoading(context);
    }

    if (state is CoursesError) {
      return Center(child: Text(state.message));
    }

    if (state is CoursesLoaded) {
      adapter.swapData(state.items);
      return RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: () async {
          context.read<CoursesBloc>().add(const CoursesLoadRequested());
        },
        child: makeAnimatedListView(context),
      );
    }

    return Container();
  }

  void _handleNavigation(CoursesBloc bloc, CoursesNavigation nav) {
    if (nav is CoursesNavigateToCourse) {
      Navigator.of(context).pushNamed(UCTRoutes.course).then((changed) {
        if (mounted) {
          bloc.add(const CoursesLoadRequested());
        }
      });
    }
  }

  @override
  void onRefreshData() {
    context.read<CoursesBloc>().add(const CoursesLoadRequested());
  }
}
