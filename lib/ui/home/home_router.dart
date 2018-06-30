import 'package:flutter/material.dart';

import '../../data/proto/model.pb.dart';

abstract class HomeRouter {
  void gotoCourses(BuildContext context, String topicName);
  void gotoCourse(BuildContext context, Course course);
  void gotoSection(BuildContext context, Section section);
}
