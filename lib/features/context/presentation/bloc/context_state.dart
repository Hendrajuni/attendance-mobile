import 'package:flutter/foundation.dart';
import '../../data/daily_context_model.dart';

@immutable
sealed class ContextState {}

class ContextInitial extends ContextState {}

class ContextLoading extends ContextState {}

class ContextSuccess extends ContextState {
  final DailyContext contextData;

  ContextSuccess(this.contextData);
}

class ContextFailure extends ContextState {
  final String error;

  ContextFailure(this.error);
}
