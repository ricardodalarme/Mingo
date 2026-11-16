import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode timelineExample = WidgetbookComponent(
  name: 'BaseTimeline',
  useCases: <WidgetbookUseCase>[
    WidgetbookUseCase(
      name: 'Items, thumbnail and add row',
      builder: (context) => GalleryPage(
        title: 'Timeline',
        children: <Widget>[
          BaseTimeline(
            children: <Widget>[
              BaseTimelineItem(title: 'Nos conhecemos', meta: '14 mar 2024', onTap: () {}),
              BaseTimelineItem(
                title: 'Primeira viagem juntos',
                meta: 'jul 2025 · Paraty',
                thumbnail: const BaseImagePlaceholder(),
                onTap: () {},
              ),
              BaseTimelineItem.add(label: 'Adicionar um marco', onTap: () {}),
            ],
          ),
        ],
      ),
    ),
    WidgetbookUseCase(
      name: 'Empty and long text',
      builder: (context) => GalleryPage(
        title: 'Timeline, edge cases',
        children: <Widget>[
          BaseTimeline(
            children: <Widget>[
              const BaseTimelineItem(
                title: 'Um título muito longo que precisa quebrar em mais de uma linha sem estourar o cartão',
                meta: 'dezembro de 2025 · Florianópolis, Santa Catarina',
              ),
              BaseTimelineItem.add(label: 'Adicionar um marco', onTap: () {}),
            ],
          ),
        ],
      ),
    ),
  ],
);
