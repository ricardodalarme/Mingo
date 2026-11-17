import 'package:app/features/mood/presentation/mood/mood_faces.dart';
import 'package:app/features/widgets/data/models/widget_family.dart';
import 'package:app/features/widgets/data/models/widget_payload.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:clock/clock.dart';
import 'package:design_system/design_system.dart';
import 'package:formatters/formatters.dart';

/// A live widget preview for one family (`X-145` to `X-153`).
///
/// The preview applies the same privacy rules as the native payload: names,
/// notes, moods, and distance only appear when the payload carries them.
class const WidgetFamilyPreview({
  required final WidgetFamily family,
  required final WidgetPayload payload,
  final VoidCallback? onTap,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;
    final label = l10n.familyLabels.selectOrFallback(family.name);

    return Semantics(
      label: label,
      button: onTap != null,
      child: AspectRatio(
        aspectRatio: family.size.aspectRatio,
        child: AppPressable(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.xxl),
          child: WidgetPreviewSurface(child: _content(context)),
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    if (!payload.isSignedIn) return const _SignedOutWidgetCard();
    if (family.requiresPartner && !payload.isPaired) return const _UnpairedWidgetCard();

    return switch (family) {
      .counter => _CounterPreview(payload: payload, compact: true, medium: false),
      .counterMedium => _CounterPreview(payload: payload, compact: false, medium: true),
      .partnerMood => _PartnerMoodPreview(payload: payload),
      .longing => _LongingPreview(payload: payload),
      .ritual || .ownRitual => _RitualPreview(payload: payload),
      .partnerNote => _PartnerNotePreview(payload: payload),
      .cardEncounter => _CardEncounterPreview(payload: payload),
      .distance => _DistancePreview(payload: payload),
      .ownSlip => const _OwnSlipPreview(),
      .ownNextDate => _OwnDatePreview(payload: payload, medium: false),
      .ownSundayCard => _OwnSundayCardPreview(payload: payload),
      .ownWeek => _OwnWeekPreview(payload: payload),
      .ownIdea => _OwnIdeaPreview(payload: payload),
      .ownMediumDate => _OwnDatePreview(payload: payload, medium: true),
    };
  }
}

/// The neutral surface every widget family sits on.
class const WidgetPreviewSurface({required final Widget child, final Color? background, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final surface = background ?? colors.bgSurface;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.xxl)),
        border: AppBorders.hair(colors.borderDefault),
        boxShadow: AppShadows.ring,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.xxl)),
        child: CustomPaint(
          painter: WashPainter(
            wash: AppWash.letter,
            strong: colors.accentSoft,
            light: colors.washLight,
            background: surface,
          ),
          child: Padding(padding: const EdgeInsets.all(AppSpace.s14), child: child),
        ),
      ),
    );
  }
}

class const _Eyebrow({required final String text, final IconData? icon}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          AppIcon(icon: icon!, size: AppIconSize.xs, color: colors.accentLabel),
          const SizedBox(width: AppSpace.s4),
        ],
        Flexible(
          child: Text(
            text.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.text.micro.copyWith(color: colors.accentLabel),
          ),
        ),
      ],
    );
  }
}

Widget _fill(Widget child) => SizedBox.expand(child: child);

class const _SignedOutWidgetCard() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;

    return _fill(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Eyebrow(text: 'Mingo'),
          const Spacer(),
          Text(l10n.signedOutBody, style: context.text.titleSm),
        ],
      ),
    );
  }
}

