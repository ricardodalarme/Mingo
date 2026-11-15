import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode listCardExample = WidgetbookComponent(
  name: 'BaseListCard',
  useCases: <WidgetbookUseCase>[
    WidgetbookUseCase(
      name: 'Tappable and plain',
      builder: (context) {
        final isTappable = context.knobs.boolean(label: 'Tappable', initialValue: true);
        final onTap = isTappable ? () {} : null;

        return GalleryPage(
          title: 'List card',
          children: <Widget>[
            GallerySection(
              title: 'Both states · same content',
              children: <Widget>[
                GalleryItem(
                  label: 'Tappable · chevron after the trailing visual',
                  child: GallerySurface(
                    child: BaseListCard(
                      categoryLabel: 'Idea of the day',
                      title: 'Make coffee and take it to the balcony.',
                      supportText: 'Takes 10 minutes.',
                      face: FaceKind.smile,
                      onTap: () {},
                    ),
                  ),
                ),
                const SizedBox(height: AppSpace.cardGap),
                const GalleryItem(
                  label: 'Plain · no chevron, no press state',
                  child: GallerySurface(
                    child: BaseListCard(
                      categoryLabel: 'Idea of the day',
                      title: 'Make coffee and take it to the balcony.',
                      supportText: 'Takes 10 minutes.',
                      face: FaceKind.smile,
                    ),
                  ),
                ),
              ],
            ),
            GallerySection(
              title: 'All four categories',
              children: <Widget>[
                GalleryItem(
                  label: 'Idea · face trailing',
                  child: GallerySurface(
                    child: BaseListCard(
                      category: AppCategory.idea,
                      categoryLabel: 'Idea of the day',
                      title: 'Make coffee and take it to the balcony.',
                      supportText: 'Takes 10 minutes.',
                      face: FaceKind.smile,
                      onTap: onTap,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpace.cardGap),
                GalleryItem(
                  label: 'Dates · icon tile trailing',
                  child: GallerySurface(
                    child: BaseListCard(
                      category: AppCategory.dates,
                      categoryLabel: 'Anniversary',
                      title: 'The day you met.',
                      supportText: 'In 12 days',
                      trailing: const BaseIconTile(
                        icon: AppIcons.calendar,
                        size: BaseIconTileSize.small,
                        variant: BaseIconTileVariant.neutral,
                      ),
                      onTap: onTap,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpace.cardGap),
                GalleryItem(
                  label: 'Invite · compact button trailing',
                  child: GallerySurface(
                    child: BaseListCard(
                      category: AppCategory.invite,
                      categoryLabel: 'Invite and private',
                      title: 'A question only you can see.',
                      supportText: 'Stays private.',
                      trailing: BaseButton.compact(text: 'Open', onPressed: () {}),
                      onTap: onTap,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpace.cardGap),
                GalleryItem(
                  label: 'Card · no trailing widget',
                  child: GallerySurface(
                    child: BaseListCard(
                      categoryLabel: 'For you two',
                      title: 'A card leaves every Sunday at 18:00.',
                      onTap: onTap,
                    ),
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
