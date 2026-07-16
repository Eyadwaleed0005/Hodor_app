import 'package:meta/meta.dart';

@immutable
abstract class StartScreenState {}

class StartScreenInitial extends StartScreenState {}

class StartScreenLoading extends StartScreenState {}

class StartScreenPageChanged extends StartScreenState {
  final int index;
  StartScreenPageChanged(this.index);
}

class StartScreenNavigateToLogin extends StartScreenState {}
