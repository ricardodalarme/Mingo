import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

Widget _card(BuildContext context, String title, String support) {
  return BaseSurfaceCard(title: title, supportText: support);
}

final WidgetbookNode carouselExample = WidgetbookComponent(
  name: 'BaseCarousel',
  useCases: <WidgetbookUseCase>[
    WidgetbookUseCase(
      name: 'Peek with dots',
      builder: (context) {
        final count = context.knobs.int.slider(label: 'Pages', initialValue: 3, min: 1, max: 5);

        return GalleryPage(
          title: 'Carousel',
          children: <Widget>[
            Transform.translate(
              offset: const Offset(-AppSpace.s24, 0),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: BaseCarousel(
                  children: <Widget>[
                    for (var index = 0; index < count; index++)
                      _card(context, 'Cartão ${index + 1}', 'Uma linha de apoio'),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    ),
    WidgetbookUseCase(
      name: 'Page dots',
      builder: (context) {
        final count = context.knobs.int.slider(label: 'Count', initialValue: 5, min: 1, max: 5);
        final index = context.knobs.int.slider(label: 'Index', max: 4);

        return GalleryPage(
          title: 'Page dots',
          children: <Widget>[BasePageDots(count: count, index: index.clamp(0, count - 1))],
        );
      },
    ),
  ],
);