class const _UnpairedWidgetCard() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;

    return _fill(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Eyebrow(text: l10n.coupleLabel),
          const Spacer(),
          Text(l10n.statesUnpairedTitle, style: context.text.titleSm),
          const SizedBox(height: AppSpace.s4),
          Text(
            l10n.statesUnpairedAction,
            style: context.text.caption.copyWith(color: context.colors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class const _CounterPreview({
  required final WidgetPayload payload,
  required final bool compact,
  required final bool medium,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;
    final colors = context.colors;
    final now = clock.now();
    final days = payload.daysTogetherOn(now);
    final breakdown = payload.durationBreakdownOn(now);
    final selfInitials = _initials(payload.visibleOwnName);
    final partnerInitials = _initials(payload.visiblePartnerName);
    final showsPair = selfInitials != null || partnerInitials != null;

    if (days == null) {
      return _fill(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Eyebrow(text: l10n.counterEyebrow, icon: AppIcons.heart),
            const Spacer(),
            Text(l10n.counterNeedDate, style: context.text.titleSm),
          ],
        ),
      );
    }

    return _fill(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _Eyebrow(text: l10n.counterEyebrow, icon: AppIcons.heart),
              ),
              if (showsPair)
                BaseAvatarPair(
                  selfInitials: selfInitials,
                  partnerInitials: partnerInitials,
                  size: BaseAvatarSize.small,
                ),
            ],
          ),
          const Spacer(),
          Text(
            '$days',
            style: context.text.display.copyWith(
              color: colors.textPrimary,
              fontSize: compact ? 34 : 40,
            ),
          ),
          Text(
            l10n.counterDaysUnit(count: days),
            style: context.text.caption.copyWith(color: colors.textSecondary),
          ),
          if (medium && breakdown != null) ...[
            const SizedBox(height: AppSpace.s6),
            Text(
              l10n.counterBreakdown(
                years: breakdown.years,
                months: breakdown.months,
                days: breakdown.days,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.text.micro.copyWith(color: colors.textSecondary),
            ),
            const SizedBox(height: AppSpace.s8),
            _CounterTimeline(payload: payload),
          ],
        ],
      ),
    );
  }
}

class const _CounterTimeline({required final WidgetPayload payload}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;
    final colors = context.colors;
    final start = payload.togetherSince;

    return Row(
      children: [
        const _TimelineDot(filled: true),
        Expanded(child: Container(height: 1, color: colors.borderDefault)),
        const _TimelineDot(filled: false),
        const SizedBox(width: AppSpace.s6),
        Text(l10n.counterToday, style: context.text.micro.copyWith(color: colors.textSecondary)),
        if (start != null) ...[
          const SizedBox(width: AppSpace.s4),
          Flexible(
            child: Text(
              '· ${l10n.counterSince(date: _shortDate(start))}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.text.micro.copyWith(color: colors.textSecondary),
            ),
          ),
        ],
      ],
    );
  }
}

class const _TimelineDot({required final bool filled}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: AppSpace.s6,
      height: AppSpace.s6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? colors.accentLabel : colors.bgSurface,
        border: filled ? null : Border.all(color: colors.borderDefault),
      ),
    );
  }
}

