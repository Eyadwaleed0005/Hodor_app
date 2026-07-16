import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/app_system_ui.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/routes/bottom_nav_router.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/widgets/app_animations.dart';
import 'package:Hodor/core/widgets/app_bottom_nav_bar.dart';
import 'package:Hodor/core/widgets/title_section.dart';
import 'package:Hodor/ui/home_screen/logic/cubit/home_screen_cubit.dart';
import 'package:Hodor/ui/home_screen/ui/widgets/home_data_failure_view.dart';
import 'package:Hodor/ui/home_screen/ui/widgets/home_header.dart';
import 'package:Hodor/ui/home_screen/ui/widgets/home_screen_skeleton_loading.dart';
import 'package:Hodor/ui/home_screen/ui/widgets/monthly_commitment_card.dart';
import 'package:Hodor/ui/home_screen/ui/widgets/morning_card.dart';
import 'package:Hodor/ui/home_screen/ui/widgets/quick_actions_section.dart';
import 'package:Hodor/ui/home_screen/ui/widgets/statistics_grid.dart';
import 'package:Hodor/ui/home_screen/ui/widgets/today_summary_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return HomeScreenCubit()
          ..getHomeData();
      },
      child: const _HomeScreenView(),
    );
  }
}

class _HomeScreenView
    extends StatelessWidget {
  const _HomeScreenView();

  @override
  Widget build(BuildContext context) {
    final cubit =
        context.read<HomeScreenCubit>();

    return AnnotatedRegion<
        SystemUiOverlayStyle>(
      value: AppSystemUi.light(),
      child: Scaffold(
        backgroundColor: ColorPalette.white,
        bottomNavigationBar: AppBottomNavBar(
          currentIndex: 0,
          onTap: (index) {
            BottomNavRouter.go(
              context,
              index,
            );
          },
        ),
        body: Column(
          children: [
            const HomeHeader()
                .animate()
                .addEffects(
                  AppAnimations.fadeSlideUp(),
                ),
            Expanded(
              child: BlocBuilder<
                  HomeScreenCubit,
                  HomeScreenState>(
                builder: (context, state) {
                  return _buildContent(
                    cubit: cubit,
                    state: state,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent({
    required HomeScreenCubit cubit,
    required HomeScreenState state,
  }) {
    if (state is HomeScreenInitial ||
        state is HomeScreenLoading) {
      return const HomeScreenSkeletonLoading();
    }

    if (state is HomeScreenFailure) {
      return HomeDataFailureView(
        onRetry: cubit.getHomeData,
      );
    }

    if (state is HomeScreenLoaded) {
      return RefreshIndicator(
        color: ColorPalette.blue,
        onRefresh: cubit.getHomeData,
        child: SingleChildScrollView(
          physics:
              const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              verticalSpace(5),
              MorningCard(
                presentCount:
                    state.todayPresentCount,
                date: state.todayFullDate,
              )
                  .animate()
                  .addEffects(
                    AppAnimations.fadeScale(
                      delay: 100.ms,
                    ),
                  ),
              verticalSpace(8),
              Container(
                width: double.infinity,
                color: ColorPalette.offWhite,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 22.h,
                  ),
                  child: Column(
                    children: [
                      const TitleSection(
                        title: 'الإحصائيات',
                      )
                          .animate()
                          .addEffects(
                            AppAnimations
                                .fadeSlideUp(
                              delay: 150.ms,
                            ),
                          ),
                      verticalSpace(20),
                      StatisticsGrid(
                        monthAbsencesCount:
                            state
                                .monthAbsencesCount,
                        employeesCount:
                            state.employeesCount,
                        todayAbsentCount:
                            state
                                .todayAbsentCount,
                        commitmentPercentage:
                            state
                                .monthlyCommitmentPercentage,
                      )
                          .animate()
                          .addEffects(
                            AppAnimations
                                .fadeSlideUp(
                              delay: 220.ms,
                            ),
                          ),
                      verticalSpace(20),
                      MonthlyCommitmentCard(
                        percentage: state
                            .monthlyCommitmentPercentage,
                      )
                          .animate()
                          .addEffects(
                            AppAnimations
                                .fadeSlideUp(
                              delay: 300.ms,
                            ),
                          ),
                      verticalSpace(20),
                      const TitleSection(
                        title:
                            'الإجراءات السريعة',
                      )
                          .animate()
                          .addEffects(
                            AppAnimations
                                .fadeSlideUp(
                              delay: 380.ms,
                            ),
                          ),
                      verticalSpace(20),
                      const QuickActionsSection()
                          .animate()
                          .addEffects(
                            AppAnimations
                                .fadeSlideUp(
                              delay: 460.ms,
                            ),
                          ),
                      verticalSpace(20),
                      TodaySummaryCard(
                        date:
                            state.todayShortDate,
                        presentCount: state
                            .todayPresentCount,
                        absentCount: state
                            .todayAbsentCount,
                        vacationCount: 0,
                      )
                          .animate()
                          .addEffects(
                            AppAnimations
                                .fadeSlideUp(
                              delay: 540.ms,
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

    return const SizedBox.shrink();
  }
}