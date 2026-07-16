import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/app_system_ui.dart';
import 'package:Hodor/core/helper/employee_commitment_helper.dart';
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
import 'package:Hodor/ui/archive_screen/data/repo/archive_repo.dart';
import 'package:Hodor/ui/archive_screen/logic/cubit/archive_screen_cubit.dart';
import 'package:Hodor/ui/archive_screen/ui/widgets/archive_month_bottom_sheet/archive_month_bottom_sheet.dart';
import 'package:Hodor/ui/archive_screen/ui/widgets/archive_month_card/archive_month_card.dart';
import 'package:Hodor/ui/archive_screen/ui/widgets/archive_screen_skeleton_loading.dart';
import 'package:Hodor/ui/archive_screen/ui/widgets/archive_status_cards_section.dart';
import 'package:Hodor/ui/home_screen/ui/widgets/home_header.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return ArchiveScreenCubit(ArchiveRepo())..getArchiveData();
      },
      child: const _ArchiveScreenView(),
    );
  }
}

class _ArchiveScreenView extends StatelessWidget {
  const _ArchiveScreenView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ArchiveScreenCubit>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.light(),
      child: Scaffold(
        backgroundColor: ColorPalette.white,
        bottomNavigationBar: AppBottomNavBar(
          currentIndex: 3,
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
                        title: 'الأرشيف',
                        subtitle: 'عرض السجلات والتقارير المحفوظة',
                        icon: Icons.archive_outlined,
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
                        child:
                            BlocConsumer<
                              ArchiveScreenCubit,
                              ArchiveScreenState
                            >(
                              listenWhen: (_, current) {
                                return current is ArchiveMonthDetailsSuccess ||
                                    current is ArchiveMonthDetailsFailure;
                              },
                              listener: (context, state) {
                                if (state is ArchiveMonthDetailsSuccess) {
                                  _showArchiveMonthBottomSheet(
                                    context: context,
                                    state: state,
                                  );
                                }

                                if (state is ArchiveMonthDetailsFailure) {
                                  _showArchiveErrorBottomSheet(
                                    context: context,
                                    state: state,
                                  );
                                }
                              },
                              buildWhen: (_, current) {
                                return current is ArchiveScreenInitial ||
                                    current is ArchiveScreenLoading ||
                                    current is ArchiveScreenSuccess ||
                                    current is ArchiveScreenFailure;
                              },
                              builder: (context, state) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppSearchField(
                                      controller: cubit.searchController,
                                      onChanged: cubit.searchArchives,
                                    ).animate(
                                      effects: AppAnimations.fadeSlideUp(
                                        delay: const Duration(
                                          milliseconds: 100,
                                        ),
                                      ),
                                    ),
                                    verticalSpace(20),
                                    _buildArchiveContent(
                                      state: state,
                                      cubit: cubit,
                                    ),
                                  ],
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

  Widget _buildArchiveContent({
    required ArchiveScreenState state,
    required ArchiveScreenCubit cubit,
  }) {
    if (state is ArchiveScreenInitial || state is ArchiveScreenLoading) {
      return const ArchiveSkeletonLoading();
    }

    if (state is ArchiveScreenFailure) {
      return AppErrorView(
        title: 'تعذر تحميل الأرشيف',
        message: 'حدث خطأ أثناء تحميل بيانات الأرشيف، حاول مرة أخرى.',
        icon: Icons.archive_outlined,
        color: ColorPalette.blue,
        onRetry: cubit.getArchiveData,
      );
    }

    if (state is! ArchiveScreenSuccess) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArchiveStatusCardsSection(
          archivesCount: state.allArchives.length,
          bestMonth: state.bestMonth,
          worstMonth: state.worstMonth,
        ).animate(
          effects: AppAnimations.fadeSlideUp(
            delay: const Duration(milliseconds: 150),
          ),
        ),
        verticalSpace(24),
        Align(
          alignment: Alignment.centerRight,
          child: Text('التقارير المؤرشفة', style: Textstyles.font18BlackBold()),
        ).animate(
          effects: AppAnimations.fadeSlideRight(
            delay: const Duration(milliseconds: 180),
          ),
        ),
        verticalSpace(16),
        if (state.archives.isEmpty)
          state.isSearching
              ? EmployeesEmptyView.noSearchResults()
              : EmployeesEmptyView.noEmployeesInDatabase()
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.archives.length,
            separatorBuilder: (_, __) {
              return verticalSpace(12);
            },
            itemBuilder: (context, index) {
              final archive = state.archives[index];

              return ArchiveMonthCard(
                monthName: cubit.getFullMonthName(archive),
                percentage: archive.commitmentPercentage,
                employeesCount: archive.employeesCount,
                workDays: archive.daysInMonth,
                absentDays: archive.totalAbsentDays,
                isBestMonth: cubit.isBestMonth(archive),
                isWorstMonth: cubit.isWorstMonth(archive),
                onViewDetailsTap: () {
                  cubit.openArchiveDetails(archive);
                },
              ).animate(
                effects: AppAnimations.fadeSlideUp(
                  delay: Duration(milliseconds: 120 + (index * 60)),
                ),
              );
            },
          ),
      ],
    );
  }

  void _showArchiveMonthBottomSheet({
    required BuildContext context,
    required ArchiveMonthDetailsSuccess state,
  }) {
    final archive = state.archive;

    final statusColor = EmployeeCommitmentHelper.getStatusColor(
      archive.commitmentPercentage,
    );

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return ArchiveMonthBottomSheet(
          monthName: state.fullMonthName,
          percentage: archive.commitmentPercentage,
          employeesCount: archive.employeesCount,
          workDays: archive.daysInMonth,
          absentDays: archive.totalAbsentDays,
          statusColor: statusColor,
          employees: state.employees,
        );
      },
    );
  }

  void _showArchiveErrorBottomSheet({
    required BuildContext context,
    required ArchiveMonthDetailsFailure state,
  }) {
    final cubit = context.read<ArchiveScreenCubit>();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: ColorPalette.white,
      builder: (bottomSheetContext) {
        return SafeArea(
          child: AppErrorView(
            title: 'تعذر تحميل تفاصيل الشهر',
            message: 'حدث خطأ أثناء تحميل تفاصيل الموظفين لهذا الشهر.',
            retryButtonText: 'إعادة تحميل التفاصيل',
            icon: Icons.archive_outlined,
            color: ColorPalette.blue,
            onRetry: () {
              Navigator.of(bottomSheetContext).pop();

              cubit.openArchiveDetails(state.archive);
            },
          ),
        );
      },
    );
  }
}
