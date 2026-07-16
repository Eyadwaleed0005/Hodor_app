import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Hodor/core/helper/app_system_ui.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/routes/route_names.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/ui/splash_screen/logic/cubit/splash_screen_cubit.dart';
import 'package:Hodor/ui/splash_screen/logic/cubit/splash_screen_state.dart';

import 'widgets/splash_app_name.dart';
import 'widgets/splash_loading_dots.dart';
import 'widgets/splash_logo.dart';
import 'widgets/splash_tagline.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashScreenCubit()..checkStartScreen(),
      child: BlocListener<SplashScreenCubit, SplashScreenState>(
        listenWhen: (_, state) =>
            state is SplashShowStart || state is SplashGoHome,
        listener: (context, state) {
          if (!context.mounted) return;

          if (state is SplashShowStart) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.startScreen,
              (route) => false,
            );
          } else if (state is SplashGoHome) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.homeScreen,
              (route) => false,
            );
          }
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: AppSystemUi.light(),
          child: Scaffold(
            backgroundColor: ColorPalette.white,
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SplashLogo(),
                    verticalSpace(12),
                    const SplashAppName(),
                    verticalSpace(17),
                    const SplashTagline(),
                    verticalSpace(25),
                    const SplashLoadingDots(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
