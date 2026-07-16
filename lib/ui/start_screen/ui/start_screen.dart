import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Hodor/core/helper/app_system_ui.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/routes/app_images_routes.dart';
import 'package:Hodor/core/routes/route_names.dart';
import 'package:Hodor/core/style/app_color.dart';

import 'package:Hodor/ui/start_screen/logic/cubit/start_screen_cubit.dart';
import 'package:Hodor/ui/start_screen/logic/cubit/start_screen_state.dart';

import 'widgets/start_continue_button.dart';
import 'widgets/start_dots.dart';
import 'widgets/start_header.dart';
import 'widgets/start_hero.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  late final PageController _controller;

  final List<Map<String, String>> _pages = [
    {
      'image': AppImage().onboarding1,
      'title': 'إدارة الموظفين بسهولة',
      'desc':
          'أضف الموظفين ونظم بياناتهم واحتفظ بسجلاتهم في مكان واحد.',
    },
    {
      'image': AppImage().onboarding2,
      'title': 'تسجيل الحضور والغياب',
      'desc':
          'سجل حضور وغياب الموظفين بسرعة ودقة دون تعقيد.',
    },
    {
      'image': AppImage().onboarding3,
      'title': 'متابعة السجلات والتقارير',
      'desc':
          'اطلع على سجلات الحضور والغياب وراجع البيانات في أي وقت.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextPage() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StartScreenCubit(),
      child: BlocListener<StartScreenCubit, StartScreenState>(
        listenWhen: (_, state) => state is StartScreenNavigateToLogin,
        listener: (context, state) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.homeScreen,
            (route) => false,
          );
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: AppSystemUi.dark(),
          child: Scaffold(
            backgroundColor: ColorPalette.white,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 20.h,
                ),
                child: BlocBuilder<StartScreenCubit, StartScreenState>(
                  builder: (context, state) {
                    final cubit = context.watch<StartScreenCubit>();

                    final bool loading =
                        state is StartScreenLoading;
                    final bool isLast =
                        cubit.currentIndex == _pages.length - 1;

                    return Column(
                      children: [
                        StartHeader(
                          onSkip: loading
                              ? () {}
                              : () => context
                                    .read<StartScreenCubit>()
                                    .finish(),
                        ),

                        Expanded(
                          child: Column(
                            children: [
                              const Spacer(flex: 2),

                              Expanded(
                                flex: 8,
                                child: PageView.builder(
                                  controller: _controller,
                                  itemCount: _pages.length,
                                  onPageChanged: (i) => context
                                      .read<StartScreenCubit>()
                                      .changePage(i),
                                  itemBuilder: (context, index) {
                                    final p = _pages[index];

                                    return StartHero(
                                      imagePath: p['image']!,
                                      title: p['title']!,
                                      description: p['desc']!,
                                    );
                                  },
                                ),
                              ),

                              verticalSpace(20),

                              StartDots(
                                activeIndex: cubit.currentIndex,
                              ),

                              verticalSpace(24),

                              StartContinueButton(
                                isLoading: loading,
                                text:
                                    isLast ? 'ابدأ الآن' : 'التالي',
                                onPressed: loading
                                    ? null
                                    : () {
                                        if (!isLast) {
                                          _nextPage();
                                        } else {
                                          context
                                              .read<
                                                StartScreenCubit
                                              >()
                                              .finish();
                                        }
                                      },
                              ),

                              verticalSpace(12),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}