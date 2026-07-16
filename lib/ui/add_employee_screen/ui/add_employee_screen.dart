import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/app_system_ui.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/routes/route_names.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/widgets/default_app_header.dart';
import 'package:Hodor/core/widgets/screen_title.dart';
import 'package:Hodor/ui/add_employee_screen/data/repo/employee_repository.dart';
import 'package:Hodor/ui/add_employee_screen/logic/add_employee_cubit.dart';
import 'package:Hodor/ui/add_employee_screen/logic/add_employee_state.dart';
import 'package:Hodor/ui/add_employee_screen/ui/widgets/add_employee_form.dart';
import 'package:Hodor/ui/add_employee_screen/ui/widgets/employee_added_failure_widget.dart';
import 'package:Hodor/ui/add_employee_screen/ui/widgets/employee_added_success_widget.dart';
import 'package:Hodor/ui/add_employee_screen/ui/widgets/employee_form_progress.dart';

class AddEmployeeScreen extends StatelessWidget {
  const AddEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddEmployeeCubit(EmployeeRepository()),
      child: const _AddEmployeeScreenView(),
    );
  }
}

class _AddEmployeeScreenView extends StatelessWidget {
  const _AddEmployeeScreenView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddEmployeeCubit>();

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
              child: BlocBuilder<AddEmployeeCubit, AddEmployeeState>(
                builder: (context, state) {
                  if (state.isSuccess) {
                    return EmployeeAddedSuccessWidget(
                      onAddAnotherEmployee: cubit.prepareForAnotherEmployee,
                    );
                  }

                  if (state.isFailure) {
                    return EmployeeAddedFailureWidget(
                      onRetry: cubit.retryAddEmployee,
                      onBackToForm: cubit.returnToForm,
                    );
                  }

                  return _buildEmployeeForm(state);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmployeeForm(AddEmployeeState state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ScreenTitle(
                  title: 'إضافة موظف جديد',
                  subtitle: 'أدخل بيانات الموظف لتسجيله في النظام',
                  icon: Icons.person_add_alt_1_outlined,
                  iconBackgroundColor: ColorPalette.blue,
                  iconColor: ColorPalette.blue,
                ),
                verticalSpace(28),
                EmployeeFormProgress(completedFields: state.completedFields),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: ColorPalette.offWhite,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 22.h),
              child: const AddEmployeeForm(),
            ),
          ),
        ],
      ),
    );
  }
}
