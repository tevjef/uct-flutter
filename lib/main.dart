import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'core/lib.dart';
import 'firebase_options.dart';
import 'ui/screens.dart';
import 'ui/widgets/lib.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  FlutterError.onError = (FlutterErrorDetails details) {
    FirebaseCrashlytics.instance.recordFlutterError(details);
  };

  Locator.init();

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  var app = MaterialApp(
    title: 'Course Tracker',
    debugShowCheckedModeBanner: false,
    navigatorObservers: [
      new FirebaseAnalyticsObserver(analytics: analytics),
    ],
    localizationsDelegates: [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    theme: _buildLightTheme(),
    darkTheme: _buildDarkTheme(),
    routes: <String, WidgetBuilder>{
      UCTRoutes.home: (BuildContext context) => HomePage(),
      UCTRoutes.subjects: (BuildContext context) => SubjectPage(),
      UCTRoutes.options: (BuildContext context) => OptionPage(),
      UCTRoutes.courses: (BuildContext context) => CoursesPage(),
      UCTRoutes.course: (BuildContext context) => CoursePage(),
      UCTRoutes.section: (BuildContext context) => SectionDetailsPage(),
    },
    home: RootPage(),
  );

  var error = new Logger('error');

  runZonedGuarded(() {
    runApp(app);
  },
      (e, s) => {
            error.info(e.toString()),
            error.info(s.toString()),
            FirebaseCrashlytics.instance.recordError(e, s, fatal: true)
          });
}

TextTheme _buildTextTheme(TextTheme base) {
  return base.apply(fontFamily: 'ProductSans');
}

ThemeData _buildDarkTheme() {
  final ThemeData base = new ThemeData.dark();
  return ThemeData(
    fontFamily: 'ProductSans',
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: darkColorScheme,
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: _buildTextTheme(base.textTheme),
  );
}

ThemeData _buildSeedTheme() {
  final ThemeData base = new ThemeData.light();
  return ThemeData(
    fontFamily: 'ProductSans',
    useMaterial3: true,
    colorSchemeSeed: Colors.black,
    brightness: Brightness.light,
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: _buildTextTheme(base.textTheme),
  );
}

ThemeData _buildLightTheme() {
  final ThemeData base = new ThemeData.light();
  return ThemeData(
    fontFamily: 'ProductSans',
    useMaterial3: true,
    colorScheme: lightColorScheme,
    brightness: Brightness.light,
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: _buildTextTheme(base.textTheme),
  );
}

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  background: Color(0xFFF8FDFF),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  inversePrimary: Color(0xFFA7C8FF),
  inverseSurface: Color(0xFF00363F),
  onBackground: Color(0xFF001F25),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  onInverseSurface: Color(0xFFD6F6FF),
  onPrimary: Color(0xFFFFFFFF),
  onPrimaryContainer: Color(0xFF001B3C),
  onSecondary: Color(0xFFFFFFFF),
  onSecondaryContainer: Color(0xFF121C2B),
  onSurface: Color(0xFF001F25),
  onSurfaceVariant: Color(0xFF43474E),
  onTertiary: Color(0xFFFFFFFF),
  onTertiaryContainer: Color(0xFF001848),
  outline: Color(0xFF74777F),
  outlineVariant: Color(0xFFC4C6CF),
  primary: Color.fromARGB(255, 1, 15, 31),
  primaryContainer: Color(0xFFD5E3FF),
  scrim: Color(0xFF000000),
  secondary: Color(0xFF555F71),
  secondaryContainer: Color(0xFFD9E3F8),
  shadow: Color(0x1D000000),
  surface: Color(0xFFF8FDFF),
  surfaceTint: Color(0xFF235FA6),
  surfaceVariant: Color.fromARGB(255, 250, 252, 255),
  tertiary: Color(0xFF3B5BA9),
  tertiaryContainer: Color(0xFFDAE2FF),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF0F1827),
  onPrimary: Color(0xFFCED7EA),
  primaryContainer: Color(0xFF101B2C),
  onPrimaryContainer: Color(0xFFD5E3FF),
  secondary: Color(0xFFBDC7DC),
  onSecondary: Color(0xFF273141),
  secondaryContainer: Color(0xFF3D4758),
  onSecondaryContainer: Color(0xFFD9E3F8),
  tertiary: Color(0xFFB2C5FF),
  onTertiary: Color(0xFF002B74),
  tertiaryContainer: Color(0xFF1F428F),
  onTertiaryContainer: Color(0xFFDAE2FF),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF0B0E13),
  onBackground: Color(0xFFB2C9DD),
  surface: Color(0xFF0C121B),
  onSurface: Color(0xFFB2C9DD),
  surfaceVariant: Color(0xFF0C121B),
  onSurfaceVariant: Color(0xFFCED7EA),
  outline: Color(0xFFB2C9DD),
  onInverseSurface: Color(0xFF001F25),
  inverseSurface: Color(0xFFA6EEFF),
  inversePrimary: Color(0xFF235FA6),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFA7C8FF),
  outlineVariant: Color(0xFF43474E),
  scrim: Color(0xFF000000),
);
