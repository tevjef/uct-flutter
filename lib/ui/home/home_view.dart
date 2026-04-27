import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';
import 'bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomeListState createState() => HomeListState();
}

class HomeListState extends State<HomePage>
    with LDEViewMixin
    implements BaseView, ListOps {
  late AdInitializer adInitializer;

  HomeListState() {
    adInitializer = getIt<AdInitializer>();
  }

  @override
  BasePresenter get presenter => throw UnimplementedError('Using BLoC instead');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
        uctRepo: getIt<UCTRepo>(),
        trackedSectionDatabase: getIt<TrackedSectionDao>(),
        analyticsLogger: getIt<AnalyticsLogger>(),
        adInitializer: getIt<AdInitializer>(),
      )..add(const HomeLoadTrackedSections()),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          final bloc = context.read<HomeBloc>();
          final nav = bloc.consumeNavigation();
          if (nav != null) {
            _handleNavigation(bloc, nav);
          }
        },
        builder: (context, state) {
          // Update the LDEViewMixin state based on BLoC state
          _syncBlocState(state);

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.homeTitle,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface)),
            ),
            body: _buildBody(context, state),
            floatingActionButton: FloatingActionButton(
                backgroundColor:
                    Theme.of(context).colorScheme.surfaceContainerHighest,
                onPressed: () {
                  context.read<HomeBloc>().add(const HomeFabClicked());
                },
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                )),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomeState state) {
    if (state is HomeLoading || state is HomeInitial) {
      return Widgets.makeLoading(context);
    }

    if (state is HomeError) {
      return Center(
        child: Text(state.message),
      );
    }

    if (state is HomeLoaded) {
      if (state.items.isEmpty) {
        return RefreshIndicator(
          key: refreshIndicatorKey,
          onRefresh: () async {
            context.read<HomeBloc>().add(const HomeLoadTrackedSections());
          },
          child: ListView(
            children: [makeEmptyStateWidget(context)],
          ),
        );
      }

      // Sync adapter data
      adapter.swapData(state.items);

      return RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: () async {
          context.read<HomeBloc>().add(const HomeLoadTrackedSections());
        },
        child: makeAnimatedListView(context),
      );
    }

    return Container();
  }

  void _syncBlocState(HomeState state) {
    if (state is HomeLoaded) {
      adapter.swapData(state.items);
    }
  }

  void _handleNavigation(HomeBloc bloc, HomeNavigation nav) {
    if (nav is HomeNavigateToSubjects) {
      Navigator.of(context).pushNamed(UCTRoutes.subjects).then((changed) {
        if (mounted) {
          bloc.add(const HomeLoadTrackedSections());
        }
      });
    } else if (nav is HomeNavigateToSection) {
      Navigator.of(context)
          .pushNamed(UCTRoutes.section, arguments: true)
          .then((changed) {
        if (mounted) {
          bloc.add(const HomeLoadTrackedSections());
        }
      });
    } else if (nav is HomeSectionRemoved) {
      showMessage(nav.message);
    }
  }

  @override
  void onRefreshData() {
    context.read<HomeBloc>().add(const HomeLoadTrackedSections());
  }

  @override
  Widget makeEmptyStateWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: Dimens.spacingXxxlarge),
          child: Image.asset("res/images/board.webp"),
        ),
        Container(
          padding: const EdgeInsets.only(
              left: Dimens.spacingXlarge,
              right: Dimens.spacingXlarge,
              top: Dimens.spacingXlarge,
              bottom: Dimens.spacingXxxlarge),
          child: Text(
            AppLocalizations.of(context)!.homeEmpty,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
