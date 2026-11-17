import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode emptyStateExample = WidgetbookComponent(
  name: 'Empty state',
  useCases: [
    WidgetbookUseCase(
      name: 'Primary and secondary action',
      builder: (context) => GalleryPage(
        title: 'Empty state',
        children: [
          GallerySection(
            title: 'Primary action',
            children: [
              BaseEmptyState(
                title: 'No slips yet',
                text: 'A slip is one good thing, in a single line.',
                actionText: 'Write a slip',
                onAction: () {},
                faceLabel: 'Smile face',
              ),
            ],
          ),
          GallerySection(
            title: 'Secondary action',
            children: [
              BaseEmptyState(
                title: 'No memories yet',
                text: 'They appear after your first card.',
                isSecondaryAction: true,
                actionText: 'See how it works',
                onAction: () {},
              ),
            ],
          ),
        ],
      ),
    ),
  ],
);
