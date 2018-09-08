import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/proto/model.pb.dart';
import '../search_context.dart';

abstract class HomeRouter {
  Future<bool> pop(BuildContext context);

  void gotoCourses(BuildContext context, String topicName);

  Future<bool> gotoOptions(BuildContext context);

  Future<bool> gotoSubjects(BuildContext context);

  void gotoCourse(BuildContext context, Course course);

  Future<bool> gotoSection(BuildContext context, SearchContext searchContext);
}
