///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes

const University$json = const {
  '1': 'University',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'abbr', '3': 3, '4': 1, '5': 9, '10': 'abbr'},
    const {'1': 'home_page', '3': 4, '4': 1, '5': 9, '10': 'homePage'},
    const {'1': 'registration_page', '3': 5, '4': 1, '5': 9, '10': 'registrationPage'},
    const {'1': 'main_color', '3': 6, '4': 1, '5': 9, '10': 'mainColor'},
    const {'1': 'accent_color', '3': 7, '4': 1, '5': 9, '10': 'accentColor'},
    const {'1': 'topic_name', '3': 8, '4': 1, '5': 9, '10': 'topicName'},
    const {'1': 'topic_id', '3': 9, '4': 1, '5': 9, '10': 'topicId'},
    const {'1': 'resolved_semesters', '3': 10, '4': 1, '5': 11, '6': '.ResolvedSemester', '10': 'resolvedSemesters'},
    const {'1': 'subjects', '3': 11, '4': 3, '5': 11, '6': '.Subject', '10': 'subjects'},
    const {'1': 'available_semesters', '3': 12, '4': 3, '5': 11, '6': '.Semester', '10': 'availableSemesters'},
    const {'1': 'registrations', '3': 13, '4': 3, '5': 11, '6': '.Registration', '10': 'registrations'},
    const {'1': 'metadata', '3': 14, '4': 3, '5': 11, '6': '.Metadata', '10': 'metadata'},
  ],
};

const Subject$json = const {
  '1': 'Subject',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    const {'1': 'university_id', '3': 2, '4': 1, '5': 3, '10': 'universityId'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'number', '3': 4, '4': 1, '5': 9, '10': 'number'},
    const {'1': 'season', '3': 5, '4': 1, '5': 9, '10': 'season'},
    const {'1': 'year', '3': 6, '4': 1, '5': 9, '10': 'year'},
    const {'1': 'topic_name', '3': 7, '4': 1, '5': 9, '10': 'topicName'},
    const {'1': 'topic_id', '3': 8, '4': 1, '5': 9, '10': 'topicId'},
    const {'1': 'courses', '3': 9, '4': 3, '5': 11, '6': '.Course', '10': 'courses'},
    const {'1': 'metadata', '3': 10, '4': 3, '5': 11, '6': '.Metadata', '10': 'metadata'},
  ],
};

const Course$json = const {
  '1': 'Course',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    const {'1': 'subject_id', '3': 2, '4': 1, '5': 3, '10': 'subjectId'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'number', '3': 4, '4': 1, '5': 9, '10': 'number'},
    const {'1': 'synopsis', '3': 5, '4': 1, '5': 9, '10': 'synopsis'},
    const {'1': 'topic_name', '3': 6, '4': 1, '5': 9, '10': 'topicName'},
    const {'1': 'topic_id', '3': 7, '4': 1, '5': 9, '10': 'topicId'},
    const {'1': 'sections', '3': 8, '4': 3, '5': 11, '6': '.Section', '10': 'sections'},
    const {'1': 'metadata', '3': 9, '4': 3, '5': 11, '6': '.Metadata', '10': 'metadata'},
  ],
};

const Section$json = const {
  '1': 'Section',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    const {'1': 'course_id', '3': 2, '4': 1, '5': 3, '10': 'courseId'},
    const {'1': 'number', '3': 3, '4': 1, '5': 9, '10': 'number'},
    const {'1': 'call_number', '3': 4, '4': 1, '5': 9, '10': 'callNumber'},
    const {'1': 'max', '3': 5, '4': 1, '5': 3, '10': 'max'},
    const {'1': 'now', '3': 6, '4': 1, '5': 3, '10': 'now'},
    const {'1': 'status', '3': 7, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'credits', '3': 8, '4': 1, '5': 9, '10': 'credits'},
    const {'1': 'topic_name', '3': 9, '4': 1, '5': 9, '10': 'topicName'},
    const {'1': 'topic_id', '3': 10, '4': 1, '5': 9, '10': 'topicId'},
    const {'1': 'meetings', '3': 11, '4': 3, '5': 11, '6': '.Meeting', '10': 'meetings'},
    const {'1': 'instructors', '3': 12, '4': 3, '5': 11, '6': '.Instructor', '10': 'instructors'},
    const {'1': 'books', '3': 13, '4': 3, '5': 11, '6': '.Book', '10': 'books'},
    const {'1': 'metadata', '3': 14, '4': 3, '5': 11, '6': '.Metadata', '10': 'metadata'},
  ],
};

const Meeting$json = const {
  '1': 'Meeting',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    const {'1': 'section_id', '3': 2, '4': 1, '5': 3, '10': 'sectionId'},
    const {'1': 'room', '3': 3, '4': 1, '5': 9, '10': 'room'},
    const {'1': 'day', '3': 4, '4': 1, '5': 9, '10': 'day'},
    const {'1': 'start_time', '3': 5, '4': 1, '5': 9, '10': 'startTime'},
    const {'1': 'end_time', '3': 6, '4': 1, '5': 9, '10': 'endTime'},
    const {'1': 'class_type', '3': 7, '4': 1, '5': 9, '10': 'classType'},
    const {'1': 'index', '3': 8, '4': 1, '5': 5, '10': 'index'},
    const {'1': 'metadata', '3': 9, '4': 3, '5': 11, '6': '.Metadata', '10': 'metadata'},
  ],
};

