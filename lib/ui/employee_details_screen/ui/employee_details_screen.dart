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
import 'package:Hodor/ui/employee_details_screen/logic/cubit/employee_details_screen_cubit.dart';
import 'package:Hodor/ui/employee_details_screen/ui/widgets/employee_details_card.dart';
import 'package:Hodor/ui/employee_details_screen/ui/widgets/employee_details_skeleton_loading.dart';
import 'package:Hodor/ui/home_screen/ui/widgets/home_header.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  const EmployeeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return EmployeeDetailsScreenCubit()..getEmployees();
      },
      child: const _EmployeeDetailsScreenBody(),
    );
  }
}

class _EmployeeDetailsScreenBody extends StatelessWidget {
  const _EmployeeDetailsScreenBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EmployeeDetailsScreenCubit>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.light(),
      child: Scaffold(
        backgroundColor: ColorPalette.white,
        bottomNavigationBar: AppBottomNavBar(
          currentIndex: 1,
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
                        title: 'تفاصيل الموظفين',
                        subtitle: 'عرض وإدارة بيانات الموظفين',
                        icon: Icons.people_alt_outlined,
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
                              onChanged: cubit.searchEmployees,
                            ).animate(
                              effects: AppAnimations.fadeSlideUp(
                                delay: const Duration(milliseconds: 100),
                              ),
                            ),
                            verticalSpace(20),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'قائمة الموظفين',
                                style: Textstyles.font18BlackBold(),
                              ),
                            ).animate(
                              effects: AppAnimations.fadeSlideRight(
                                delay: const Duration(milliseconds: 180),
                              ),
                            ),
                            verticalSpace(16),
                            BlocBuilder<
                              EmployeeDetailsScreenCubit,
                              EmployeeDetailsScreenState
                            >(
                              builder: (context, state) {
                                return _buildContent(
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
    required EmployeeDetailsScreenCubit cubit,
    required EmployeeDetailsScreenState state,
  }) {
    if (state is EmployeeDetailsScreenInitial ||
        state is EmployeeDetailsScreenLoading) {
      return const EmployeeDetailsSkeletonLoading().animate(
        effects: AppAnimations.fadeScale(),
      );
    }

    if (state is EmployeeDetailsScreenFailure) {
      return _buildFailureView(
        cubit: cubit,
        state: state,
      ).animate(effects: AppAnimations.fadeScale());
    }

    if (state is EmployeeDetailsScreenEmpty) {
      return EmployeesEmptyView.noEmployeesInDatabase().animate(
        effects: AppAnimations.fadeScale(),
      );
    }

    if (state is EmployeeDetailsScreenNoSearchResults) {
      return EmployeesEmptyView.noSearchResults().animate(
        effects: AppAnimations.fadeScale(),
      );
    }

    if (state is EmployeeDetailsScreenLoaded) {
      return ListView.separated(
        itemCount: state.employees.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (_, __) {
          return verticalSpace(12);
        },
        itemBuilder: (context, index) {
          final employee = state.employees[index];

          return EmployeeDetailsCard(
            employeeName: employee.name,
            age: employee.age,
            salary: employee.salary,
            absentDays: employee.absentDays,
            createdAt: employee.createdAt,
            isPresent: employee.isPresent,
            onViewTap: () {},
            onDeleteTap: () {
              final employeeId = employee.id;

              if (employeeId == null) {
                return;
              }

              cubit.deleteEmployee(employeeId);
            },
          ).animate(
            effects: AppAnimations.fadeSlideUp(
              delay: Duration(milliseconds: 70 * index),
            ),
          );
        },
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildFailureView({
    required EmployeeDetailsScreenCubit cubit,
    required EmployeeDetailsScreenFailure state,
  }) {
    final isDeleteFailure =
        state.type == EmployeeDetailsFailureType.deleteEmployee;

    return AppErrorView(
      title: isDeleteFailure ? 'تعذر حذف الموظف' : 'تعذر تحميل بيانات الموظفين',
      message: isDeleteFailure
          ? 'حدث خطأ أثناء حذف الموظف، حاول مرة أخرى.'
          : 'حدث خطأ أثناء تحميل قائمة الموظفين، حاول مرة أخرى.',
      retryButtonText: 'إعادة المحاولة',
      icon: isDeleteFailure
          ? Icons.delete_outline_rounded
          : Icons.people_alt_outlined,
      color: isDeleteFailure ? ColorPalette.red : ColorPalette.blue,
      onRetry: () {
        cubit.retryFailure(state);
      },
    );
  }
}
