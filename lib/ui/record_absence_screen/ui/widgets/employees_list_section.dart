import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/employee_name_helper.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/routes/route_names.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';
import 'package:Hodor/core/widgets/app_search_field.dart';
import 'package:Hodor/core/widgets/default_bottom_sheet.dart';
import 'package:Hodor/core/widgets/employees_empty_view.dart';
import 'package:Hodor/ui/record_absence_screen/logic/cubit/record_absence_screen_cubit.dart';
import 'package:Hodor/ui/record_absence_screen/ui/widgets/employee_absence_card.dart';

class EmployeesListSection extends StatelessWidget {
  final RecordAbsenceScreenDartSuccess state;

  const EmployeesListSection({
    super.key,
    required this.state,
  });

  String get _todayDate {
    return DateTime.now().toIso8601String().split('T').first;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RecordAbsenceScreenDartCubit>();
    final employees = state.filteredEmployees;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AppSearchField(
          controller: cubit.searchController,
          onChanged: cubit.searchEmployees,
        ),
        verticalSpace(16),
        Text(
          'قائمة الموظفين',
          style: Textstyles.font18Gray500Regular(),
          textAlign: TextAlign.right,
        ),
        verticalSpace(10),
        if (employees.isEmpty)
          state.data.employees.isEmpty
              ? EmployeesEmptyView.noEmployeesInDatabase()
              : EmployeesEmptyView.noSearchResults()
        else
          ListView.separated(
            itemCount: employees.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => verticalSpace(12),
            itemBuilder: (context, index) {
              final employee = employees[index];

              return EmployeeAbsenceCard(
                employeeName: employee.name,
                avatarColor: ColorPalette.blue,
                isPresent: employee.isPresent,
                onHistoryTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteNames.employeeAbsenceDetailsScreen,
                    arguments: employee.id,
                  );
                },
                onRegisterAbsenceTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) {
                      return DefaultBottomSheet(
                        icon: Icons.warning_amber_rounded,
                        iconColor: ColorPalette.red,
                        iconBackgroundColor:
                            ColorPalette.red.withOpacity(0.12),
                        title: 'تاكيد تسجيل غياب',
                        primaryButtonTitle: 'تاكيد التسجيل',
                        primaryButtonColor: ColorPalette.red,
                        onPrimaryPressed: () async {
                          Navigator.pop(context);
                          await cubit.registerEmployeeAbsence(employee.id);
                        },
                        description: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'هل تريد تسجيل غياب ',
                                style: Textstyles.font18BlackBold(),
                              ),
                              TextSpan(
                                text: employee.name,
                                style: Textstyles.font18RedExtraBold(),
                              ),
                              TextSpan(
                                text: ' اليوم؟',
                                style: Textstyles.font18BlackBold(),
                              ),
                            ],
                          ),
                        ),
                        content: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(14.w),
                          decoration: BoxDecoration(
                            color: ColorPalette.gray100,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: ColorPalette.gray300,
                              width: 1.w,
                            ),
                          ),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 46.w,
                                height: 46.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: ColorPalette.blue,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Text(
                                  EmployeeNameHelper.getInitials(employee.name),
                                  style: Textstyles.font18WhiteBold(),
                                ),
                              ),
                              horizontalSpace(12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    employee.name,
                                    style: Textstyles.font18BlackBold(),
                                    textAlign: TextAlign.right,
                                  ),
                                  verticalSpace(4),
                                  Text(
                                    _todayDate,
                                    style: Textstyles.font14Gray500Regular(),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
      ],
    );
  }
}