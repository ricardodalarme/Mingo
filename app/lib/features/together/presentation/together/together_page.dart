import 'package:app/features/pairing/presentation/connect/connect_code_sheet.dart';
import 'package:app/features/profile/data/models/relationship_phase.dart';
import 'package:app/features/together/presentation/together/cubit/together_cubit.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The shared home: what to do together, and a view with only the person's own things.
@RoutePage()
class const TogetherPage({final bool isEmbedded = false, super.key})
    extends StatelessWidget
    implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<TogetherCubit>()..load(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.tabs;
    final hasPartner = context.select((TogetherCubit cubit) => cubit.state.hasPartner);
    final showCheckin = context.select((TogetherCubit cubit) => cubit.state.showCheckin);
    final listCount = context.select((TogetherCubit cubit) => cubit.state.listCount);
    final sharedGiftCount = context.select((TogetherCubit cubit) => cubit.state.sharedGiftCount);
    final phase = context.select((TogetherCubit cubit) => cubit.state.phase);
    final cubit = context.read<TogetherCubit>();

    final content = BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!isEmbedded)
            Semantics(header: true, child: Text(l10n.together, style: context.text.titleXl)),
          const SizedBox(height: AppSpace.s16),
          if (!hasPartner) ...[
            BaseNote(text: l10n.soloNote),
            const SizedBox(height: AppSpace.s12),
            BaseButton.secondary(
              text: context.l10n.acceptInvite.connectTitle,
              icon: AppIcons.link,
              isFullWidth: true,
              onPressed: () => _connectWithCode(context, cubit.load),
            ),
            const SizedBox(height: AppSpace.s12),
          ],
          _ForYouSection(hasPartner: hasPartner),
          const SizedBox(height: AppSpace.s24),
          _ToolsSection(
            cubit: cubit,
            showCheckin: showCheckin,
            hasPartner: hasPartner,
            listCount: listCount,
            sharedGiftCount: sharedGiftCount,
          ),
          const SizedBox(height: AppSpace.s24),
          if (hasPartner || phase == RelationshipPhase.longDistance) ...[
            _TogetherMoreSection(hasPartner: hasPartner, phase: phase),
            const SizedBox(height: AppSpace.s24),
          ],
          const _PrivateSection(),
          const SizedBox(height: AppSpace.s24),
          const _PrivateMoreSection(),
        ],
      ),
    );

    return isEmbedded ? content : BaseView(appBar: null, body: content);
  }
}

class const _ForYouSection({required final bool hasPartner}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.tabs;

    return _section(
      title: l10n.sectionForYou,
      children: [
        _row(
          icon: AppIcons.cart,
          title: l10n.logisticsTitle,
          subtitle: hasPartner ? l10n.logisticsMeta : l10n.needsBoth,
          onTap: () => context.pushRoute(const LogisticsRoute()),
        ),
        _row(
          icon: AppIcons.check,
          title: context.l10n.agreements.title,
          subtitle: hasPartner
              ? context.l10n.agreements.metaShared
              : context.l10n.agreements.metaPrivate,
          onTap: () => context.pushRoute(const AgreementsRoute()),
        ),
        _row(
          icon: AppIcons.rings,
          title: l10n.ritualsTitle,
          subtitle: hasPartner ? l10n.ritualsMeta : l10n.needsBoth,
          onTap: () => context.pushRoute(const RitualsRoute()),
        ),
        _row(
          icon: AppIcons.sparkle,
          title: l10n.dateNightTitle,
          subtitle: l10n.dateNightMeta,
          onTap: () => context.pushRoute(const DateNightRoute()),
        ),
      ],
    );
  }
}

