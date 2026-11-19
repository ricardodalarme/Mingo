import 'package:app/features/couple/presentation/couple/cubit/couple_cubit.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:clock/clock.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// How long the couple has been together; without a start date it only names the story.
class const TogetherChip({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.tabs;
    final since = context.select((CoupleCubit cubit) => cubit.state.togetherSince);

    return BaseChip.icon(
      label: since != null ? togetherDuration(l10n, since, clock.now()) : l10n.storyChip,
      icon: AppIcons.heart,
      onTap: () => context.pushRoute(const HistoryRoute()),
    );
  }
}

/// How long the couple has been together, in the two largest units that apply.
String togetherDuration(Translations$tabs$pt l10n, DateTime since, DateTime now) {
  var months = (now.year - since.year) * 12 + now.month - since.month;
  if (now.day < since.day) months--;
  final years = months ~/ 12;
  final rest = months % 12;
  final t = l10n;
  if (years > 0 && rest > 0) {
    return t.durationYearsMonths(
      years: years,
      yearsUnit: t.unitYear(count: years),
      months: rest,
      monthsUnit: t.unitMonth(count: rest),
    );
  }
  if (years > 0) {
    return t.durationYears(
      years: years,
      yearsUnit: t.unitYear(count: years),
    );
  }
  if (months > 0) {
    return t.durationMonths(
      months: months,
      monthsUnit: t.unitMonth(count: months),
    );
  }
  final days = now.difference(since).inDays.clamp(0, 31);

  return t.durationDays(
    days: days,
    daysUnit: t.unitDay(count: days),
  );
}
