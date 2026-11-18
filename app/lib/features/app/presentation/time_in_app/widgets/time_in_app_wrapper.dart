import 'dart:async';

import 'package:app/features/app/presentation/cubit/app_cubit.dart';
import 'package:app/features/app/presentation/time_in_app/cubit/time_in_app_cubit.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pushes the time-in-app prompt once when the cubit asks for it while authenticated.
class const TimeInAppWrapper({
  required final Widget child,
  final RootStackRouter? router,
  super.key,
}) extends StatefulWidget {
  @override
  State<TimeInAppWrapper> createState() => _TimeInAppWrapperState();
}

class _TimeInAppWrapperState() extends State<TimeInAppWrapper> {
  bool _isShowingPrompt = false;

  RootStackRouter get _router => widget.router ?? AppInjector.instance.get<RootStackRouter>();

  @override
  Widget build(BuildContext context) {
    final isAuthenticated = context.select(
      (AppCubit cubit) => cubit.state == AppState.authenticated,
    );

    return BlocProvider(
      create: (_) => AppInjector.instance.get<TimeInAppCubit>()..start(),
      child: BlocListener<TimeInAppCubit, TimeInAppState>(
        listenWhen: (previous, current) =>
            isAuthenticated && !previous.shouldPrompt && current.shouldPrompt,
        listener: (context, _) => _showPrompt(),
        child: widget.child,
      ),
    );
  }

  void _showPrompt() {
    if (_isShowingPrompt) return;
    _isShowingPrompt = true;
    unawaited(_router.push(const TimeInAppRoute()).whenComplete(() => _isShowingPrompt = false));
  }
}