class const _ToolsSection({
  required final TogetherCubit cubit,
  required final bool showCheckin,
  required final bool hasPartner,
  required final int listCount,
  required final int sharedGiftCount,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.tabs;
    final entry = context.l10n.questionsEntry;

    return _section(
      title: l10n.sectionTools,
      children: [
        if (showCheckin)
          _row(
            icon: AppIcons.check,
            title: l10n.checkinTitle,
            subtitle: hasPartner ? l10n.checkinMeta : l10n.needsBoth,
            onTap: () => _openCheckin(context),
          ),
        _row(
          icon: AppIcons.message,
          title: entry.title,
          subtitle: l10n.questionMeta,
          onTap: () => context.pushRoute(const QuestionsRoute()),
        ),
        _row(
          icon: AppIcons.play,
          title: l10n.gamesTitle,
          subtitle: hasPartner ? l10n.gamesMeta : l10n.needsBoth,
          onTap: () => context.pushRoute(const GamesRoute()),
        ),
        _row(
          icon: AppIcons.sparkle,
          title: context.l10n.quizzes.entryTitle,
          subtitle: context.l10n.quizzes.entryText,
          onTap: () => context.pushRoute(const QuizzesRoute()),
        ),
        _row(
          icon: AppIcons.note,
          title: l10n.listsTitle,
          subtitle: switch ((hasPartner, listCount)) {
            (_, 0) => l10n.listsNone,
            (true, final count) => l10n.listsSharedCount(count: count),
            (false, final count) => l10n.listsPrivateCount(count: count),
          },
          onTap: () async {
            await context.pushRoute(const ListsRoute());
            if (context.mounted) await cubit.load();
          },
        ),
        _row(
          icon: AppIcons.calendar,
          title: l10n.datesTitle,
          subtitle: l10n.datesMeta,
          onTap: () => context.pushRoute(const DatesRoute()),
        ),
        _row(
          icon: AppIcons.gift,
          title: context.l10n.gifts.entryTitle,
          subtitle: sharedGiftCount == 0
              ? l10n.giftsMeta
              : l10n.giftsMetaShared(count: sharedGiftCount),
          onTap: () => context.pushRoute(const GiftsRoute()),
        ),
        _row(
          icon: AppIcons.sun,
          title: l10n.dayTitle,
          subtitle: l10n.dayMeta,
          onTap: () => context.pushRoute(const DayRoute()),
        ),
        _row(
          icon: AppIcons.timer,
          title: l10n.capsulesTitle,
          subtitle: l10n.capsulesMeta,
          onTap: () => context.pushRoute(const CapsulesRoute()),
        ),
        _row(
          icon: AppIcons.smile,
          title: l10n.temperatureTitle,
          subtitle: l10n.temperatureMeta,
          onTap: () => context.pushRoute(const TemperatureRoute()),
        ),
        _row(
          icon: AppIcons.smartphone,
          title: context.l10n.homeWidgets.togetherTitle,
          subtitle: l10n.homeWidgetsMeta,
          onTap: () => context.pushRoute(const HomeWidgetsGalleryRoute()),
        ),
      ],
    );
  }

  Future<void> _openCheckin(BuildContext context) async {
    await context.pushRoute(const CheckinRoute());
    if (context.mounted) await cubit.load();
  }
}

class const _TogetherMoreSection({
  required final bool hasPartner,
  required final RelationshipPhase? phase,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.tabs;

    return _section(
      title: l10n.sectionMore,
      children: [
        if (phase == RelationshipPhase.longDistance)
          _row(
            icon: AppIcons.map_pin,
            title: l10n.distanceTitle,
            subtitle: l10n.distanceMeta,
            onTap: () => context.pushRoute(const DistanceRoute()),
          ),
        if (hasPartner)
          _row(
            icon: AppIcons.heart,
            title: l10n.usTitle,
            subtitle: l10n.usMeta,
            onTap: () => context.pushRoute(const UsRoute()),
          ),
      ],
    );
  }
}

class const _PrivateSection() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.tabs;

    return _section(
      title: l10n.sectionPrivate,
      children: [
        _row(
          icon: AppIcons.calendar,
          title: l10n.moodCalendarTitle,
          subtitle: l10n.moodCalendarMeta,
          onTap: () => context.pushRoute(const MoodCalendarRoute()),
        ),
        _row(
          icon: AppIcons.lock,
          title: l10n.diaryTitle,
          subtitle: l10n.diaryMeta,
          onTap: () => context.pushRoute(const DiaryRoute()),
        ),
      ],
    );
  }
}

class const _PrivateMoreSection() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.tabs;

    return _section(
      title: l10n.sectionMore,
      footer: l10n.forMeFooter,
      children: [
        _row(
          icon: AppIcons.pencil,
          title: l10n.notesTitle,
          subtitle: l10n.notesMeta,
          onTap: () => context.pushRoute(const ComposeRoute()),
        ),
        _row(
          icon: AppIcons.lightbulb,
          title: l10n.learningTitle,
          subtitle: l10n.learningMeta,
          onTap: () => context.pushRoute(LearningRoute()),
        ),
        _row(
          icon: AppIcons.user,
          title: l10n.partnerTitle,
          subtitle: l10n.partnerMeta,
          onTap: () => context.pushRoute(const PartnerProfileRoute()),
        ),
      ],
    );
  }
}

Future<void> _connectWithCode(BuildContext context, Future<void> Function() reload) async {
  final connected = await showConnectCodeSheet(context);
  if (connected && context.mounted) await reload();
}

Widget _section({required String title, required List<Widget> children, String? footer}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      BaseSectionHeader(title: title),
      const SizedBox(height: AppSpace.s8),
      BaseListGroup(footer: footer, children: children),
    ],
  );
}

Widget _row({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
  String? subtitle,
  Widget? trailing,
}) {
  return BaseListTile(
    icon: icon,
    title: title,
    subtitle: subtitle,
    subtitleMaxLines: 1,
    titleMaxLines: 1,
    trailing: trailing,
    showsChevron: true,
    onTap: onTap,
  );
}
