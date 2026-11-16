import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode codeFieldExample = WidgetbookComponent(
  name: 'BaseCodeField',
  useCases: <WidgetbookUseCase>[
    WidgetbookUseCase(
      name: 'Grouped code',
      builder: (context) {
        final error = context.knobs.stringOrNull(label: 'Error');

        return GalleryPage(
          title: 'Code field',
          children: <Widget>[
            BaseCodeField(
              errorText: error,
              isChecking: context.knobs.boolean(label: 'Checking'),
              isSuccess: context.knobs.boolean(label: 'Success'),
              onCompleted: (value) => BaseToast.show(context, 'Completed: $value'),
            ),
            const SizedBox(height: AppSpace.s20),
            const BaseCodeField(text: 'k7m29qxa'),
            const SizedBox(height: AppSpace.s20),
            const BaseCodeField(errorText: 'Esse código não existe. Confira e tente de novo.'),
          ],
        );
      },
    ),
    WidgetbookUseCase(
      name: 'PIN',
      builder: (context) => const GalleryPage(
        title: 'PIN',
        children: <Widget>[
          BaseCodeField(kind: BaseCodeKind.pin, length: 4),
          SizedBox(height: AppSpace.s20),
          BaseCodeField(kind: BaseCodeKind.pin, length: 6, text: '123'),
        ],
      ),
    ),
  ],
);
