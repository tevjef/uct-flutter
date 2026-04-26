import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Tracked Sections'**
  String get homeTitle;

  /// No description provided for @homeEmpty.
  ///
  /// In en, this message translates to:
  /// **'You don\'t seem to be tracking any sections. Try adding some!'**
  String get homeEmpty;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @unsubscribeMessage.
  ///
  /// In en, this message translates to:
  /// **'Unsubscribed from {sectionNumber} of {sectionName}.'**
  String unsubscribeMessage(Object sectionName, Object sectionNumber);

  /// No description provided for @headerMessage.
  ///
  /// In en, this message translates to:
  /// **'{title} ({meta})'**
  String headerMessage(Object meta, Object title);

  /// No description provided for @meetingTime.
  ///
  /// In en, this message translates to:
  /// **'{startTime} - {endTime}'**
  String meetingTime(Object endTime, Object startTime);

  /// No description provided for @subscribeReason.
  ///
  /// In en, this message translates to:
  /// **'Subscribe to receive notifications'**
  String get subscribeReason;

  /// No description provided for @professorList.
  ///
  /// In en, this message translates to:
  /// **'{firstProf} | {secondProf}'**
  String professorList(Object firstProf, Object secondProf);

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @openStatus.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get openStatus;

  /// No description provided for @closedStatus.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closedStatus;

  /// No description provided for @allMeta.
  ///
  /// In en, this message translates to:
  /// **'ALL ({count})'**
  String allMeta(Object count);

  /// No description provided for @subjectTitle.
  ///
  /// In en, this message translates to:
  /// **'{uniAbbr} {season} {year}'**
  String subjectTitle(Object season, Object uniAbbr, Object year);

  /// No description provided for @semesterFull.
  ///
  /// In en, this message translates to:
  /// **'{season} {year}'**
  String semesterFull(Object season, Object year);

  /// No description provided for @semester.
  ///
  /// In en, this message translates to:
  /// **'Semester'**
  String get semester;

  /// No description provided for @university.
  ///
  /// In en, this message translates to:
  /// **'University'**
  String get university;

  /// No description provided for @recents.
  ///
  /// In en, this message translates to:
  /// **'RECENTS'**
  String get recents;

  /// No description provided for @selectUniversity.
  ///
  /// In en, this message translates to:
  /// **'Select your university'**
  String get selectUniversity;

  /// No description provided for @selectSemester.
  ///
  /// In en, this message translates to:
  /// **'Select a semester'**
  String get selectSemester;

  /// No description provided for @options.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get options;

  /// No description provided for @please_select_a_university.
  ///
  /// In en, this message translates to:
  /// **'Please select a university.'**
  String get please_select_a_university;

  /// No description provided for @numOfOpen.
  ///
  /// In en, this message translates to:
  /// **'{openNum} open sections of {totalNum}'**
  String numOfOpen(Object openNum, Object totalNum);

  /// No description provided for @allSections.
  ///
  /// In en, this message translates to:
  /// **'ALL SECTIONS ({allSections})'**
  String allSections(Object allSections);

  /// No description provided for @closedSections.
  ///
  /// In en, this message translates to:
  /// **'CLOSED ({closedSections})'**
  String closedSections(Object closedSections);

  /// No description provided for @section.
  ///
  /// In en, this message translates to:
  /// **'SECTION'**
  String get section;

  /// No description provided for @index.
  ///
  /// In en, this message translates to:
  /// **'INDEX'**
  String get index;

  /// No description provided for @credits.
  ///
  /// In en, this message translates to:
  /// **'CREDITS'**
  String get credits;

  /// No description provided for @closedChannelTitleDesc.
  ///
  /// In en, this message translates to:
  /// **'Notify when sections close.'**
  String get closedChannelTitleDesc;

  /// No description provided for @openChannelTitleDesc.
  ///
  /// In en, this message translates to:
  /// **'Notify when sections open.'**
  String get openChannelTitleDesc;

  /// No description provided for @closedChannelTitle.
  ///
  /// In en, this message translates to:
  /// **'Closed Sections'**
  String get closedChannelTitle;

  /// No description provided for @openChannelTitle.
  ///
  /// In en, this message translates to:
  /// **'Open Sections'**
  String get openChannelTitle;

  /// No description provided for @genericChannelTitleDesc.
  ///
  /// In en, this message translates to:
  /// **'Announcements and app updates.'**
  String get genericChannelTitleDesc;

  /// No description provided for @genericChannelTitle.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get genericChannelTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
