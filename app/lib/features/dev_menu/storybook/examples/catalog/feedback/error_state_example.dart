import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode errorStateExample = WidgetbookComponent(
  name: 'Error state',
  useCases: [
    WidgetbookUseCase(
      name: 'Retry and secondary action',
      builder: (context) => GalleryPage(
        title: 'Error state',
        children: [
          GallerySection(
            title: 'Retry',
            children: [
              BaseErrorState(
                title: 'That did not load',
                text: 'Check your connection and try again.',
                actionText: 'Try again',
                onAction: () {},
                faceLabel: 'Sad face',
              ),
            ],
          ),
          GallerySection(
            title: 'Secondary action',
            children: [
              BaseErrorState(
                title: 'Chat is unavailable',
                text: 'Try again later.',
                isSecondaryAction: true,
                actionText: 'Back',
                onAction: () {},
              ),
            ],
          ),
        ],
      ),
    ),
  ],
);
