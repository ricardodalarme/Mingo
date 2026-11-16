import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode tooltipExample = WidgetbookComponent(
  name: 'BaseTooltip',
  useCases: [
    WidgetbookUseCase(
      name: 'Tap and long press',
      builder: (context) => const GalleryPage(
        title: 'Tooltip',
        children: [
          GallerySection(
            title: 'Tap an info icon, long press a control',
            children: [
              GalleryRow(
                children: [
                  BaseTooltip(
                    message: 'Counts the days in a row you both opened the app.',
                    trigger: BaseTooltipTrigger.tap,
                    child: AppIcon(icon: AppIcons.info, size: AppIconSize.lg),
                  ),
                  BaseTooltip(
                    message: 'Settings',
                    child: BaseRoundButton(
                      icon: AppIcons.settings,
                      semanticLabel: 'Settings',
                      onPressed: _noop,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  ],
);

void _noop() {}
