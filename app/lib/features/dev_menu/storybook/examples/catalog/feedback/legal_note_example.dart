import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode legalNoteExample = WidgetbookComponent(
  name: 'BaseLegalNote',
  useCases: <WidgetbookUseCase>[
    WidgetbookUseCase(
      name: 'Under the primary action',
      builder: (context) => GalleryPage(
        title: 'Inline note, legal text',
        children: <Widget>[
          BaseButton.primary(text: 'Continuar', onPressed: () {}),
          BaseLegalNote(
            text: 'Ao continuar, você concorda com os {} e com a {}.',
            links: <BaseLegalLink>[
              BaseLegalLink(text: 'Termos', onTap: () => BaseToast.show(context, 'Terms')),
              BaseLegalLink(
                text: 'Política de Privacidade',
                onTap: () => BaseToast.show(context, 'Privacy'),
              ),
            ],
          ),
          const SizedBox(height: AppSpace.s24),
          BaseLegalNote(
            text: 'By continuing you agree to the {} and the {}.',
            links: <BaseLegalLink>[
              BaseLegalLink(text: 'Terms', onTap: () {}),
              BaseLegalLink(text: 'Privacy Policy', onTap: () {}),
            ],
          ),
        ],
      ),
    ),
  ],
);
