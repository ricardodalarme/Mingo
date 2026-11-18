import 'package:app/features/home_widgets/data/models/home_widget_card_state.dart';
import 'package:app/features/home_widgets/data/models/home_widget_kind.dart';
import 'package:app/features/home_widgets/data/models/home_widget_payload.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_copy.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_frame.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_heart.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_palette.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_text.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// The Sunday card when small; the card and the next date as a ticket when medium.
class const CardPreview({
  required final HomeWidgetPayload payload,
  required final HomeWidgetSize size,
  required final DateTime now,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final palette = HomeWidgetPalette.of(payload.theme);

    return size == HomeWidgetSize.small
        ? _SmallCard(payload: payload, palette: palette, now: now)
        : _Ticket(payload: payload, palette: palette, now: now);
  }
}

String _cardLine(BuildContext context, HomeWidgetPayload payload, DateTime now) {
  final l10n = context.l10n.homeWidgets;

  return switch (payload.cardState) {
    HomeWidgetCardState.ready => l10n.cardReady,
    HomeWidgetCardState.sent => l10n.cardSent,
    HomeWidgetCardState.none => switch ((payload.cardSendDay, payload.cardSendHour)) {
      (final day?, final hour?) => l10n.cardSends(
        when: context.whenText(
          weekday: day == 0 ? DateTime.sunday : day,
          time: '${hour.toString().padLeft(2, '0')}:00',
          now: now,
        ),
      ),
      _ => l10n.cardTitle,
    },
  };
}

class const _SmallCard({
  required final HomeWidgetPayload payload,
  required final HomeWidgetPalette palette,
  required final DateTime now,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.homeWidgets;
    final count = payload.slipsThisWeek;

    return HomeWidgetFrame(
      size: HomeWidgetSize.small,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(-0.4, -1),
          end: const Alignment(0.4, 1),
          colors: [palette.soft, HomeWidgetPalette.cream],
        ),
      ),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: palette.ink),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: -2,
              top: 14,
              child: Transform.rotate(angle: 0.157, child: const _Sheet(child: SizedBox.shrink())),
            ),
            Positioned(
              right: 10,
              top: 6,
              child: Transform.rotate(
                angle: -0.087,
                child: _Sheet(
                  child: count > 0
                      ? HomeWidgetHandText(
                          text: l10n.goodThings(count: count),
                          size: 17,
                          color: palette.label,
                        )
                      : HomeWidgetHeart(size: 22, color: palette.highlight),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeWidgetText(
                    text: l10n.cardTitle,
                    size: 15,
                    weight: FontWeight.w600,
                    height: 1.2,
                  ),
                  const SizedBox(height: 3),
                  Opacity(
                    opacity: 0.8,
                    child: HomeWidgetText(
                      text: _cardLine(context, payload, now),
                      size: 12.5,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class const _Sheet({required final Widget child}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84,
      height: 104,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: AppPalette.white,
        borderRadius: BorderRadius.all(Radius.circular(14)),
        boxShadow: AppShadows.paper,
      ),
      child: child,
    );
  }
}

class const _Ticket({
  required final HomeWidgetPayload payload,
  required final HomeWidgetPalette palette,
  required final DateTime now,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.homeWidgets;
    final on = payload.daysUntilNextDateOn(now) == null
        ? null
        : DateTime.parse(payload.nextDateOn!);
    final title = payload.nextDateTitle;

    return HomeWidgetFrame(
      size: HomeWidgetSize.medium,
      decoration: BoxDecoration(
        color: AppPalette.white,
        border: Border.all(color: palette.border),
      ),
      child: Row(
        children: [
          Container(
            width: 96,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: const Alignment(-0.3, -1),
                end: const Alignment(0.3, 1),
                colors: [palette.highlight, palette.tintEnd],
              ),
            ),
            child: on == null
                ? const AppIcon(icon: AppIcons.calendar, size: 36, color: AppPalette.white)
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HomeWidgetText(
                        text: context.weekdayShort(on).toUpperCase(),
                        size: 12,
                        weight: FontWeight.w600,
                        letterSpacing: 1.2,
                        color: AppPalette.white,
                        maxLines: 1,
                      ),
                      HomeWidgetText(
                        text: '${on.day}',
                        size: 46,
                        weight: FontWeight.w600,
                        letterSpacing: -1.8,
                        height: 1,
                        color: AppPalette.white,
                        maxLines: 1,
                      ),
                      HomeWidgetText(
                        text: context.monthShort(on),
                        size: 12,
                        color: AppPalette.white,
                        maxLines: 1,
                      ),
                    ],
                  ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeWidgetEyebrow(text: l10n.encounterEyebrow, color: palette.label),
                      const SizedBox(height: 6),
                      HomeWidgetText(
                        text: title ?? l10n.encounterEmpty,
                        size: 19,
                        weight: FontWeight.w600,
                        letterSpacing: -0.4,
                        height: 1.15,
                        color: HomeWidgetPalette.charcoal,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: HomeWidgetText(
                          text: _cardLine(context, payload, now),
                          size: 12.5,
                          color: context.colors.textSecondary,
                          maxLines: 1,
                        ),
                      ),
                      HomeWidgetInitials(
                        own: payload.ownName,
                        partner: payload.partnerName,
                        ownColor: palette.label,
                        ownBackground: palette.soft,
                        size: 24,
                      ),
                    ],
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
