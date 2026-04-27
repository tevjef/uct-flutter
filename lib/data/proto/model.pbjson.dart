//
//  Generated code. Do not modify.
//  source: model.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use universityDescriptor instead')
const University$json = {
  '1': 'University',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'abbr', '3': 3, '4': 1, '5': 9, '10': 'abbr'},
    {'1': 'home_page', '3': 4, '4': 1, '5': 9, '10': 'homePage'},
    {
      '1': 'registration_page',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'registrationPage'
    },
    {'1': 'main_color', '3': 6, '4': 1, '5': 9, '10': 'mainColor'},
    {'1': 'accent_color', '3': 7, '4': 1, '5': 9, '10': 'accentColor'},
    {'1': 'topic_name', '3': 8, '4': 1, '5': 9, '10': 'topicName'},
    {'1': 'topic_id', '3': 9, '4': 1, '5': 9, '10': 'topicId'},
    {
      '1': 'resolved_semesters',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.ResolvedSemester',
      '10': 'resolvedSemesters'
    },
    {
      '1': 'subjects',
      '3': 11,
      '4': 3,
      '5': 11,
      '6': '.Subject',
      '10': 'subjects'
    },
    {
      '1': 'available_semesters',
      '3': 12,
      '4': 3,
      '5': 11,
      '6': '.Semester',
      '10': 'availableSemesters'
    },
    {
      '1': 'registrations',
      '3': 13,
      '4': 3,
      '5': 11,
      '6': '.Registration',
      '10': 'registrations'
    },
    {
      '1': 'metadata',
      '3': 14,
      '4': 3,
      '5': 11,
      '6': '.Metadata',
      '10': 'metadata'
    },
  ],
};

/// Descriptor for `University`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List universityDescriptor = $convert.base64Decode(
    'CgpVbml2ZXJzaXR5Eg4KAmlkGAEgASgDUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhIKBGFiYn'
    'IYAyABKAlSBGFiYnISGwoJaG9tZV9wYWdlGAQgASgJUghob21lUGFnZRIrChFyZWdpc3RyYXRp'
    'b25fcGFnZRgFIAEoCVIQcmVnaXN0cmF0aW9uUGFnZRIdCgptYWluX2NvbG9yGAYgASgJUgltYW'
    'luQ29sb3ISIQoMYWNjZW50X2NvbG9yGAcgASgJUgthY2NlbnRDb2xvchIdCgp0b3BpY19uYW1l'
    'GAggASgJUgl0b3BpY05hbWUSGQoIdG9waWNfaWQYCSABKAlSB3RvcGljSWQSQAoScmVzb2x2ZW'
    'Rfc2VtZXN0ZXJzGAogASgLMhEuUmVzb2x2ZWRTZW1lc3RlclIRcmVzb2x2ZWRTZW1lc3RlcnMS'
    'JAoIc3ViamVjdHMYCyADKAsyCC5TdWJqZWN0UghzdWJqZWN0cxI6ChNhdmFpbGFibGVfc2VtZX'
    'N0ZXJzGAwgAygLMgkuU2VtZXN0ZXJSEmF2YWlsYWJsZVNlbWVzdGVycxIzCg1yZWdpc3RyYXRp'
    'b25zGA0gAygLMg0uUmVnaXN0cmF0aW9uUg1yZWdpc3RyYXRpb25zEiUKCG1ldGFkYXRhGA4gAy'
    'gLMgkuTWV0YWRhdGFSCG1ldGFkYXRh');

@$core.Deprecated('Use subjectDescriptor instead')
const Subject$json = {
  '1': 'Subject',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'university_id', '3': 2, '4': 1, '5': 3, '10': 'universityId'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'number', '3': 4, '4': 1, '5': 9, '10': 'number'},
    {'1': 'season', '3': 5, '4': 1, '5': 9, '10': 'season'},
    {'1': 'year', '3': 6, '4': 1, '5': 9, '10': 'year'},
    {'1': 'topic_name', '3': 7, '4': 1, '5': 9, '10': 'topicName'},
    {'1': 'topic_id', '3': 8, '4': 1, '5': 9, '10': 'topicId'},
    {'1': 'courses', '3': 9, '4': 3, '5': 11, '6': '.Course', '10': 'courses'},
    {
      '1': 'metadata',
      '3': 10,
      '4': 3,
      '5': 11,
      '6': '.Metadata',
      '10': 'metadata'
    },
  ],
};

