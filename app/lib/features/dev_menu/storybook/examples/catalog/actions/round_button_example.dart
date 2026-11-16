import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode roundButtonExample = WidgetbookComponent(
  name: 'BaseRoundButton',
  useCases: <WidgetbookUseCase>[
    WidgetbookUseCase(
      name: 'Standard · back, close, add, disabled and badge',
      builder: (context) => GalleryPage(
        title: 'Round button',
        children: <Widget>[
          GalleryRow(
            children: <Widget>[
              BaseRoundButton(icon: AppIcons.chevron_left, onPressed: () {}, semanticLabel: 'Back'),
              BaseRoundButton(icon: AppIcons.close, onPressed: () {}, semanticLabel: 'Close'),
              BaseRoundButton(icon: AppIcons.plus, onPressed: () {}, semanticLabel: 'Add'),
              const BaseRoundButton(
                icon: AppIcons.chevron_left,
                onPressed: null,
                isEnabled: false,
                semanticLabel: 'Back',
              ),
              BaseRoundButton(
                icon: AppIcons.bell,
                onPressed: () {},
                semanticLabel: 'Notifications, new',
                hasBadge: true,
              ),
            ],
          ),
        ],
      ),
    ),
    WidgetbookUseCase(
      name: 'Primary · normal, loading and disabled',
      builder: (context) {
        final isLoading = context.knobs.boolean(label: 'Loading');

        return GalleryPage(
          title: 'Round button, primary',
          children: <Widget>[
            GalleryRow(
              children: <Widget>[
                BaseRoundButton.primary(
                  icon: AppIcons.send,
                  onPressed: () {},
                  isLoading: isLoading,
                  semanticLabel: 'Send',
                ),
                BaseRoundButton.primary(
                  icon: AppIcons.plus,
                  onPressed: () {},
                  semanticLabel: 'Add',
                ),
                const BaseRoundButton.primary(
                  icon: AppIcons.send,
                  onPressed: null,
                  semanticLabel: 'Send',
                ),
                const BaseRoundButton.primary(
                  icon: AppIcons.send,
                  onPressed: null,
                  isLoading: true,
                  semanticLabel: 'Send',
                ),
              ],
            ),
          ],
        );
      },
    ),
  ],
);
