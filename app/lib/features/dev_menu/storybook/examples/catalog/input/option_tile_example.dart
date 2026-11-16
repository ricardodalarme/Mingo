import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode optionTileExample = WidgetbookComponent(
  name: 'Option tile',
  useCases: [
    WidgetbookUseCase(
      name: 'Radio, checkbox, selected and support',
      builder: (context) => GalleryPage(
        title: 'Option tile',
        children: [
          GallerySection(
            title: 'Radio · unselected',
            children: [
              GallerySurface(
                child: BaseOptionTile(
                  title: 'Every day',
                  support: 'A reminder at the same time each day.',
                  leading: const BaseIconTile(icon: AppIcons.bell),
                  onTap: () {},
                ),
              ),
            ],
          ),
          GallerySection(
            title: 'Radio · selected',
            children: [
              GallerySurface(
                child: BaseOptionTile(
                  title: 'Every week',
                  support: 'A reminder on the day you choose.',
                  leading: const BaseIconTile(icon: AppIcons.calendar),
                  isSelected: true,
                  onTap: () {},
                ),
              ),
            ],
          ),
          GallerySection(
            title: 'Checkbox · selected with support',
            children: [
              GallerySurface(
                child: BaseOptionTile(
                  title: 'Share with your partner',
                  support: 'They can read this answer after you send it.',
                  control: BaseOptionTileControl.checkbox,
                  isSelected: true,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    WidgetbookUseCase(
      name: 'With preview',
      builder: (context) {
        final selected = context.knobs.int.slider(label: 'Selected', max: 1);

        return GalleryPage(
          title: 'Option tile, with preview',
          children: [
            GallerySurface(
              child: Column(
                spacing: AppSpace.s10,
                children: [
                  BaseOptionTile(
                    title: 'Rosa suave',
                    support: 'Quente e delicado',
                    preview: const ColoredBox(
                      color: AppHue.roseSoft,
                      child: Center(child: AppIcon(icon: AppIcons.heart_filled)),
                    ),
                    isSelected: selected == 0,
                    onTap: () {},
                  ),
                  BaseOptionTile(
                    title: 'Azul suave',
                    support: 'Calmo e leve',
                    preview: const ColoredBox(
                      color: AppHue.blueSoft,
                      child: Center(child: AppIcon(icon: AppIcons.cloud)),
                    ),
                    isSelected: selected == 1,
                    onTap: () {},
                  ),
                  const BaseOptionTile(
                    title: 'Indisponível',
                    support: 'Em breve',
                    preview: ColoredBox(color: AppPalette.neutral100),
                    isEnabled: false,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  ],
);