/// Descriptor for `Subject`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subjectDescriptor = $convert.base64Decode(
    'CgdTdWJqZWN0Eg4KAmlkGAEgASgDUgJpZBIjCg11bml2ZXJzaXR5X2lkGAIgASgDUgx1bml2ZX'
    'JzaXR5SWQSEgoEbmFtZRgDIAEoCVIEbmFtZRIWCgZudW1iZXIYBCABKAlSBm51bWJlchIWCgZz'
    'ZWFzb24YBSABKAlSBnNlYXNvbhISCgR5ZWFyGAYgASgJUgR5ZWFyEh0KCnRvcGljX25hbWUYBy'
    'ABKAlSCXRvcGljTmFtZRIZCgh0b3BpY19pZBgIIAEoCVIHdG9waWNJZBIhCgdjb3Vyc2VzGAkg'
    'AygLMgcuQ291cnNlUgdjb3Vyc2VzEiUKCG1ldGFkYXRhGAogAygLMgkuTWV0YWRhdGFSCG1ldG'
    'FkYXRh');

@$core.Deprecated('Use courseDescriptor instead')
const Course$json = {
  '1': 'Course',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'subject_id', '3': 2, '4': 1, '5': 3, '10': 'subjectId'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'number', '3': 4, '4': 1, '5': 9, '10': 'number'},
    {'1': 'synopsis', '3': 5, '4': 1, '5': 9, '10': 'synopsis'},
    {'1': 'topic_name', '3': 6, '4': 1, '5': 9, '10': 'topicName'},
    {'1': 'topic_id', '3': 7, '4': 1, '5': 9, '10': 'topicId'},
    {
      '1': 'sections',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.Section',
      '10': 'sections'
    },
    {
      '1': 'metadata',
      '3': 9,
      '4': 3,
      '5': 11,
      '6': '.Metadata',
      '10': 'metadata'
    },
  ],
};

/// Descriptor for `Course`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List courseDescriptor = $convert.base64Decode(
    'CgZDb3Vyc2USDgoCaWQYASABKANSAmlkEh0KCnN1YmplY3RfaWQYAiABKANSCXN1YmplY3RJZB'
    'ISCgRuYW1lGAMgASgJUgRuYW1lEhYKBm51bWJlchgEIAEoCVIGbnVtYmVyEhoKCHN5bm9wc2lz'
    'GAUgASgJUghzeW5vcHNpcxIdCgp0b3BpY19uYW1lGAYgASgJUgl0b3BpY05hbWUSGQoIdG9waW'
    'NfaWQYByABKAlSB3RvcGljSWQSJAoIc2VjdGlvbnMYCCADKAsyCC5TZWN0aW9uUghzZWN0aW9u'
    'cxIlCghtZXRhZGF0YRgJIAMoCzIJLk1ldGFkYXRhUghtZXRhZGF0YQ==');

@$core.Deprecated('Use sectionDescriptor instead')
const Section$json = {
  '1': 'Section',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'course_id', '3': 2, '4': 1, '5': 3, '10': 'courseId'},
    {'1': 'number', '3': 3, '4': 1, '5': 9, '10': 'number'},
    {'1': 'call_number', '3': 4, '4': 1, '5': 9, '10': 'callNumber'},
    {'1': 'max', '3': 5, '4': 1, '5': 3, '10': 'max'},
    {'1': 'now', '3': 6, '4': 1, '5': 3, '10': 'now'},
    {'1': 'status', '3': 7, '4': 1, '5': 9, '10': 'status'},
    {'1': 'credits', '3': 8, '4': 1, '5': 9, '10': 'credits'},
    {'1': 'topic_name', '3': 9, '4': 1, '5': 9, '10': 'topicName'},
    {'1': 'topic_id', '3': 10, '4': 1, '5': 9, '10': 'topicId'},
    {
      '1': 'meetings',
      '3': 11,
      '4': 3,
      '5': 11,
      '6': '.Meeting',
      '10': 'meetings'
    },
    {
      '1': 'instructors',
      '3': 12,
      '4': 3,
      '5': 11,
      '6': '.Instructor',
      '10': 'instructors'
    },
    {'1': 'books', '3': 13, '4': 3, '5': 11, '6': '.Book', '10': 'books'},
    {
      '1': 'metadata',
      '3': 14,
      '4': 3,
      '5': 11,
      '6': '.Metadata',
      '10': 'metadata'
    },
  ],
};

