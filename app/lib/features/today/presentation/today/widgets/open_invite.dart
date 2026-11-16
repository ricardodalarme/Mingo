import 'package:app/features/today/presentation/today/cubit/today_cubit.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Opens the invite page and reloads Hoje, since the invite may have been sent or revoked.
Future<void> openInvite(BuildContext context) async {
  final cubit = context.read<TodayCubit>();
  await context.pushRoute(const InviteRoute());
  await cubit.load();
}
