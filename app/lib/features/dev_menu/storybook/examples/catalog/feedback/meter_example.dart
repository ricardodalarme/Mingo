import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode meterExample = WidgetbookComponent(
  name: 'BaseMeter',
  useCases: <WidgetbookUseCase>[
    WidgetbookUseCase(
      name: 'Label below, right and thin',
      builder: (context) {
        final value = context.knobs.int.slider(label: 'Used', initialValue: 2, max: 5);

        return GalleryPage(
          title: 'Meter',
          children: <Widget>[
            GallerySection(
              title: 'Inline label',
              children: <Widget>[
                BaseMeter(
                  value: value,
                  max: 5,
                  label: value >= 5 ? 'Volta amanhã' : '$value de 5 hoje',
                ),
              ],
            ),
            GallerySection(
              title: 'Label on the right',
              children: <Widget>[
                BaseMeter(value: value, max: 5, label: '$value/5', labelOnRight: true),
              ],
            ),
            GallerySection(
              title: 'Thin, in a list row',
              children: <Widget>[BaseMeter(value: value, max: 5, isThin: true)],
            ),
            const GallerySection(
              title: 'Full',
              children: <Widget>[BaseMeter(value: 5, max: 5, label: 'Volta amanhã')],
            ),
          ],
        );
      },
    ),
  ],
);
