import 'package:app/features/questions/data/models/question_thread.dart';
import 'package:app/features/questions/presentation/questions/cubit/questions_cubit.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The question of the day before the person starts answering.
class const QuestionsIntroView({required final QuestionThread thread, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.questions;
    final cubit = context.read<QuestionsCubit>();
    final body = thread.prompt.body;

    return BaseStackedContent(
      body: BaseSurfaceCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                BaseTag(text: l10n.tag),
                const Spacer(),
                const BaseFace(kind: FaceKind.affectionate, size: FaceSize.small),
              ],
            ),
            const SizedBox(height: AppSpace.s14),
            Semantics(header: true, child: Text(thread.prompt.title, style: context.text.question)),
            if (body != null && body.trim().isNotEmpty) ...[
              const SizedBox(height: AppSpace.s10),
              Text(body, style: context.text.body.copyWith(color: context.colors.textSecondary)),
            ],
            const SizedBox(height: AppSpace.s18),
            BaseButton.primary(text: l10n.answerCta, onPressed: cubit.start),
          ],
        ),
      ),
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BaseNote(text: l10n.introNote, icon: AppIcons.calendar),
          const SizedBox(height: AppSpace.s8),
          BaseButton.text(
            text: l10n.close,
            onPressed: () => context.router.maybePop(),
            isFullWidth: true,
          ),
        ],
      ),
    );
  }
}
