import 'package:app/features/couple/presentation/couple/cubit/couple_cubit.dart';
import 'package:app/features/couple/presentation/couple/widgets/together_chip.dart';
import 'package:app/features/together/presentation/together/together_page.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The couple's space: what they do together.
@RoutePage()
class const CouplePage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<CoupleCubit>()..load(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.tabs;

    return BaseView(
      appBar: null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpace.screenMargin,
              AppSpace.s8,
              AppSpace.screenMargin,
              AppSpace.s12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Semantics(header: true, child: Text(l10n.couple, style: context.text.titleXl)),
                const TogetherChip(),
              ],
            ),
          ),
          Expanded(child: const TogetherPage(isEmbedded: true).wrappedRoute(context)),
        ],
      ),
    );
  }
}
