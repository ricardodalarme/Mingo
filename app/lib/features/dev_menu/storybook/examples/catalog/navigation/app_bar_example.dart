import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode appBarExample = WidgetbookComponent(
  name: 'BaseAppBar',
  useCases: <WidgetbookUseCase>[
    WidgetbookUseCase(
      name: 'Plain, back, close, scrolled and stepper',
      builder: (context) => GalleryPage(
        title: 'App bar',
        children: <Widget>[
          const GallerySection(
            title: 'Plain',
            children: <Widget>[GallerySurface(child: BaseAppBar(title: 'Today'))],
          ),
          GallerySection(
            title: 'With back',
            children: <Widget>[
              GallerySurface(
                child: BaseAppBar(title: 'Choose a colour', onBack: () {}),
              ),
            ],
          ),
          GallerySection(
            title: 'With close',
            children: <Widget>[
              GallerySurface(
                child: BaseAppBar(
                  title: 'Write a slip',
                  subtitle: 'Only you see this',
                  onClose: () {},
                ),
              ),
            ],
          ),
          GallerySection(
            title: 'Scrolled · 94% surface and bottom border',
            children: <Widget>[
              GallerySurface(
                child: BaseAppBar(
                  title: 'Settings',
                  subtitle: 'Scrolled',
                  onBack: () {},
                  hasScrolled: true,
                ),
              ),
            ],
          ),
          GallerySection(
            title: 'With stepper',
            children: <Widget>[
              GallerySurface(
                child: BaseAppBar(
                  title: 'Who is it for?',
                  onBack: () {},
                  stepIndicator: const BaseStepper(
                    count: 5,
                    currentIndex: 1,
                    semanticLabel: 'Step 2 of 5',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    WidgetbookUseCase(
      name: 'Root, detail and conversation',
      builder: (context) => GalleryPage(
        title: 'App bar, kinds',
        children: <Widget>[
          GallerySection(
            title: 'Root · home',
            children: <Widget>[
              GallerySurface(
                child: BaseAppBar(
                  isRoot: true,
                  leading: const BaseAvatarPair(selfInitials: 'M', partnerInitials: 'R'),
                  trailing: BaseChip.icon(
                    label: 'Primeiro dia aqui',
                    icon: AppIcons.heart_filled,
                    onTap: () {},
                  ),
                ),
              ),
            ],
          ),
          GallerySection(
            title: 'Root · section',
            children: <Widget>[
              GallerySurface(
                child: BaseAppBar(
                  isRoot: true,
                  title: 'Slips',
                  trailing: BaseRoundButton(
                    icon: AppIcons.plus,
                    onPressed: () {},
                    semanticLabel: 'Novo slip',
                  ),
                ),
              ),
            ],
          ),
          GallerySection(
            title: 'Detail · action',
            children: <Widget>[
              GallerySurface(
                child: BaseAppBar(
                  title: 'Nossa história',
                  onBack: () {},
                  trailing: BaseRoundButton(
                    icon: AppIcons.plus,
                    onPressed: () {},
                    semanticLabel: 'Adicionar',
                  ),
                ),
              ),
            ],
          ),
          GallerySection(
            title: 'Detail · conversation',
            children: <Widget>[
              GallerySurface(
                child: BaseAppBar(
                  onBack: () {},
                  titleWidget: const Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: AppSpace.s8,
                    children: <Widget>[
                      BaseFace(kind: FaceKind.smile, size: FaceSize.small),
                      Text('Mascote'),
                    ],
                  ),
                  trailing: BaseRoundButton(
                    icon: AppIcons.more,
                    onPressed: () {},
                    semanticLabel: 'Mais',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ],
);
