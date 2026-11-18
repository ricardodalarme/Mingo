import 'package:app/features/home_widgets/data/models/home_widget_kind.dart';
import 'package:app/features/home_widgets/data/models/home_widget_payload.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_frame.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_palette.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_text.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// The one-tap shortcut to log a slip.
class const SlipPreview({required final HomeWidgetPayload payload, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.homeWidgets;
    final palette = HomeWidgetPalette.of(payload.theme);

    return HomeWidgetFrame(
      size: HomeWidgetSize.small,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.4, -1),
          end: Alignment(0.4, 1),
          colors: [HomeWidgetPalette.charcoal, HomeWidgetPalette.plum],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Opacity(
            opacity: 0.95,
            child: HomeWidgetHandText(
              text: l10n.slipPrompt,
              size: 25,
              color: AppPalette.white,
              maxLines: 2,
            ),
          ),
          Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: palette.highlight,
                  boxShadow: [
                    BoxShadow(color: palette.highlight.withValues(alpha: .25), spreadRadius: 8),
                    BoxShadow(color: palette.highlight.withValues(alpha: .6), blurRadius: 30),
                  ],
                ),
                child: const AppIcon(icon: AppIcons.plus, size: 26, color: AppPalette.white),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Opacity(
                  opacity: 0.8,
                  child: HomeWidgetText(text: l10n.slipAction, size: 13, color: AppPalette.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
