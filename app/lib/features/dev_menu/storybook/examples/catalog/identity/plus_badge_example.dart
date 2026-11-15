import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode plusBadgeExample = WidgetbookComponent(
  name: 'BasePlusBadge',
  useCases: <WidgetbookUseCase>[
    WidgetbookUseCase(
      name: 'Plus marker',
      builder: (context) => const GalleryPage(
        title: 'Plus badge',
        children: <Widget>[
          GalleryRow(
            children: <Widget>[
              BasePlusBadge(text: 'Plus'),
              BasePlusBadge(text: 'Plus feature'),
            ],
          ),
        ],
      ),
    ),
  ],
);