class const _PartnerMoodPreview({required final WidgetPayload payload}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;
    final colors = context.colors;
    final mood = payload.visiblePartnerMood;
    final name = payload.visiblePartnerName;

    if (mood == null) {
      return _fill(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Eyebrow(text: l10n.partnerMoodLabel, icon: AppIcons.sparkle),
            const Spacer(),
            Text(
              l10n.partnerMoodHidden,
              style: context.text.caption.copyWith(color: colors.textSecondary),
            ),
          ],
        ),
      );
    }

    return _fill(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Eyebrow(
            text: name == null ? l10n.partnerMoodNowAnonymous : l10n.partnerMoodNow(name: name),
            icon: AppIcons.sparkle,
          ),
          const Spacer(),
          Row(
            children: [
              BaseFace(kind: mood.face, size: FaceSize.small),
              const SizedBox(width: AppSpace.s8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.mood.moods.selectOrFallback(mood.name),
                      style: context.text.titleSm,
                    ),
                    const SizedBox(height: AppSpace.s2),
                    Text(
                      _relativeTime(context, payload.partnerMoodAtTime),
                      style: context.text.micro.copyWith(color: colors.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class const _LongingPreview({required final WidgetPayload payload}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;
    final colors = context.colors;
    final receivedAt = payload.partnerMissedAtTime;

    return _fill(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Eyebrow(text: l10n.longingLabel, icon: AppIcons.heart),
          const Spacer(),
          Text(
            receivedAt == null ? l10n.longingAction : l10n.longingReceived,
            style: context.text.titleSm,
          ),
          const SizedBox(height: AppSpace.s4),
          Text(
            receivedAt == null ? l10n.longingHint : _relativeTime(context, receivedAt),
            style: context.text.caption.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class const _RitualPreview({required final WidgetPayload payload}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;
    final colors = context.colors;

    return _fill(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Eyebrow(text: l10n.ritualLabel, icon: AppIcons.clock),
          const Spacer(),
          Text(
            payload.ritualTitle ?? l10n.ritualEmptyTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.text.titleSm,
          ),
          const SizedBox(height: AppSpace.s4),
          Text(
            payload.ritualSchedule ?? l10n.ritualEmptyHint,
            style: context.text.caption.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class const _PartnerNotePreview({required final WidgetPayload payload}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;
    final colors = context.colors;
    final note = payload.visiblePartnerNote;
    final name = payload.visiblePartnerName;
    final at = payload.partnerNoteAtTime;
    final from = name == null
        ? l10n.noteFromPartner(time: _clockTime(at))
        : l10n.noteFromName(name: name, time: _clockTime(at));

    if (!payload.allowPartnerNotes) {
      return _fill(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Eyebrow(text: l10n.noteFromPartner(time: _clockTime(at))),
            const Spacer(),
            Text(l10n.noteDisabled, style: context.text.titleSm),
            const SizedBox(height: AppSpace.s4),
            Text(
              l10n.noteDisabledHint,
              style: context.text.caption.copyWith(color: colors.textSecondary),
            ),
          ],
        ),
      );
    }

    if (note == null) {
      return _fill(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Eyebrow(text: from),
            const Spacer(),
            Text(l10n.noteEmpty, style: context.text.titleSm),
            const SizedBox(height: AppSpace.s4),
            Text(
              l10n.noteEmptyHint,
              style: context.text.caption.copyWith(color: colors.textSecondary),
            ),
          ],
        ),
      );
    }

    return _fill(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Eyebrow(text: from),
          const SizedBox(height: AppSpace.s6),
          Expanded(
            child: Text(
              note,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.text.hand.copyWith(color: colors.textPrimary),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: AppIcon(icon: AppIcons.heart, size: AppIconSize.sm, color: colors.accentLabel),
          ),
        ],
      ),
    );
  }
}

class const _CardEncounterPreview({required final WidgetPayload payload}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;
    final colors = context.colors;
    final days = payload.daysUntilNextDateOn(clock.now());
    final date = _parseDate(payload.nextDateOn);

    return _fill(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (date != null) ...[_DateBadge(date: date), const SizedBox(width: AppSpace.s12)],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.nextEncounterLabel,
                      style: context.text.label.copyWith(color: colors.textSecondary),
                    ),
                    const SizedBox(height: AppSpace.s2),
                    Text(
                      days == null
                          ? l10n.nextEncounterEmptyTitle
                          : l10n.nextEncounterInDays(count: days),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.text.titleSm,
                    ),
                    const SizedBox(height: AppSpace.s2),
                    Text(
                      payload.nextDateTitle ?? l10n.nextEncounterEmptySubtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.text.caption.copyWith(color: colors.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          DecoratedBox(
            decoration: BoxDecoration(
              color: colors.accentSoft,
              borderRadius: const BorderRadius.all(Radius.circular(AppRadius.pill)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.s10, vertical: AppSpace.s6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppIcon(icon: AppIcons.mail, size: AppIconSize.xs, color: colors.accentOnSoft),
                  const SizedBox(width: AppSpace.s6),
                  Flexible(
                    child: Text(
                      _cardLabel(context, payload),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.text.micro.copyWith(color: colors.accentOnSoft),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class const _DateBadge({required final DateTime date}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final locale = LocaleSettings.currentLocale.languageCode;
    final weekday = DateFormatters.custom(date, 'EEE', locale: locale).replaceAll('.', '');

    return Container(
      width: 54,
      padding: const EdgeInsets.symmetric(vertical: AppSpace.s6),
      decoration: BoxDecoration(
        color: colors.bgSurface,
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.md)),
        border: AppBorders.hair(colors.borderDefault),
      ),
      child: Column(
        children: [
          Text(
            weekday.toUpperCase(),
            style: context.text.micro.copyWith(color: colors.accentLabel),
          ),
          Text('${date.day}', style: context.text.titleMd),
          Text(
            DateFormatters.custom(date, 'MMM', locale: locale).replaceAll('.', ''),
            style: context.text.micro.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class const _DistancePreview({required final WidgetPayload payload}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;
    final colors = context.colors;

    if (!payload.hasDistance) {
      return _fill(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Eyebrow(text: l10n.distanceLabel, icon: AppIcons.globe),
            const Spacer(),
            Text(l10n.distanceHidden, style: context.text.titleSm),
            const SizedBox(height: AppSpace.s4),
            Text(
              l10n.distanceHint,
              style: context.text.caption.copyWith(color: colors.textSecondary),
            ),
          ],
        ),
      );
    }

    return _fill(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Eyebrow(text: l10n.distanceLabel, icon: AppIcons.globe),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: _ZoneClock(
                  time: payload.ownLocalTime,
                  city: _zoneCity(context, payload.ownZone),
                  isMine: true,
                ),
              ),
              Container(width: 1, height: 34, color: colors.borderDefault),
              const SizedBox(width: AppSpace.s12),
              Expanded(
                child: _ZoneClock(
                  time: payload.partnerLocalTime,
                  city: _zoneCity(context, payload.partnerZone),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            payload.reunionDays == null
                ? l10n.distanceNoReunion
                : l10n.distanceUntil(count: payload.reunionDays!),
            style: context.text.titleSm,
          ),
          const SizedBox(height: AppSpace.s2),
          Text(
            payload.reunionTitle ?? l10n.distanceHint,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.text.caption.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class const _ZoneClock({
  required final String? time,
  required final String city,
  final bool isMine = false,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(time ?? '--:--', style: context.text.titleMd.copyWith(color: colors.textPrimary)),
        Text(
          isMine ? l10n.distanceYou(city: city) : city,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.text.micro.copyWith(color: colors.textSecondary),
        ),
      ],
    );
  }
}

class const _OwnSlipPreview() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;
    final colors = context.colors;

    return _fill(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Eyebrow(text: l10n.ownSlipLabel, icon: AppIcons.note),
          const Spacer(),
          Text(l10n.ownSlipQuestion, style: context.text.hand.copyWith(color: colors.textPrimary)),
          const SizedBox(height: AppSpace.s6),
          Row(
            children: [
              AppIcon(icon: AppIcons.plus, size: AppIconSize.xs, color: colors.accentLabel),
              const SizedBox(width: AppSpace.s4),
              Flexible(
                child: Text(
                  l10n.ownSlipAction,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.micro.copyWith(color: colors.accentLabel),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class const _OwnDatePreview({required final WidgetPayload payload, required final bool medium})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;
    final colors = context.colors;
    final days = payload.daysUntilNextDateOn(clock.now());

    return _fill(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Eyebrow(text: l10n.ownNextDateLabel, icon: AppIcons.calendar),
          const Spacer(),
          Text(
            days == null ? l10n.ownNextDateDefault : '$days',
            style: medium
                ? context.text.display.copyWith(color: colors.textPrimary)
                : context.text.titleLg.copyWith(color: colors.textPrimary),
          ),
          Text(
            days == null ? l10n.ownNextDateHint : l10n.ownDateCount(count: days),
            style: context.text.caption.copyWith(color: colors.textSecondary),
          ),
          if (payload.nextDateTitle != null) ...[
            const SizedBox(height: AppSpace.s2),
            Text(
              payload.nextDateTitle!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.text.micro.copyWith(color: colors.textPrimary),
            ),
          ],
        ],
      ),
    );
  }
}

class const _OwnSundayCardPreview({required final WidgetPayload payload}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;
    final colors = context.colors;

    return _fill(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Eyebrow(text: l10n.ownSundayCardLabel, icon: AppIcons.mail),
          const Spacer(),
          Text(l10n.cardSundayTitle, style: context.text.titleSm),
          const SizedBox(height: AppSpace.s4),
          Text(
            _cardSchedule(context, payload),
            style: context.text.caption.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class const _OwnWeekPreview({required final WidgetPayload payload}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;
    final colors = context.colors;
    final labels = l10n.weekdays;
    final active = payload.slipDays
        .map(_parseDate)
        .whereType<DateTime>()
        .map((date) => date.weekday)
        .toSet();

    return _fill(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(l10n.ownWeekTitle, style: context.text.titleSm)),
              Text(
                l10n.ownWeekCount(count: payload.slipsThisWeek),
                style: context.text.caption.copyWith(color: colors.textSecondary),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(labels.length, (index) {
              final isActive = active.contains(index + 1);
              return Column(
                children: [
                  Container(
                    width: AppSpace.s12,
                    height: AppSpace.s12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive ? colors.accentLabel : colors.accentSoft,
                    ),
                  ),
                  const SizedBox(height: AppSpace.s4),
                  Text(
                    labels[index],
                    style: context.text.tab.copyWith(color: colors.textSecondary),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

class const _OwnIdeaPreview({required final WidgetPayload payload}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;
    final colors = context.colors;

    return _fill(
      Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Eyebrow(text: l10n.ownIdeaLabel, icon: AppIcons.lightbulb_filled),
                const Spacer(),
                Text(
                  payload.dailyIdeaTitle ?? l10n.ownIdeaDefault,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.titleSm,
                ),
                const SizedBox(height: AppSpace.s4),
                Text(
                  l10n.ownIdeaHint,
                  style: context.text.caption.copyWith(color: colors.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpace.s12),
          DecoratedBox(
            decoration: BoxDecoration(
              color: colors.accentSoft,
              borderRadius: const BorderRadius.all(Radius.circular(AppRadius.md)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpace.s10),
              child: AppIcon(icon: AppIcons.sparkle, color: colors.accentOnSoft),
            ),
          ),
        ],
      ),
    );
  }
}

String _cardLabel(BuildContext context, WidgetPayload payload) {
  final l10n = context.l10n.widgets;

  return switch (payload.cardState) {
    'ready' => l10n.cardStateReady,
    'sent' => l10n.cardStateSent,
    _ => '${l10n.cardSundayTitle} · ${_cardSchedule(context, payload)}',
  };
}

String _cardSchedule(BuildContext context, WidgetPayload payload) {
  final l10n = context.l10n.widgets;
  final day = payload.cardSendDay;
  final hour = payload.cardSendHour;
  if (day == null || hour == null) return l10n.cardStateNone;

  final labels = l10n.weekdays;
  final label = labels[_sundayFirstIndex(day)];

  return l10n.cardSendAt(day: label, time: '${hour.toString().padLeft(2, '0')}:00');
}

int _sundayFirstIndex(int day) {
  if (day < 0 || day > 6) return 0;
  return ((day + 6) % 7).clamp(0, 6);
}

Map<String, String> _timeZones(BuildContext context) => context.l10n.profileDetails.timeZones;

String _zoneCity(BuildContext context, String? zone) {
  if (zone == null || zone.isEmpty) return '';
  return _timeZones(context)[zone] ?? zone.split('/').last.replaceAll('_', ' ');
}

String? _initials(String? name) {
  final trimmed = name?.trim();
  if (trimmed == null || trimmed.isEmpty) return null;
  return trimmed.substring(0, 1).toUpperCase();
}

String _relativeTime(BuildContext context, DateTime? at) {
  final l10n = context.l10n.widgets;
  if (at == null) return '';
  final diff = clock.now().difference(at);
  if (diff.inMinutes < 1) return l10n.moodJustNow;
  if (diff.inMinutes < 60) return l10n.moodMinutesAgo(minutes: diff.inMinutes);
  if (diff.inHours < 24) return l10n.moodHoursAgo(hours: diff.inHours);

  return l10n.moodDaysAgo(days: diff.inDays);
}

String _clockTime(DateTime? at) {
  if (at == null) return '';
  final hour = at.hour.toString().padLeft(2, '0');
  final minute = at.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

String _shortDate(String raw) {
  final date = _parseDate(raw);
  if (date == null) return raw;
  final locale = LocaleSettings.currentLocale.languageCode;
  return DateFormatters.custom(date, 'd MMM', locale: locale).replaceAll('.', '');
}

DateTime? _parseDate(String? raw) {
  if (raw == null || raw.isEmpty) return null;
  return DateTime.tryParse(raw.split('T').first);
}
