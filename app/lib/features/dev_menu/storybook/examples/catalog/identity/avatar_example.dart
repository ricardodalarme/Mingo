import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode avatarExample = WidgetbookComponent(
  name: 'BaseAvatar',
  useCases: <WidgetbookUseCase>[
    WidgetbookUseCase(
      name: 'Sizes, own, partner and empty',
      builder: (context) => GalleryPage(
        title: 'Avatar',
        children: <Widget>[
          GallerySection(
            title: 'Own · 24, 40, 64 and 104',
            children: <Widget>[
              GalleryRow(
                children: <Widget>[
                  for (final size in BaseAvatarSize.values)
                    GalleryItem(
                      label: '${size.diameter.round()}',
                      child: BaseAvatar(initials: 'R', size: size, semanticLabel: 'You'),
                    ),
                ],
              ),
            ],
          ),
          GallerySection(
            title: 'Partner',
            children: <Widget>[
              GalleryRow(
                children: <Widget>[
                  for (final size in BaseAvatarSize.values)
                    GalleryItem(
                      label: '${size.diameter.round()}',
                      child: BaseAvatar(
                        initials: 'M',
                        size: size,
                        isPartner: true,
                        semanticLabel: 'Marina',
                      ),
                    ),
                ],
              ),
            ],
          ),
          GallerySection(
            title: 'Empty and tappable',
            children: <Widget>[
              GalleryRow(
                children: <Widget>[
                  BaseAvatar(isEmpty: true, onTap: () {}, semanticLabel: 'Add a photo'),
                  const BaseAvatar(isEmpty: true, size: BaseAvatarSize.large),
                  const BaseAvatar(isEmpty: true, size: BaseAvatarSize.xl),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
    WidgetbookUseCase(
      name: 'XL with edit badge and states',
      builder: (context) {
        final isUploading = context.knobs.boolean(label: 'Uploading');
        final hasFailed = context.knobs.boolean(label: 'Failed');

        return GalleryPage(
          title: 'Avatar xl',
          children: <Widget>[
            GallerySection(
              title: 'With edit badge',
              children: <Widget>[
                GalleryRow(
                  children: <Widget>[
                    BaseAvatar(
                      initials: 'R',
                      size: BaseAvatarSize.xl,
                      onEdit: () => BaseToast.show(context, 'Open the photo picker'),
                      isUploading: isUploading,
                      hasFailed: hasFailed,
                    ),
                    const BaseAvatar(initials: 'R', size: BaseAvatarSize.xl),
                    const BaseAvatar(initials: 'M', size: BaseAvatarSize.xl, isPartner: true),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    ),
  ],
);
