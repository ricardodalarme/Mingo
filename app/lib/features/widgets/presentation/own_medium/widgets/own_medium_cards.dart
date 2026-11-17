import 'package:app/features/widgets/data/models/widget_family.dart';
import 'package:app/features/widgets/data/models/widget_payload.dart';
import 'package:app/features/widgets/presentation/shared/widget_family_preview.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// The three medium personal widgets (`X-147`): Minha semana, Ideia do dia and
/// Próxima data.
class const OwnMediumWidgetsCards({
  required final WidgetPayload payload,
  required final ValueChanged<WidgetFamily> onTap,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const families = widgetFamilyOwnMedium;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var index = 0; index < families.length; index++) ...[
          _tile(context, families[index], payload, onTap),
          if (index < families.length - 1) const SizedBox(height: AppSpace.s16),
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
          style: context.text.caption.copyWith(color: context.colors.textSecondary),
        ),
      ],
    );
  }
}
