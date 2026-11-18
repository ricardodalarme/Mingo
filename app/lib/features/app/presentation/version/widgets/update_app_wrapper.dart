import 'package:app/features/app/presentation/version/cubit/version_gate_cubit.dart';
import 'package:app/features/app/presentation/version/update_required_page.dart';
import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Replaces [child] with [UpdateRequiredPage] while the installed version is below the minimum.
class const UpdateAppWrapper({required final Widget child, super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => AppInjector.instance.get<VersionGateCubit>()..check(),
    child: BlocSelector<VersionGateCubit, VersionGateState, bool>(
      selector: (state) => state.updateRequired,
      builder: (context, updateRequired) => updateRequired ? const UpdateRequiredPage() : child,
    ),
  );
}
