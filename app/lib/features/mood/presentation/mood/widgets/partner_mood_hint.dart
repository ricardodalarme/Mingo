import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/need_kind.dart';
import 'package:app/features/mood/data/models/partner_mood.dart';
import 'package:app/features/mood/presentation/mood/mood_faces.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// The partner's shared mood for today, hidden entirely in discreet mode.
class const PartnerMoodHint({
  required final PartnerMood partnerMood,
  required final bool isDiscreet,
  final String? partnerName,
  final VoidCallback? onTap,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mood = partnerMood.mood;
    if (isDiscreet || mood == null) return const SizedBox.shrink();

    final l10n = context.l10n.mood;
    final name = partnerName ?? l10n.partnerFallback;
    final line = switch (mood) {
      MoodKind.happy => l10n.partnerHappy(name: name),
      MoodKind.tired => l10n.partnerTired(name: name),
      MoodKind.sad => l10n.partnerSad(name: name),
      MoodKind.stressed => l10n.partnerStressed(name: name),
      MoodKind.loving => l10n.partnerLoving(name: name),
      MoodKind.playful => l10n.partnerPlayful(name: name),
    };
    final needLine = switch (partnerMood.need) {
      NeedKind.listen => l10n.partnerNeedListen,
      NeedKind.opinion => l10n.partnerNeedOpinion,
      NeedKind.hug => l10n.partnerNeedHug,
      NeedKind.space => l10n.partnerNeedSpace,
      null => null,
    };

    return BaseListCard(
      categoryLabel: l10n.partnerLabel,
      title: line,
      supportText: needLine,
      face: mood.face,
      onTap: onTap,
    );
  }
}