/// Descriptor for `Section`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sectionDescriptor = $convert.base64Decode(
    'CgdTZWN0aW9uEg4KAmlkGAEgASgDUgJpZBIbCgljb3Vyc2VfaWQYAiABKANSCGNvdXJzZUlkEh'
    'YKBm51bWJlchgDIAEoCVIGbnVtYmVyEh8KC2NhbGxfbnVtYmVyGAQgASgJUgpjYWxsTnVtYmVy'
    'EhAKA21heBgFIAEoA1IDbWF4EhAKA25vdxgGIAEoA1IDbm93EhYKBnN0YXR1cxgHIAEoCVIGc3'
    'RhdHVzEhgKB2NyZWRpdHMYCCABKAlSB2NyZWRpdHMSHQoKdG9waWNfbmFtZRgJIAEoCVIJdG9w'
    'aWNOYW1lEhkKCHRvcGljX2lkGAogASgJUgd0b3BpY0lkEiQKCG1lZXRpbmdzGAsgAygLMgguTW'
    'VldGluZ1IIbWVldGluZ3MSLQoLaW5zdHJ1Y3RvcnMYDCADKAsyCy5JbnN0cnVjdG9yUgtpbnN0'
    'cnVjdG9ycxIbCgVib29rcxgNIAMoCzIFLkJvb2tSBWJvb2tzEiUKCG1ldGFkYXRhGA4gAygLMg'
    'kuTWV0YWRhdGFSCG1ldGFkYXRh');

@$core.Deprecated('Use meetingDescriptor instead')
const Meeting$json = {
  '1': 'Meeting',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'section_id', '3': 2, '4': 1, '5': 3, '10': 'sectionId'},
    {'1': 'room', '3': 3, '4': 1, '5': 9, '10': 'room'},
    {'1': 'day', '3': 4, '4': 1, '5': 9, '10': 'day'},
    {'1': 'start_time', '3': 5, '4': 1, '5': 9, '10': 'startTime'},
    {'1': 'end_time', '3': 6, '4': 1, '5': 9, '10': 'endTime'},
    {'1': 'class_type', '3': 7, '4': 1, '5': 9, '10': 'classType'},
    {'1': 'index', '3': 8, '4': 1, '5': 5, '10': 'index'},
    {
      '1': 'metadata',
      '3': 9,
      '4': 3,
      '5': 11,
      '6': '.Metadata',
      '10': 'metadata'
    },
  ],
};

/// Descriptor for `Meeting`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List meetingDescriptor = $convert.base64Decode(
    'CgdNZWV0aW5nEg4KAmlkGAEgASgDUgJpZBIdCgpzZWN0aW9uX2lkGAIgASgDUglzZWN0aW9uSW'
    'QSEgoEcm9vbRgDIAEoCVIEcm9vbRIQCgNkYXkYBCABKAlSA2RheRIdCgpzdGFydF90aW1lGAUg'
    'ASgJUglzdGFydFRpbWUSGQoIZW5kX3RpbWUYBiABKAlSB2VuZFRpbWUSHQoKY2xhc3NfdHlwZR'
    'gHIAEoCVIJY2xhc3NUeXBlEhQKBWluZGV4GAggASgFUgVpbmRleBIlCghtZXRhZGF0YRgJIAMo'
    'CzIJLk1ldGFkYXRhUghtZXRhZGF0YQ==');

