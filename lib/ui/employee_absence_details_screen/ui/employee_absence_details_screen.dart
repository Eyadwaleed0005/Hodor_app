import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/app_system_ui.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/widgets/app_animations.dart';
import 'package:Hodor/core/widgets/app_error_view.dart';
import 'package:Hodor/core/widgets/default_app_header.dart';
import 'package:Hodor/ui/employee_absence_details_screen/logic/cubit/employee_absence_details_screen_cubit.dart';
import 'package:Hodor/ui/employee_absence_details_screen/ui/widgets/attendance_calendar_widget.dart';
import 'package:Hodor/ui/employee_absence_details_screen/ui/widgets/employee_absence_header_card.dart';
import 'package:Hodor/ui/employee_absence_details_screen/ui/widgets/employee_absence_record.dart';

class EmployeeAbsenceDetailsScreen extends StatelessWidget {
  final int employeeId;

  const EmployeeAbsenceDetailsScreen({super.key, required this.employeeId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return EmployeeAbsenceDetailsScreenCubit()
          ..getEmployeeAbsenceDetails(employeeId: employeeId);
      },
      child: _EmployeeAbsenceDetailsView(employeeId: employeeId),
    );
  }
}

class _EmployeeAbsenceDetailsView extends StatelessWidget {
  final int employeeId;

  const _EmployeeAbsenceDetailsView({required this.employeeId});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.light(),
      child: Scaffold(
        backgroundColor: ColorPalette.white,
        body: Column(
          children: [
            const DefaultAppHeader(),
            Expanded(
              child:
                  BlocBuilder<
                    EmployeeAbsenceDetailsScreenCubit,
                    EmployeeAbsenceDetailsScreenState
                  >(
                    builder: (context, state) {
                      return _buildContent(context: context, state: state);
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent({
    required BuildContext context,
    required EmployeeAbsenceDetailsScreenState state,
  }) {
    if (state is EmployeeAbsenceDetailsScreenInitial ||
        state is EmployeeAbsenceDetailsScreenLoading) {
      return const Center(
        child: CircularProgressIndicator(color: ColorPalette.blue),
      ).animate(effects: AppAnimations.fadeScale());
    }

    if (state is EmployeeAbsenceDetailsScreenFailure) {
      return AppErrorView(
        title: 'تعذر تحميل بيانات الموظف',
        message: 'حدث خطأ أثناء تحميل تفاصيل الحضور والغياب، حاول مرة أخرى.',
        icon: Icons.event_busy_outlined,
        color: ColorPalette.blue,
        onRetry: () {
          context
              .read<EmployeeAbsenceDetailsScreenCubit>()
              .getEmployeeAbsenceDetails(employeeId: employeeId);
        },
      ).animate(effects: AppAnimations.fadeScale());
    }

    if (state is EmployeeAbsenceDetailsScreenSuccess) {
      return _EmployeeAbsenceDetailsContent(state: state);
    }

    return const SizedBox.shrink();
  }
}

class _EmployeeAbsenceDetailsContent extends StatelessWidget {
  final EmployeeAbsenceDetailsScreenSuccess state;

  const _EmployeeAbsenceDetailsContent({required this.state});

  @override
  Widget build(BuildContext context) {
    final employee = state.data.employee;
    final absences = state.data.absences;

    final absenceDates = absences
        .map((absence) => absence.absenceDate)
        .toList();

    final records = absences
        .map((absence) => AbsenceRecord(date: absence.absenceDate))
        .toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          verticalSpace(8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: EmployeeAbsenceHeaderCard(
              employeeName: employee.name,

              // عدد الغياب الذي رجع للشهر الحالي.
              absenceCount: absences.length,

              salary: employee.salary.toStringAsFixed(2),
            ).animate(effects: AppAnimations.fadeSlideUp()),
          ),
          verticalSpace(8),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(color: ColorPalette.offWhite),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 22.h),
              child: Column(
                children: [
                  EmployeeAbsenceCalendar(absenceDates: absenceDates).animate(
                    effects: AppAnimations.fadeSlideUp(
                      delay: const Duration(milliseconds: 100),
                    ),
                  ),
                  verticalSpace(20),
                  EmployeeAbsenceRecord(records: records).animate(
                    effects: AppAnimations.fadeSlideUp(
                      delay: const Duration(milliseconds: 180),
                    ),
                  ),
                ],
              ),
            ),
          ).animate(
            effects: AppAnimations.fadeSlideUp(
              delay: const Duration(milliseconds: 120),
            ),
          ),
        ],
      ),
    );
  }
}
