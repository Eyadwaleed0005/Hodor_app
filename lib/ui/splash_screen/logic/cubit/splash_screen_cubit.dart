import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Hodor/core/local/shared_preferences/shared_preference_keys.dart';
import 'package:Hodor/core/local/shared_preferences/shared_preferences.dart';
import 'splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(SplashScreenInitial());

  Future<void> checkStartScreen() async {
    if (isClosed) return;

    emit(SplashScreenLoading());

    await Future.delayed(const Duration(milliseconds: 1700));

    if (isClosed) return;

    final bool viewed =
        (await SharedPreferencesHelper.getBool(
              key: SharedPreferenceKeys.startScreenViewed,
            )) ??
            false;

    if (isClosed) return;

    if (!viewed) {
      emit(SplashShowStart());
    } else {
      emit(SplashGoHome());
    }
  }
}