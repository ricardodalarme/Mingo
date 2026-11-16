import 'package:app/features/pairing/presentation/accept/cubit/accept_invite_cubit.dart';
import 'package:app/features/pairing/presentation/accept/widgets/connected_moment.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class const AcceptInviteConnected({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final partnerName = context.select((AcceptInviteCubit cubit) => cubit.state.partnerName);
    final selfName = context.select((AcceptInviteCubit cubit) => cubit.state.selfName);

    return ConnectedMoment(
      selfName: selfName,
      partnerName: partnerName,
      onDone: () => context.router.maybePop(),
    );
  }
}