@$core.Deprecated('Use instructorDescriptor instead')
const Instructor$json = {
  '1': 'Instructor',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'section_id', '3': 2, '4': 1, '5': 3, '10': 'sectionId'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'index', '3': 4, '4': 1, '5': 5, '10': 'index'},
  ],
};

/// Descriptor for `Instructor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List instructorDescriptor = $convert.base64Decode(
    'CgpJbnN0cnVjdG9yEg4KAmlkGAEgASgDUgJpZBIdCgpzZWN0aW9uX2lkGAIgASgDUglzZWN0aW'
    '9uSWQSEgoEbmFtZRgDIAEoCVIEbmFtZRIUCgVpbmRleBgEIAEoBVIFaW5kZXg=');

@$core.Deprecated('Use bookDescriptor instead')
const Book$json = {
  '1': 'Book',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'section_id', '3': 2, '4': 1, '5': 3, '10': 'sectionId'},
    {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    {'1': 'url', '3': 4, '4': 1, '5': 9, '10': 'url'},
  ],
};

/// Descriptor for `Book`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bookDescriptor = $convert.base64Decode(
    'CgRCb29rEg4KAmlkGAEgASgDUgJpZBIdCgpzZWN0aW9uX2lkGAIgASgDUglzZWN0aW9uSWQSFA'
    'oFdGl0bGUYAyABKAlSBXRpdGxlEhAKA3VybBgEIAEoCVIDdXJs');

@$core.Deprecated('Use metadataDescriptor instead')
const Metadata$json = {
  '1': 'Metadata',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'university_id', '3': 2, '4': 1, '5': 3, '10': 'universityId'},
    {'1': 'subject_id', '3': 3, '4': 1, '5': 3, '10': 'subjectId'},
    {'1': 'course_id', '3': 4, '4': 1, '5': 3, '10': 'courseId'},
    {'1': 'section_id', '3': 5, '4': 1, '5': 3, '10': 'sectionId'},
    {'1': 'meeting_id', '3': 6, '4': 1, '5': 3, '10': 'meetingId'},
    {'1': 'title', '3': 7, '4': 1, '5': 9, '10': 'title'},
    {'1': 'content', '3': 8, '4': 1, '5': 9, '10': 'content'},
  ],
};

/// Descriptor for `Metadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List metadataDescriptor = $convert.base64Decode(
    'CghNZXRhZGF0YRIOCgJpZBgBIAEoA1ICaWQSIwoNdW5pdmVyc2l0eV9pZBgCIAEoA1IMdW5pdm'
    'Vyc2l0eUlkEh0KCnN1YmplY3RfaWQYAyABKANSCXN1YmplY3RJZBIbCgljb3Vyc2VfaWQYBCAB'
    'KANSCGNvdXJzZUlkEh0KCnNlY3Rpb25faWQYBSABKANSCXNlY3Rpb25JZBIdCgptZWV0aW5nX2'
    'lkGAYgASgDUgltZWV0aW5nSWQSFAoFdGl0bGUYByABKAlSBXRpdGxlEhgKB2NvbnRlbnQYCCAB'
    'KAlSB2NvbnRlbnQ=');

@$core.Deprecated('Use registrationDescriptor instead')
const Registration$json = {
  '1': 'Registration',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'university_id', '3': 2, '4': 1, '5': 3, '10': 'universityId'},
    {'1': 'period', '3': 3, '4': 1, '5': 9, '10': 'period'},
    {'1': 'period_date', '3': 4, '4': 1, '5': 3, '10': 'periodDate'},
  ],
};

/// Descriptor for `Registration`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registrationDescriptor = $convert.base64Decode(
    'CgxSZWdpc3RyYXRpb24SDgoCaWQYASABKANSAmlkEiMKDXVuaXZlcnNpdHlfaWQYAiABKANSDH'
    'VuaXZlcnNpdHlJZBIWCgZwZXJpb2QYAyABKAlSBnBlcmlvZBIfCgtwZXJpb2RfZGF0ZRgEIAEo'
    'A1IKcGVyaW9kRGF0ZQ==');

