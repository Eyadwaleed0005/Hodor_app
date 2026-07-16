import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';
import 'package:Hodor/core/widgets/app_animations.dart';
import 'package:Hodor/core/widgets/app_button.dart';
import 'package:Hodor/core/widgets/app_text_field.dart';
import 'package:Hodor/ui/add_employee_screen/logic/add_employee_cubit.dart';
import 'package:Hodor/ui/add_employee_screen/logic/add_employee_state.dart';

class AddEmployeeForm extends StatelessWidget {
  const AddEmployeeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddEmployeeCubit>();

    return BlocBuilder<AddEmployeeCubit, AddEmployeeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'البيانات الأساسية',
                  style: Textstyles.font18BlackBold(),
                ),
                horizontalSpace(10),
                Container(
                  width: 4.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    color: ColorPalette.blue,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ],
            ).animate().custom(
                  duration: 400.ms,
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(20.w * (1 - value), 0),
                        child: child,
                      ),
                    );
                  },
                ),

            verticalSpace(16),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: ColorPalette.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    spreadRadius: 1,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _AnimatedFieldItem(
                    delay: 100.ms,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'الاسم بالكامل',
                          style: Textstyles.font18BlackBold(),
                        ),
                        verticalSpace(8),
                        AppTextField(
                          controller: cubit.fullNameController,
                          hintText: 'أدخل الاسم بالكامل',
                          errorText: state.nameError,
                        ),
                      ],
                    ),
                  ),

                  verticalSpace(16),

                  _AnimatedFieldItem(
                    delay: 200.ms,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'العمر',
                          style: Textstyles.font18BlackBold(),
                        ),
                        verticalSpace(8),
                        AppTextField(
                          controller: cubit.ageController,
                          hintText: 'أدخل العمر',
                          keyboardType: TextInputType.number,
                          errorText: state.ageError,
                        ),
                      ],
                    ),
                  ),

                  verticalSpace(16),

                  _AnimatedFieldItem(
                    delay: 300.ms,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'الراتب الشهري',
                          style: Textstyles.font18BlackBold(),
                        ),
                        verticalSpace(8),
                        AppTextField(
                          controller: cubit.salaryController,
                          hintText: 'أدخل الراتب الشهري',
                          keyboardType: TextInputType.number,
                          errorText: state.salaryError,
                        ),
                      ],
                    ),
                  ),

                  verticalSpace(24),

                  AppButton(
                    title: 'إضافة الموظف',
                    isLoading: state.isLoading,
                    onPressed: () {
                      context.read<AddEmployeeCubit>().addEmployee();
                    },
                  ).animate(effects: AppAnimations.fadeScale(delay: 420.ms)),
                ],
              ),
            ).animate(effects: AppAnimations.fadeScale()),
          ],
        );
      },
    );
  }
}

class _AnimatedFieldItem extends StatelessWidget {
  final Widget child;
  final Duration delay;

  const _AnimatedFieldItem({
    required this.child,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return child.animate(
      effects: AppAnimations.fadeSlideUp(delay: delay),
    );
  }
}