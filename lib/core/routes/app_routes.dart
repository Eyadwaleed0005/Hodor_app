import 'package:flutter/material.dart';
import 'package:Hodor/ui/add_employee_screen/ui/add_employee_screen.dart';
import 'package:Hodor/ui/archive_screen/ui/archive_screen.dart';
import 'package:Hodor/ui/employee_absence_details_screen/ui/employee_absence_details_screen.dart';
import 'package:Hodor/ui/employee_details_screen/ui/employee_details_screen.dart';
import 'package:Hodor/ui/employee_reports_screen/ui/employee_reports_screen.dart';
import 'package:Hodor/ui/home_screen/ui/home_screen.dart';
import 'package:Hodor/ui/record_absence_screen/ui/absence_registration_screen.dart';
import 'package:Hodor/ui/splash_screen/ui/splash_screen.dart';
import 'package:Hodor/ui/start_screen/ui/start_screen.dart';
import 'route_names.dart';

class AppRoutes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case RouteNames.startScreen:
        return MaterialPageRoute(builder: (_) => const StartScreen());

      case RouteNames.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case RouteNames.absenceRegistrationScreen:
        return MaterialPageRoute(
          builder: (_) => const AbsenceRegistrationScreen(),
        );

      case RouteNames.addEmployee:
        return MaterialPageRoute(builder: (_) => const AddEmployeeScreen());

      case RouteNames.employeeAbsenceDetailsScreen:
        final employeeId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => EmployeeAbsenceDetailsScreen(employeeId: employeeId),
        );

      case RouteNames.employeeDetailsScreen:
        return MaterialPageRoute(builder: (_) => const EmployeeDetailsScreen());

      case RouteNames.employeeReportScreen:
        return MaterialPageRoute(builder: (_) => const EmployeeReportsScreen());
      
      case RouteNames.archiveScreen:
        return MaterialPageRoute(builder: (_) =>  ArchiveScreen());
    }

    return null;
  }
}
