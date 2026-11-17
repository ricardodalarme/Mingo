import 'package:app/features/quizzes/data/models/quiz_kind.dart';
import 'package:app/features/quizzes/data/models/quizzes_progress.dart';
import 'package:app/features/quizzes/presentation/hub/cubit/quizzes_cubit.dart';
import 'package:app/features/quizzes/presentation/hub/widgets/quiz_kind_l10n.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The two quizzes, with when each one was last finished.
@RoutePage()
class const QuizzesPage({super.key}) extends StatefulWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<QuizzesCubit>()..load(),
      child: this,
    );
  }

  @override
  State<QuizzesPage> createState() => _QuizzesPageState();
}

class _QuizzesPageState() extends State<QuizzesPage> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.quizzes;
    final progress = context.select((QuizzesCubit cubit) => cubit.state.progress);
    final cubit = context.read<QuizzesCubit>();

    return BaseView(
      appBar: BaseAppBar(title: l10n.title),
      body: SkeletonizerResourceWidget<QuizzesProgress>(
        progress,
        fakeValue: QuizzesProgress.fake(),
        successBuilder: (value) => BaseRefreshable(
          onRefresh: cubit.load,
          child: _QuizzesBody(progress: value),
        ),
        failureBuilder: (_) => BaseEmptyState(
          title: l10n.loadErrorTitle,
          text: l10n.loadErrorText,
          actionText: context.l10n.common.retry,
          onAction: cubit.load,
        ),
      ),
    );
  }
}

class const _QuizzesBody({required final QuizzesProgress progress}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.quizzes;

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            header: true,
            child: AppHighlightedText(
              text: l10n.headline,
              highlight: l10n.headlineHighlight,
              style: context.text.display,
            ),
          ),
          const SizedBox(height: AppSpace.s8),
          Text(l10n.intro, style: context.text.body.copyWith(color: context.colors.textSecondary)),
          const SizedBox(height: AppSpace.s20),
          BaseListGroup(
            children: [
              for (final kind in QuizKind.values)
                _QuizRow(kind: kind, doneAt: progress.doneFor(kind)),
            ],
          ),
          const SizedBox(height: AppSpace.s16),
          BaseNote(text: l10n.note),
        ],
      ),
    );
  }
}

class const _QuizRow({required final QuizKind kind, final DateTime? doneAt})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.quizzes;
    final cubit = context.read<QuizzesCubit>();

    return BaseListTile(
      icon: kind.icon,
      title: kind.title(context),
      subtitle: quizMeta(context),
      value: doneAt == null ? l10n.start : quizDoneLabel(context, doneAt!),
      showsChevron: true,
      onTap: () async {
        await switch (kind) {
          QuizKind.loved => context.pushRoute(const LoveStyleRoute()),
          QuizKind.conflictStyle => context.pushRoute(const FightStyleRoute()),
        };
        if (context.mounted) await cubit.load();
      },
    );
  }
}
