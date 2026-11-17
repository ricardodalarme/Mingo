import 'package:app/features/_shared/presentation/errors/app_error_view.dart';
import 'package:app/features/dev_menu/dev_menu_page.dart';
import 'package:app/features/mood/presentation/mood/cubit/mood_cubit.dart';
import 'package:app/features/notifications/presentation/bell/cubit/inbox_badge_cubit.dart';
import 'package:app/features/today/data/models/today_home.dart';
import 'package:app/features/today/presentation/today/cubit/today_cubit.dart';
import 'package:app/features/today/presentation/today/widgets/partner_unpaired_notice.dart';
import 'package:app/features/today/presentation/today/widgets/today_content.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class const TodayPage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppInjector.instance.get<TodayCubit>()..start()),
        BlocProvider(create: (_) => AppInjector.instance.get<MoodCubit>()..load()),
        BlocProvider(create: (_) => AppInjector.instance.get<InboxBadgeCubit>()..start()),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final home = context.select((TodayCubit cubit) => cubit.state.home);
    final selfName = context.select((TodayCubit cubit) => cubit.state.selfName);
    final partnerHint = context.select((TodayCubit cubit) => cubit.state.partnerHint);
    final isSoloOnly = context.select((TodayCubit cubit) => cubit.state.isSoloOnly);
    final isFirstDay = context.select((TodayCubit cubit) => cubit.state.isFirstDay);
    final isInConflict = context.select((TodayCubit cubit) => cubit.state.isInConflict);
    final showUnpairNotice = context.select((TodayCubit cubit) => cubit.state.showUnpairNotice);
    final unpairedPartnerName = context.select(
      (TodayCubit cubit) => cubit.state.unpairedPartnerName,
    );

    return BaseView(
      appBar: null,
      body: showUnpairNotice
          ? PartnerUnpairedNotice(
              partnerName: unpairedPartnerName,
              onOk: context.read<TodayCubit>().acknowledgeUnpairNotice,
            )
          : BaseRefreshable(
              onRefresh: () async {
                await Future.wait([
                  context.read<TodayCubit>().load(),
                  context.read<MoodCubit>().load(),
                ]);
              },
              child: BaseStackedContent(
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SkeletonizerResourceWidget<TodayHome>(
                      home,
                      fakeValue: const TodayHome.fake(),
                      successBuilder: (value) => TodayContent(
                        home: value,
                        selfName: selfName,
                        partnerHint: partnerHint,
                        isFirstDay: isFirstDay,
                        isSoloOnly: isSoloOnly,
                        isInConflict: isInConflict,
                      ),
                      failureBuilder: (failure) => AppErrorView(
                        exception: failure,
                        onRetry: context.read<TodayCubit>().load,
                      ),
                    ),
                    if (kDebugMode)
                      Center(
                        child: BaseTextLink(
                          text: 'Dev Menu',
                          onPressed: () => context.router.pushWidget(const DevMenuPage()),
                        ),
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}
