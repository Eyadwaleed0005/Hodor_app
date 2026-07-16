import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/app_system_ui.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/routes/route_names.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/widgets/app_animations.dart';
import 'package:Hodor/core/widgets/app_error_view.dart';
import 'package:Hodor/core/widgets/default_app_header.dart';
import 'package:Hodor/core/widgets/screen_title.dart';
import 'package:Hodor/ui/record_absence_screen/logic/cubit/record_absence_screen_cubit.dart';
import 'package:Hodor/ui/record_absence_screen/ui/widgets/absence_registration_skeleton_loading.dart';
import 'package:Hodor/ui/record_absence_screen/ui/widgets/absence_statistics_cards.dart';
import 'package:Hodor/ui/record_absence_screen/ui/widgets/employees_list_section.dart';

class AbsenceRegistrationScreen extends StatelessWidget {
  const AbsenceRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return RecordAbsenceScreenDartCubit()..getRecordAbsenceData();
      },
      child: const _AbsenceRegistrationView(),
    );
  }
}

class _AbsenceRegistrationView extends StatelessWidget {
  const _AbsenceRegistrationView();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.light(),
      child: Scaffold(
        backgroundColor: ColorPalette.white,
        body: Column(
          children: [
            DefaultAppHeader(
              onBackTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteNames.homeScreen,
                  (route) => false,
                );
              },
            ),
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
                        title: 'تسجيل غياب',
                        subtitle: 'قم بتسجيل الغياب للموظف',
                        icon: Icons.event_busy_outlined,
                        iconBackgroundColor: ColorPalette.red,
                        iconColor: ColorPalette.red,
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
                        child:
                            BlocBuilder<
                              RecordAbsenceScreenDartCubit,
                              RecordAbsenceScreenDartState
                            >(
                              builder: (context, state) {
                                return _buildContent(
                                  context: context,
                                  state: state,
                                );
                              },
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
    required RecordAbsenceScreenDartState state,
  }) {
    if (state is RecordAbsenceScreenDartInitial ||
        state is RecordAbsenceScreenDartLoading) {
      return const AbsenceRegistrationSkeletonLoading().animate(
        effects: AppAnimations.fadeScale(),
      );
    }

    if (state is RecordAbsenceScreenDartFailure) {
      return AppErrorView(
        title: 'تعذر تحميل بيانات الغياب',
        message: 'حدث خطأ أثناء تحميل بيانات الموظفين، حاول مرة أخرى.',
        icon: Icons.event_busy_outlined,
        color: ColorPalette.red,
        onRetry: () {
          context.read<RecordAbsenceScreenDartCubit>().getRecordAbsenceData();
        },
      ).animate(effects: AppAnimations.fadeScale());
    }

    if (state is RecordAbsenceScreenDartSuccess) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AbsenceStatisticsCards(
            totalEmployees: state.data.totalEmployees,
            presentEmployees: state.data.presentEmployees,
            absentEmployees: state.data.absentEmployees,
          ).animate(
            effects: AppAnimations.fadeSlideUp(
              delay: const Duration(milliseconds: 100),
            ),
          ),
          verticalSpace(20),
          EmployeesListSection(state: state).animate(
            effects: AppAnimations.fadeSlideUp(
              delay: const Duration(milliseconds: 180),
            ),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}