@$core.Deprecated('Use resolvedSemesterDescriptor instead')
const ResolvedSemester$json = {
  '1': 'ResolvedSemester',
  '2': [
    {
      '1': 'current',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.Semester',
      '10': 'current'
    },
    {'1': 'last', '3': 2, '4': 1, '5': 11, '6': '.Semester', '10': 'last'},
    {'1': 'next', '3': 3, '4': 1, '5': 11, '6': '.Semester', '10': 'next'},
  ],
};

/// Descriptor for `ResolvedSemester`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolvedSemesterDescriptor = $convert.base64Decode(
    'ChBSZXNvbHZlZFNlbWVzdGVyEiMKB2N1cnJlbnQYASABKAsyCS5TZW1lc3RlclIHY3VycmVudB'
    'IdCgRsYXN0GAIgASgLMgkuU2VtZXN0ZXJSBGxhc3QSHQoEbmV4dBgDIAEoCzIJLlNlbWVzdGVy'
    'UgRuZXh0');

@$core.Deprecated('Use semesterDescriptor instead')
const Semester$json = {
  '1': 'Semester',
  '2': [
    {'1': 'year', '3': 1, '4': 1, '5': 5, '10': 'year'},
    {'1': 'season', '3': 2, '4': 1, '5': 9, '10': 'season'},
  ],
};

/// Descriptor for `Semester`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List semesterDescriptor = $convert.base64Decode(
    'CghTZW1lc3RlchISCgR5ZWFyGAEgASgFUgR5ZWFyEhYKBnNlYXNvbhgCIAEoCVIGc2Vhc29u');

@$core.Deprecated('Use uCTNotificationDescriptor instead')
const UCTNotification$json = {
  '1': 'UCTNotification',
  '2': [
    {'1': 'notification_id', '3': 1, '4': 1, '5': 3, '10': 'notificationId'},
    {'1': 'topic_name', '3': 2, '4': 1, '5': 9, '10': 'topicName'},
    {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    {
      '1': 'university',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.University',
      '10': 'university'
    },
  ],
};

/// Descriptor for `UCTNotification`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uCTNotificationDescriptor = $convert.base64Decode(
    'Cg9VQ1ROb3RpZmljYXRpb24SJwoPbm90aWZpY2F0aW9uX2lkGAEgASgDUg5ub3RpZmljYXRpb2'
    '5JZBIdCgp0b3BpY19uYW1lGAIgASgJUgl0b3BpY05hbWUSFgoGc3RhdHVzGAMgASgJUgZzdGF0'
    'dXMSKwoKdW5pdmVyc2l0eRgEIAEoCzILLlVuaXZlcnNpdHlSCnVuaXZlcnNpdHk=');

@$core.Deprecated('Use responseDescriptor instead')
const Response$json = {
  '1': 'Response',
  '2': [
    {'1': 'meta', '3': 1, '4': 1, '5': 11, '6': '.Meta', '10': 'meta'},
    {'1': 'data', '3': 2, '4': 1, '5': 11, '6': '.Data', '10': 'data'},
  ],
};

/// Descriptor for `Response`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List responseDescriptor = $convert.base64Decode(
    'CghSZXNwb25zZRIZCgRtZXRhGAEgASgLMgUuTWV0YVIEbWV0YRIZCgRkYXRhGAIgASgLMgUuRG'
    'F0YVIEZGF0YQ==');

