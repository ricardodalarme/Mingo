import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode statExample = WidgetbookComponent(
  name: 'BaseStat',
  useCases: <WidgetbookUseCase>[
    WidgetbookUseCase(
      name: 'Compact row, large and hero',
      builder: (context) => const GalleryPage(
        title: 'Stat',
        children: <Widget>[
          GallerySection(
            title: 'Compact, in a row of three',
            children: <Widget>[
              BaseStatRow(
                children: <Widget>[
                  BaseStat(value: '969', caption: 'dias'),
                  BaseStat(value: '138', caption: 'fins de semana'),
                  BaseStat(value: '2', caption: 'Natais'),
                ],
              ),
            ],
          ),
          GallerySection(
            title: 'Large',
            children: <Widget>[
              BaseStat(value: '42', caption: 'dias até vocês se verem', size: BaseStatSize.large),
            ],
          ),
          GallerySection(
            title: 'Hero',
            children: <Widget>[
              BaseStat(value: '2 anos', caption: 'e 7 meses', size: BaseStatSize.hero),
            ],
          ),
        ],
      ),
    ),
    WidgetbookUseCase(
      name: 'Missing value',
      builder: (context) => const GalleryPage(
        title: 'Stat, no data',
        children: <Widget>[BaseStat(value: null, caption: 'dias juntos')],
      ),
    ),
  ],
);
