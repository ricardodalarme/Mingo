import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode illustratedBannerExample = WidgetbookComponent(
  name: 'BaseIllustratedBanner',
  useCases: <WidgetbookUseCase>[
    WidgetbookUseCase(
      name: 'Illustrated banner',
      builder: (context) => GalleryPage(
        title: 'Banner, with illustration',
        children: <Widget>[
          BaseIllustratedBanner(
            illustration: SizedBox(
              width: 48,
              height: 40,
              child: Center(
                child: AppIcon(
                  icon: AppIcons.mail_filled,
                  size: AppIconSize.xl,
                  color: context.colors.accentLabel,
                ),
              ),
            ),
            title: 'Chegou um cartão',
            message: '3 coisas boas nesta semana',
            actionLabel: 'Abrir',
            onAction: () {},
          ),
          const SizedBox(height: AppSpace.s16),
          BaseIllustratedBanner(
            illustration: SizedBox(
              width: 48,
              height: 40,
              child: Center(
                child: AppIcon(
                  icon: AppIcons.mail_filled,
                  size: AppIconSize.xl,
                  color: context.colors.accentLabel,
                ),
              ),
            ),
            title: 'Um cartão com um título bem longo que ocupa duas linhas',
            actionLabel: 'Abrir',
            onAction: () {},
          ),
        ],
      ),
    ),
  ],
);