@$core.Deprecated('Use metaDescriptor instead')
const Meta$json = {
  '1': 'Meta',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 5, '10': 'code'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `Meta`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List metaDescriptor = $convert.base64Decode(
    'CgRNZXRhEhIKBGNvZGUYASABKAVSBGNvZGUSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use dataDescriptor instead')
const Data$json = {
  '1': 'Data',
  '2': [
    {
      '1': 'universities',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.University',
      '10': 'universities'
    },
    {
      '1': 'subjects',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.Subject',
      '10': 'subjects'
    },
    {'1': 'courses', '3': 3, '4': 3, '5': 11, '6': '.Course', '10': 'courses'},
    {
      '1': 'sections',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.Section',
      '10': 'sections'
    },
    {
      '1': 'university',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.University',
      '10': 'university'
    },
    {'1': 'subject', '3': 6, '4': 1, '5': 11, '6': '.Subject', '10': 'subject'},
    {'1': 'course', '3': 7, '4': 1, '5': 11, '6': '.Course', '10': 'course'},
    {'1': 'section', '3': 8, '4': 1, '5': 11, '6': '.Section', '10': 'section'},
    {
      '1': 'subscription_view',
      '3': 9,
      '4': 3,
      '5': 11,
      '6': '.SubscriptionView',
      '10': 'subscriptionView'
    },
  ],
};

/// Descriptor for `Data`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataDescriptor = $convert.base64Decode(
    'CgREYXRhEi8KDHVuaXZlcnNpdGllcxgBIAMoCzILLlVuaXZlcnNpdHlSDHVuaXZlcnNpdGllcx'
    'IkCghzdWJqZWN0cxgCIAMoCzIILlN1YmplY3RSCHN1YmplY3RzEiEKB2NvdXJzZXMYAyADKAsy'
    'By5Db3Vyc2VSB2NvdXJzZXMSJAoIc2VjdGlvbnMYBCADKAsyCC5TZWN0aW9uUghzZWN0aW9ucx'
    'IrCgp1bml2ZXJzaXR5GAUgASgLMgsuVW5pdmVyc2l0eVIKdW5pdmVyc2l0eRIiCgdzdWJqZWN0'
    'GAYgASgLMgguU3ViamVjdFIHc3ViamVjdBIfCgZjb3Vyc2UYByABKAsyBy5Db3Vyc2VSBmNvdX'
    'JzZRIiCgdzZWN0aW9uGAggASgLMgguU2VjdGlvblIHc2VjdGlvbhI+ChFzdWJzY3JpcHRpb25f'
    'dmlldxgJIAMoCzIRLlN1YnNjcmlwdGlvblZpZXdSEHN1YnNjcmlwdGlvblZpZXc=');

@$core.Deprecated('Use subscriptionDescriptor instead')
const Subscription$json = {
  '1': 'Subscription',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'os', '3': 2, '4': 1, '5': 9, '10': 'os'},
    {'1': 'is_subscribed', '3': 3, '4': 1, '5': 9, '10': 'isSubscribed'},
    {'1': 'topic_name', '3': 4, '4': 1, '5': 9, '10': 'topicName'},
    {'1': 'fcm_token', '3': 5, '4': 1, '5': 9, '10': 'fcmToken'},
    {'1': 'created_at', '3': 6, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `Subscription`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscriptionDescriptor = $convert.base64Decode(
    'CgxTdWJzY3JpcHRpb24SDgoCaWQYASABKAlSAmlkEg4KAm9zGAIgASgJUgJvcxIjCg1pc19zdW'
    'JzY3JpYmVkGAMgASgJUgxpc1N1YnNjcmliZWQSHQoKdG9waWNfbmFtZRgEIAEoCVIJdG9waWNO'
    'YW1lEhsKCWZjbV90b2tlbhgFIAEoCVIIZmNtVG9rZW4SHQoKY3JlYXRlZF9hdBgGIAEoCVIJY3'
    'JlYXRlZEF0');

@$core.Deprecated('Use subscriptionViewDescriptor instead')
const SubscriptionView$json = {
  '1': 'SubscriptionView',
  '2': [
    {'1': 'topic_name', '3': 1, '4': 1, '5': 9, '10': 'topicName'},
    {'1': 'subscribers', '3': 2, '4': 1, '5': 3, '10': 'subscribers'},
    {'1': 'is_hot', '3': 3, '4': 1, '5': 8, '10': 'isHot'},
  ],
};

/// Descriptor for `SubscriptionView`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscriptionViewDescriptor = $convert.base64Decode(
    'ChBTdWJzY3JpcHRpb25WaWV3Eh0KCnRvcGljX25hbWUYASABKAlSCXRvcGljTmFtZRIgCgtzdW'
    'JzY3JpYmVycxgCIAEoA1ILc3Vic2NyaWJlcnMSFQoGaXNfaG90GAMgASgIUgVpc0hvdA==');
