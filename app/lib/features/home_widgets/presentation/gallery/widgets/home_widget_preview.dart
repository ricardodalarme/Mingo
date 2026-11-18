import 'package:app/features/home_widgets/data/models/home_widget_kind.dart';
import 'package:app/features/home_widgets/data/models/home_widget_payload.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/previews/card_preview.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/previews/counter_preview.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/previews/distance_preview.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/previews/idea_preview.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/previews/invite_preview.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/previews/longing_preview.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/previews/next_date_preview.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/previews/partner_mood_preview.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/previews/partner_note_preview.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/previews/ritual_preview.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/previews/slip_preview.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/previews/week_preview.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:clock/clock.dart';
import 'package:design_system/design_system.dart';

/// How one home widget looks on the home screen for this person right now.
///
/// It is an image of the home widget, not the real one: nothing here reacts to a tap.
class const HomeWidgetPreview({
  required final HomeWidgetVariant variant,
  required final HomeWidgetPayload payload,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.homeWidgets;
    final label = l10n.variantLabels.selectOrFallback(variant.labelKey);

    return Semantics(label: label, image: true, excludeSemantics: true, child: _preview());
  }

  Widget _preview() {
    final now = clock.now();
    final size = variant.size;
    if (variant.kind.needsPartner && !payload.isPaired) {
      return InvitePreview(payload: payload, size: size);
    }

    return switch (variant.kind) {
      .counter => CounterPreview(payload: payload, size: size, now: now),
      .partnerMood => PartnerMoodPreview(payload: payload, now: now),
      .longing => LongingPreview(payload: payload, now: now),
      .ritual => RitualPreview(payload: payload, now: now),
      .partnerNote => PartnerNotePreview(payload: payload, size: size, now: now),
      .card => CardPreview(payload: payload, size: size, now: now),
      .distance => DistancePreview(payload: payload, now: now),
      .slip => SlipPreview(payload: payload),
      .nextDate => NextDatePreview(payload: payload, size: size, now: now),
      .week => WeekPreview(payload: payload, now: now),
      .idea => IdeaPreview(payload: payload),
    };
  }
}