const Instructor$json = const {
  '1': 'Instructor',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    const {'1': 'section_id', '3': 2, '4': 1, '5': 3, '10': 'sectionId'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'index', '3': 4, '4': 1, '5': 5, '10': 'index'},
  ],
};

const Book$json = const {
  '1': 'Book',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    const {'1': 'section_id', '3': 2, '4': 1, '5': 3, '10': 'sectionId'},
    const {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'url', '3': 4, '4': 1, '5': 9, '10': 'url'},
  ],
};

const Metadata$json = const {
  '1': 'Metadata',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    const {'1': 'university_id', '3': 2, '4': 1, '5': 3, '10': 'universityId'},
    const {'1': 'subject_id', '3': 3, '4': 1, '5': 3, '10': 'subjectId'},
    const {'1': 'course_id', '3': 4, '4': 1, '5': 3, '10': 'courseId'},
    const {'1': 'section_id', '3': 5, '4': 1, '5': 3, '10': 'sectionId'},
    const {'1': 'meeting_id', '3': 6, '4': 1, '5': 3, '10': 'meetingId'},
    const {'1': 'title', '3': 7, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'content', '3': 8, '4': 1, '5': 9, '10': 'content'},
  ],
};

const Registration$json = const {
  '1': 'Registration',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    const {'1': 'university_id', '3': 2, '4': 1, '5': 3, '10': 'universityId'},
    const {'1': 'period', '3': 3, '4': 1, '5': 9, '10': 'period'},
    const {'1': 'period_date', '3': 4, '4': 1, '5': 3, '10': 'periodDate'},
  ],
};

const ResolvedSemester$json = const {
  '1': 'ResolvedSemester',
  '2': const [
    const {'1': 'current', '3': 1, '4': 1, '5': 11, '6': '.Semester', '10': 'current'},
    const {'1': 'last', '3': 2, '4': 1, '5': 11, '6': '.Semester', '10': 'last'},
    const {'1': 'next', '3': 3, '4': 1, '5': 11, '6': '.Semester', '10': 'next'},
  ],
};

const Semester$json = const {
  '1': 'Semester',
  '2': const [
    const {'1': 'year', '3': 1, '4': 1, '5': 5, '10': 'year'},
    const {'1': 'season', '3': 2, '4': 1, '5': 9, '10': 'season'},
  ],
};

const UCTNotification$json = const {
  '1': 'UCTNotification',
  '2': const [
    const {'1': 'notification_id', '3': 1, '4': 1, '5': 3, '10': 'notificationId'},
    const {'1': 'topic_name', '3': 2, '4': 1, '5': 9, '10': 'topicName'},
    const {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'university', '3': 4, '4': 1, '5': 11, '6': '.University', '10': 'university'},
  ],
};

const Response$json = const {
  '1': 'Response',
  '2': const [
    const {'1': 'meta', '3': 1, '4': 1, '5': 11, '6': '.Meta', '10': 'meta'},
    const {'1': 'data', '3': 2, '4': 1, '5': 11, '6': '.Data', '10': 'data'},
  ],
};

const Meta$json = const {
  '1': 'Meta',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 5, '10': 'code'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

const Data$json = const {
  '1': 'Data',
  '2': const [
    const {'1': 'universities', '3': 1, '4': 3, '5': 11, '6': '.University', '10': 'universities'},
    const {'1': 'subjects', '3': 2, '4': 3, '5': 11, '6': '.Subject', '10': 'subjects'},
    const {'1': 'courses', '3': 3, '4': 3, '5': 11, '6': '.Course', '10': 'courses'},
    const {'1': 'sections', '3': 4, '4': 3, '5': 11, '6': '.Section', '10': 'sections'},
    const {'1': 'university', '3': 5, '4': 1, '5': 11, '6': '.University', '10': 'university'},
    const {'1': 'subject', '3': 6, '4': 1, '5': 11, '6': '.Subject', '10': 'subject'},
    const {'1': 'course', '3': 7, '4': 1, '5': 11, '6': '.Course', '10': 'course'},
    const {'1': 'section', '3': 8, '4': 1, '5': 11, '6': '.Section', '10': 'section'},
    const {'1': 'subscription_view', '3': 9, '4': 3, '5': 11, '6': '.SubscriptionView', '10': 'subscriptionView'},
  ],
};

const Subscription$json = const {
  '1': 'Subscription',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'os', '3': 2, '4': 1, '5': 9, '10': 'os'},
    const {'1': 'is_subscribed', '3': 3, '4': 1, '5': 9, '10': 'isSubscribed'},
    const {'1': 'topic_name', '3': 4, '4': 1, '5': 9, '10': 'topicName'},
    const {'1': 'fcm_token', '3': 5, '4': 1, '5': 9, '10': 'fcmToken'},
    const {'1': 'created_at', '3': 6, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

const SubscriptionView$json = const {
  '1': 'SubscriptionView',
  '2': const [
    const {'1': 'topic_name', '3': 1, '4': 1, '5': 9, '10': 'topicName'},
    const {'1': 'subscribers', '3': 2, '4': 1, '5': 3, '10': 'subscribers'},
    const {'1': 'is_hot', '3': 3, '4': 1, '5': 8, '10': 'isHot'},
  ],
};

