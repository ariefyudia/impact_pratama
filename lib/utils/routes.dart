import 'package:flutter/material.dart';
import 'package:impact_pratama/main.dart';
import 'package:impact_pratama/screen/activity/activity_form.dart';
import 'package:impact_pratama/screen/activity/activity_page.dart';

const String mainRoute = '/';
const String activityRoute = '/activity';
const String activityFormRoute = '/activityForm';

class RoutePage {
  static Route<dynamic> allRoutes(RouteSettings route) {
    final args = route.arguments;
    switch (route.name) {
      case mainRoute:
        return MaterialPageRoute(builder: (_) => MyApp());

      case activityRoute:
        return MaterialPageRoute(builder: (_) => ActivityPage());

      case activityFormRoute:
        return MaterialPageRoute(
            builder: (_) => ActivityFormPage(
                  args: args as ActivityFormArgs,
                ));
    }
    return MaterialPageRoute(builder: (_) => MyApp());
  }
}
