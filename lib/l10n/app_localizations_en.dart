// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get homeTitle => 'Tracked Sections';

  @override
  String get homeEmpty =>
      'You don\'t seem to be tracking any sections. Try adding some!';

  @override
  String get undo => 'Undo';

  @override
  String unsubscribeMessage(Object sectionName, Object sectionNumber) {
    return 'Unsubscribed from $sectionNumber of $sectionName.';
  }

  @override
  String headerMessage(Object meta, Object title) {
    return '$title ($meta)';
  }

  @override
  String meetingTime(Object endTime, Object startTime) {
    return '$startTime - $endTime';
  }

  @override
  String get subscribeReason => 'Subscribe to receive notifications';

  @override
  String professorList(Object firstProf, Object secondProf) {
    return '$firstProf | $secondProf';
  }

  @override
  String get add => 'Add';

  @override
  String get openStatus => 'Open';

  @override
  String get closedStatus => 'Closed';

  @override
  String allMeta(Object count) {
    return 'ALL ($count)';
  }

  @override
  String subjectTitle(Object season, Object uniAbbr, Object year) {
    return '$uniAbbr $season $year';
  }

  @override
  String semesterFull(Object season, Object year) {
    return '$season $year';
  }

  @override
  String get semester => 'Semester';

  @override
  String get university => 'University';

  @override
  String get recents => 'RECENTS';

  @override
  String get selectUniversity => 'Select your university';

  @override
  String get selectSemester => 'Select a semester';

  @override
  String get options => 'Options';

  @override
  String get please_select_a_university => 'Please select a university.';

  @override
  String numOfOpen(Object openNum, Object totalNum) {
    return '$openNum open sections of $totalNum';
  }

  @override
  String allSections(Object allSections) {
    return 'ALL SECTIONS ($allSections)';
  }

  @override
  String closedSections(Object closedSections) {
    return 'CLOSED ($closedSections)';
  }

  @override
  String get section => 'SECTION';

  @override
  String get index => 'INDEX';

  @override
  String get credits => 'CREDITS';

  @override
  String get closedChannelTitleDesc => 'Notify when sections close.';

  @override
  String get openChannelTitleDesc => 'Notify when sections open.';

  @override
  String get closedChannelTitle => 'Closed Sections';

  @override
  String get openChannelTitle => 'Open Sections';

  @override
  String get genericChannelTitleDesc => 'Announcements and app updates.';

  @override
  String get genericChannelTitle => 'Other';
}
