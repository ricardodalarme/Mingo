import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode chipExample = WidgetbookComponent(
  name: 'BaseChip',
  useCases: <WidgetbookUseCase>[
    WidgetbookUseCase(
      name: 'Icon and avatar',
      builder: (context) => GalleryPage(
        title: 'Chip, with avatar or icon',
        children: <Widget>[
          GalleryRow(
            children: <Widget>[
              BaseChip.icon(label: '2 anos e 7 meses', icon: AppIcons.heart_filled, onTap: () {}),
              BaseChip.avatar(label: 'Convidar alguém', initials: 'M', onTap: () {}),
              BaseChip.icon(label: 'Desativado', icon: AppIcons.lock, isEnabled: false),
            ],
          ),
        ],
      ),
    ),
    WidgetbookUseCase(
      name: 'Long label',
      builder: (context) => GalleryPage(
        title: 'Chip, long label',
        children: <Widget>[
          SizedBox(
            width: 220,
            child: BaseChip.icon(
              label: 'Um texto longo demais para caber nesta largura',
              icon: AppIcons.heart_filled,
              onTap: () {},
            ),
          ),
        ],
      ),
    ),
  ],
);
