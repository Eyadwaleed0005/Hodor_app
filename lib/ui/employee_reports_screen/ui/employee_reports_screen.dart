import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/app_system_ui.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/routes/bottom_nav_router.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';
import 'package:Hodor/core/widgets/app_animations.dart';
import 'package:Hodor/core/widgets/app_bottom_nav_bar.dart';
import 'package:Hodor/core/widgets/app_error_view.dart';
import 'package:Hodor/core/widgets/app_search_field.dart';
import 'package:Hodor/core/widgets/employees_empty_view.dart';
import 'package:Hodor/core/widgets/screen_title.dart';
import 'package:Hodor/ui/employee_reports_screen/logic/cubit/employee_reports_screen_cubit.dart';
import 'package:Hodor/ui/employee_reports_screen/ui/widgets/employee_salary_report_bottom_sheet.dart';
import 'package:Hodor/ui/employee_reports_screen/ui/widgets/employee_salary_report_card.dart';
import 'package:Hodor/ui/employee_reports_screen/ui/widgets/employee_salary_report_card_skeleton.dart';
import 'package:Hodor/ui/home_screen/ui/widgets/home_header.dart';

class EmployeeReportsScreen extends StatelessWidget {
  const EmployeeReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return EmployeeReportsScreenCubit()..getEmployeeReports();
      },
      child: const _EmployeeReportsScreenBody(),
    );
  }
}

class _EmployeeReportsScreenBody extends StatelessWidget {
  const _EmployeeReportsScreenBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EmployeeReportsScreenCubit>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.light(),
      child: Scaffold(
        backgroundColor: ColorPalette.white,
        bottomNavigationBar: AppBottomNavBar(
          currentIndex: 2,
          onTap: (index) {
            BottomNavRouter.go(context, index);
          },
        ),
        body: Column(
          children: [
            const HomeHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 24.h,
                      ),
                      child: const ScreenTitle(
                        title: 'تقارير الموظفين',
                        subtitle: 'متابعة الالتزام والراتب المقترح',
                        icon: Icons.bar_chart_rounded,
                        iconBackgroundColor: ColorPalette.blue,
                        iconColor: ColorPalette.blue,
                      ).animate(effects: AppAnimations.fadeSlideUp()),
                    ),
                    Container(
                      width: double.infinity,
                      color: ColorPalette.offWhite,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 22.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppSearchField(
                              controller: cubit.searchController,
                              onChanged: cubit.searchEmployeeReports,
                            ).animate(
                              effects: AppAnimations.fadeSlideUp(
                                delay: const Duration(milliseconds: 100),
                              ),
                            ),
                            verticalSpace(20),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'تقرير الالتزام',
                                style: Textstyles.font18BlackBold(),
                              ),
                            ).animate(
                              effects: AppAnimations.fadeSlideRight(
                                delay: const Duration(milliseconds: 180),
                              ),
                            ),
                            verticalSpace(10),
                            BlocBuilder<
                              EmployeeReportsScreenCubit,
                              EmployeeReportsScreenState
                            >(
                              builder: (context, state) {
                                return _buildContent(
                                  context: context,
                                  cubit: cubit,
                                  state: state,
                                );
                              },
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent({
    required BuildContext context,
    required EmployeeReportsScreenCubit cubit,
    required EmployeeReportsScreenState state,
  }) {
    if (state is EmployeeReportsScreenInitial ||
        state is EmployeeReportsScreenLoading) {
      return _buildSkeletonLoading();
    }

    if (state is EmployeeReportsScreenFailure) {
      return AppErrorView(
        title: 'تعذر تحميل تقارير الموظفين',
        message: 'حدث خطأ أثناء تحميل بيانات التقارير، حاول مرة أخرى.',
        icon: Icons.bar_chart_rounded,
        color: ColorPalette.blue,
        onRetry: cubit.getEmployeeReports,
      ).animate(effects: AppAnimations.fadeScale());
    }

    if (state is EmployeeReportsScreenSuccess) {
      if (state.reports.isEmpty) {
        if (state.isSearching) {
          return EmployeesEmptyView.noSearchResults().animate(
            effects: AppAnimations.fadeScale(),
          );
        }

        return EmployeesEmptyView.noEmployeesInDatabase().animate(
          effects: AppAnimations.fadeScale(),
        );
      }

      return ListView.separated(
        itemCount: state.reports.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (_, __) {
          return verticalSpace(12);
        },
        itemBuilder: (context, index) {
          final employee = state.reports[index];

          return EmployeeSalaryReportCard(
            employeeName: employee.name,
            commitmentPercentage: employee.commitmentPercentage,
            suggestedSalary: employee.suggestedSalary,
            onTapDetails: () {
              _showEmployeeReportDetails(context: context, employee: employee);
            },
          ).animate(
            effects: AppAnimations.fadeSlideUp(
              delay: Duration(milliseconds: 80 * index),
            ),
          );
        },
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildSkeletonLoading() {
    return Column(
      children: [
        const EmployeeSalaryReportCardSkeleton().animate(
          effects: AppAnimations.fadeScale(),
        ),
        verticalSpace(12),
        const EmployeeSalaryReportCardSkeleton().animate(
          effects: AppAnimations.fadeScale(
            delay: const Duration(milliseconds: 80),
          ),
        ),
        verticalSpace(12),
        const EmployeeSalaryReportCardSkeleton().animate(
          effects: AppAnimations.fadeScale(
            delay: const Duration(milliseconds: 160),
          ),
        ),
      ],
    );
  }

  void _showEmployeeReportDetails({
    required BuildContext context,
    required dynamic employee,
  }) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return EmployeeSalaryReportBottomSheet(
          employeeName: employee.name,
          presentDays: employee.presentDays,
          absentDays: employee.safeAbsentDays,
          commitmentPercentage: employee.commitmentPercentage,
          baseSalary: employee.baseSalary.round(),
          suggestedSalary: employee.suggestedSalary,
        );
      },
    );
  }
}
