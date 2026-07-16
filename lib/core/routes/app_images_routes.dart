class AppImage {
  static AppImage? _instance;

  factory AppImage() {
    _instance ??= AppImage._internal();
    return _instance!;
  }

  AppImage._internal();

  // Base paths
  final String baseImages = 'assets/images/';
  final String baseAnimation = 'assets/animation/';
  final String baseIcons = 'assets/icons/';


  late final String onboarding1 = '${baseImages}onboarding_1.png';
  late final String onboarding2 = '${baseImages}onboarding_2.png';
  late final String onboarding3 = '${baseImages}onboarding_3.png';
}
