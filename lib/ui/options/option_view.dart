import '../../core/lib.dart';
import '../../data/lib.dart';
import '../widgets/lib.dart';
import 'bloc/options_bloc.dart';

class OptionPage extends StatefulWidget {
  const OptionPage({super.key});

  @override
  OptionListState createState() => OptionListState();
}

class OptionListState extends State<OptionPage>
    with LDEViewMixin
    implements BaseView, ListOps {
  @override
  BasePresenter get presenter => throw UnimplementedError('Using BLoC instead');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OptionsBloc(
        apiClient: getIt<UCTApiClient>(),
        preferenceDao: getIt<PreferenceDao>(),
        analyticsLogger: getIt<AnalyticsLogger>(),
        adInitializer: getIt<AdInitializer>(),
      )..add(const OptionsLoadUniversities()),
      child: BlocBuilder<OptionsBloc, OptionsState>(
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
              title: Text(AppLocalizations.of(context)!.options,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface)),
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    }),
              ],
            ),
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, OptionsState state) {
    if (state is OptionsLoading || state is OptionsInitial) {
      return Widgets.makeLoading(context);
    }

    if (state is OptionsError) {
      return Center(child: Text(state.message));
    }

    if (state is OptionsLoaded) {
      return _buildOptionsContent(context, state);
    }

    return Container();
  }

  Widget _buildOptionsContent(BuildContext context, OptionsLoaded state) {
    Widget universityButton = DropdownButton<University>(
      value: state.universities.contains(state.selectedUniversity)
          ? state.selectedUniversity
          : null,
      onChanged: (University? newValue) {
        context
            .read<OptionsBloc>()
            .add(OptionsUniversityChanged(university: newValue!));
      },
      isDense: true,
      items: state.universities.map((University value) {
        return DropdownMenuItem<University>(
            value: value,
            child: SizedBox(
                width: MediaQuery.of(context).size.width * .80,
                child: Text(
                  value.name,
                  overflow: TextOverflow.ellipsis,
                )));
      }).toList(),
    );

    Widget? semesterButton;
    if (state.selectedSemester != null &&
        state.semesters.contains(state.selectedSemester)) {
      semesterButton = DropdownButton<Semester>(
        value: state.selectedSemester,
        onChanged: (Semester? newValue) {
          context
              .read<OptionsBloc>()
              .add(OptionsSemesterChanged(semester: newValue!));
        },
        isDense: true,
        items: state.semesters.map((Semester value) {
          return DropdownMenuItem<Semester>(
            value: value,
            child: Text(
              AppLocalizations.of(context)!.semesterFull(
                  TextUtils.upperCaseFirstLetter(value.season),
                  value.year.toString()),
              softWrap: true,
            ),
          );
        }).toList(),
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingStandard),
      children: <Widget>[
        DropdownButtonHideUnderline(
          child: InputDecorator(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.university,
                hintText: AppLocalizations.of(context)!.selectUniversity,
                helperText: AppLocalizations.of(context)!.selectUniversity,
              ),
              isEmpty: state.selectedUniversity == null ||
                  !state.universities.contains(state.selectedUniversity),
              child: universityButton),
        ),
        DropdownButtonHideUnderline(
          child: InputDecorator(
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.semester,
                  hintText: AppLocalizations.of(context)!.selectSemester,
                  helperText: AppLocalizations.of(context)!.selectSemester),
              isEmpty: state.selectedSemester == null ||
                  !state.semesters.contains(state.selectedSemester),
              child: semesterButton),
        )
      ],
    );
  }

  @override
  void onRefreshData() {
    context.read<OptionsBloc>().add(const OptionsLoadUniversities());
  }
}
