import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode checkboxExample = WidgetbookComponent(
  name: 'Checkbox',
  useCases: [
    WidgetbookUseCase(
      name: 'Off, on, mixed and inside a row',
      builder: (context) => const GalleryPage(
        title: 'Checkbox',
        children: [
          GallerySection(
            title: 'States',
            children: [
              GalleryRow(
                children: [
                  BaseCheckbox(value: false, semanticLabel: 'Off'),
                  BaseCheckbox(value: true, semanticLabel: 'On'),
                  BaseCheckbox(value: false, isIndeterminate: true, semanticLabel: 'Mixed'),
                ],
              ),
            ],
          ),
          GallerySection(
            title: 'Inside a row',
            children: [
              BaseCheckbox(value: true, label: 'Accept the terms'),
              SizedBox(height: AppSpace.s12),
              BaseCheckbox(value: true, isIndeterminate: true, label: 'Some reminders selected'),
            ],
          ),
        ],
      ),
    ),
  ],
);
