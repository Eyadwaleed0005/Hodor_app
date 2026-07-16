import 'package:flutter/material.dart';
import 'package:Hodor/core/routes/route_names.dart';

class BottomNavRouter {
  const BottomNavRouter._();

  static String routeFromIndex(int index) {
    switch (index) {
      case 0:
        return RouteNames.homeScreen;
      case 1:
        return RouteNames.employeeDetailsScreen;
      case 2:
        return RouteNames.employeeReportScreen;
      case 3:
        return RouteNames.archiveScreen;
      // case 4:
      //  return RouteNames.profileScreen;
      default:
        return RouteNames.homeScreen;
    }
  }

  static void go(BuildContext context, int index) {
    final route = routeFromIndex(index);
    if (ModalRoute.of(context)?.settings.name == route) return;
    Navigator.pushReplacementNamed(context, route);
  }
}
