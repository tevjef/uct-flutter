import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/proto/model.pb.dart';

abstract class HomeRouter {
  bool pop(BuildContext context);

  void gotoCourses(BuildContext context, String topicName);

  Future<bool> gotoOptions(BuildContext context);

  void gotoCourse(BuildContext context, Course course);

  void gotoSection(BuildContext context, Section section);
}
