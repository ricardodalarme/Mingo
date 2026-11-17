import 'package:app/features/widgets/data/models/widget_family.dart';
import 'package:app/features/widgets/data/models/widget_payload.dart';
import 'package:app/features/widgets/presentation/shared/widget_family_preview.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// The four small personal widgets (`X-146`), two per row.
class const OwnSmallWidgetsGrid({
  required final WidgetPayload payload,
  required final ValueChanged<WidgetFamily> onTap,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const families = widgetFamilyOwnSmall;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var index = 0; index < families.length; index += 2) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _tile(context, families[index], payload, onTap)),
              const SizedBox(width: AppSpace.s12),
              Expanded(
                child: index + 1 < families.length
                    ? _tile(context, families[index + 1], payload, onTap)
                    : const SizedBox.shrink(),
              ),
            ],
          ),
          if (index + 2 < families.length) const SizedBox(height: AppSpace.s16),
        ],
      ],
    );
  }

  Widget _tile(
    BuildContext context,
    WidgetFamily family,
    WidgetPayload payload,
    ValueChanged<WidgetFamily> onTap,
  ) {
    final l10n = context.l10n.widgets;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetFamilyPreview(family: family, payload: payload, onTap: () => onTap(family)),
        const SizedBox(height: AppSpace.s8),
        Text(
          l10n.familyLabels.selectOrFallback(family.name),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: context.text.caption.copyWith(color: context.colors.textSecondary),
        ),
      ],
    );
  }
}
