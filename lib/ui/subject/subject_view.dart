import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';
import 'bloc/subject_bloc.dart';

class SubjectPage extends StatefulWidget {
  const SubjectPage({super.key});

  @override
  SubjectListState createState() => SubjectListState();
}

class SubjectListState extends State<SubjectPage>
    with LDEViewMixin
    implements BaseView, ListOps {
  String title = "";

  @override
  BasePresenter get presenter => throw UnimplementedError('Using BLoC instead');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SubjectBloc(
        apiClient: getIt<UCTApiClient>(),
        recentSelectionDatabase: getIt<RecentSelectionDao>(),
        searchContext: getIt<SearchContext>(),
        preferenceDao: getIt<PreferenceDao>(),
        analyticsLogger: getIt<AnalyticsLogger>(),
        adInitializer: getIt<AdInitializer>(),
      )..add(const SubjectLoadRequested()),
      child: BlocConsumer<SubjectBloc, SubjectState>(
        listener: (context, state) {
          if (state is SubjectUniversityNotSet) {
            Navigator.of(context).pushNamed(UCTRoutes.options).then((onValue) {
              context.read<SubjectBloc>().add(const SubjectLoadRequested());
            });
            return;
          }

          if (state is SubjectLoaded) {
            setState(() {
              title = state.title;
            });
          }

          final bloc = context.read<SubjectBloc>();
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
                actions: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      onPressed: () {
                        context
                            .read<SubjectBloc>()
                            .add(const SubjectSettingsClicked());
                      }),
                ],
              ),
              body: AdSafeArea(child: _buildBody(context, state)));
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, SubjectState state) {
    if (state is SubjectLoading ||
        state is SubjectInitial ||
        state is SubjectUniversityNotSet) {
      return Widgets.makeLoading(context);
    }

    if (state is SubjectError) {
      return Center(child: Text(state.message));
    }

    if (state is SubjectLoaded) {
      adapter.swapData(state.items);
      return RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: () async {
          context.read<SubjectBloc>().add(const SubjectLoadRequested());
        },
        child: makeAnimatedListView(context),
      );
    }

    return Container();
  }

  void _handleNavigation(SubjectBloc bloc, SubjectNavigation nav) {
    if (nav is SubjectNavigateToOptions) {
      Navigator.of(context).pushNamed(UCTRoutes.options).then((changed) {
        if (mounted) {
          bloc.add(const SubjectLoadRequested());
        }
      });
    } else if (nav is SubjectNavigateToCourse) {
      Navigator.of(context).pushNamed(UCTRoutes.courses).then((result) {
        if (mounted) {
          bloc.add(const SubjectLoadRequested());
        }
      });
    }
  }

  @override
  void onRefreshData() {
    context.read<SubjectBloc>().add(const SubjectLoadRequested());
  }
}
