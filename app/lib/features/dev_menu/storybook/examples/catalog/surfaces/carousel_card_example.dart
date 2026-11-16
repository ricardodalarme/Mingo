import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode carouselCardExample = WidgetbookComponent(
  name: 'BaseCarouselCard',
  useCases: <WidgetbookUseCase>[
    WidgetbookUseCase(
      name: 'With action, tappable and plain',
      builder: (context) => GalleryPage(
        title: 'Carousel card',
        children: <Widget>[
          GallerySection(
            title: 'Tag, title, support and action',
            children: <Widget>[
              BaseCarouselCard(
                tag: context.knobs.string(label: 'Tag', initialValue: 'Card'),
                title: context.knobs.string(label: 'Title', initialValue: 'Luanna sent you a card'),
                supportText: '3 good things from this week.',
                actionText: 'Open',
                onAction: () {},
              ),
            ],
          ),
          const GallerySection(
            title: 'Without an action',
            children: <Widget>[
              BaseCarouselCard(
                tag: 'Only yours',
                title: 'How was your day, really?',
                supportText: 'It stays with you until you invite someone.',
              ),
            ],
          ),
        ],
      ),
    ),
  ],
);
