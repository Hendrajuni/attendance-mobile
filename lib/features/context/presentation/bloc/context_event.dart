import 'package:flutter/foundation.dart';

@immutable
sealed class ContextEvent {}

class FetchContextRequested extends ContextEvent {}
