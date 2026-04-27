import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';
import 'bloc/section_bloc.dart';

class SectionDetailsPage extends StatefulWidget {
  const SectionDetailsPage({super.key});

  @override
  SectionDetailState createState() => SectionDetailState();
}

class SectionDetailState extends State<SectionDetailsPage>
    with LDEViewMixin
    implements BaseView, ListOps {
  late SearchContext searchContext;

  bool? initialTrackedStatus;
  bool? isTracked;
  int numTrackedSections = 0;

  @override
  BasePresenter get presenter => throw UnimplementedError('Using BLoC instead');

  SectionDetailState() {
    searchContext = getIt<SearchContext>();
  }

  @override
  Widget build(BuildContext context) {
    isTracked ??= ModalRoute.of(context)!.settings.arguments as bool?;

    return BlocProvider(
      create: (_) => SectionBloc(
        searchContext: getIt<SearchContext>(),
        uctRepo: getIt<UCTRepo>(),
        trackedSectionDatabase: getIt<TrackedSectionDao>(),
        analyticsLogger: getIt<AnalyticsLogger>(),
        adInitializer: getIt<AdInitializer>(),
      )..add(const SectionLoadRequested()),
      child: BlocConsumer<SectionBloc, SectionState>(
        listener: (context, state) {
          if (state is SectionLoaded) {
            setState(() {
              initialTrackedStatus ??= state.isTracked;
              isTracked = state.isTracked;
              numTrackedSections = state.numTrackedSections;
            });
          }

          final bloc = context.read<SectionBloc>();
          final nav = bloc.consumeNavigation();
          if (nav != null) {
            _handleNavigation(bloc, nav);
          }
        },
        builder: (context, state) {
          final title = AppLocalizations.of(context)!.headerMessage(
              searchContext.course!.name, searchContext.course!.number);
          final section = searchContext.section;

          return Scaffold(
              appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(140.0),
                  child: Stack(
                    alignment: const FractionalOffset(0.95, 1.22),
                    children: <Widget>[
                      AppBar(
                        leading: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(initialTrackedStatus != isTracked);
                            }),
                        actions: <Widget>[
                          Widgets.makeIconWithBadge(
                              context, numTrackedSections.toString(), () {
                            context
                                .read<SectionBloc>()
                                .add(const SectionPopToTracked());
                          }),
                        ],
                        title: Container(
                          child: Text(title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface)),
                        ),
                        bottom: PreferredSize(
                            preferredSize: const Size.fromHeight(70.0),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 72.0,
                                  right: 72.0,
                                  bottom: Dimens.spacingStandard),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        section!.number,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                            ),
                                      ),
                                      const SizedBox(height: 6.0),
                                      Text(
                                        AppLocalizations.of(context)!.section,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        section.callNumber,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                            ),
                                      ),
                                      const SizedBox(height: 6.0),
                                      Text(
                                        AppLocalizations.of(context)!.index,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                            ),
                                      ),
                                    ],
                                  ),
                                  _buildCredits(section)
                                ],
                              ),
                            )),
                      ),
                    ],
                  )),
              body: AdSafeArea(child: _buildBody(context, state)));
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, SectionState state) {
    if (state is SectionLoading || state is SectionInitial) {
      return Widgets.makeLoading(context);
    }

    if (state is SectionError) {
      return Center(child: Text(state.message));
    }

    if (state is SectionLoaded) {
      adapter.swapData(state.items);
      return makeListView();
    }

    return Container();
  }

  Widget _buildCredits(Section section) {
    var defaultCredits = 0.toDouble();
    var credits = double.parse(section.credits);
    if (credits == defaultCredits || credits == -1.0) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          credits.round().toString(),
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        const SizedBox(height: 6.0),
        Text(
          AppLocalizations.of(context)!.credits,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ],
    );
  }

  void _handleNavigation(SectionBloc bloc, SectionNavigation nav) {
    if (nav is SectionPopToHome) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          UCTRoutes.home, (Route<dynamic> route) => false);
    } else if (nav is SectionShowPastSemesterDialog) {
      _showPastSemesterDialog(nav.subject);
    }
  }

  void _showPastSemesterDialog(Subject subject) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text("Are you sure?"),
              content: Text(
                  "You're subscribing to a section from ${subject.season} ${subject.year}"),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'Change semester',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        UCTRoutes.subjects, (Route<dynamic> route) => false);
                    Navigator.of(context).pushNamed(UCTRoutes.options);
                  },
                )
              ],
            ));
  }

  @override
  void onRefreshData() {
    context.read<SectionBloc>().add(const SectionLoadRequested());
  }
}
