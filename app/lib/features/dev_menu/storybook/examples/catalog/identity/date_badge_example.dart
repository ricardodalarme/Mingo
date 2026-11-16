import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode dateBadgeExample = WidgetbookComponent(
  name: 'BaseDateBadge',
  useCases: <WidgetbookUseCase>[
    WidgetbookUseCase(
      name: 'Tilted, flat and past',
      builder: (context) {
        final month = context.knobs.int.slider(label: 'Month', initialValue: 11, min: 1, max: 12);

        return GalleryPage(
          title: 'Date badge',
          children: <Widget>[
            GalleryRow(
              children: <Widget>[
                GalleryItem(
                  label: 'Tilted',
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpace.s8),
                    child: BaseDateBadge(date: DateTime(2026, month, 20)),
                  ),
                ),
                GalleryItem(
                  label: 'Flat',
                  child: BaseDateBadge(date: DateTime(2026, month, 20), isTilted: false),
                ),
                GalleryItem(
                  label: 'Past',
                  child: BaseDateBadge(
                    date: DateTime(2026, month, 8),
                    isTilted: false,
                    isPast: true,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ),
  ],
);
