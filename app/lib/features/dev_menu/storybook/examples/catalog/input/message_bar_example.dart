import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode messageBarExample = WidgetbookComponent(
  name: 'BaseMessageBar',
  useCases: <WidgetbookUseCase>[
    WidgetbookUseCase(
      name: 'Empty, typing and sending',
      builder: (context) => GalleryPage(
        title: 'Message bar',
        children: <Widget>[
          BaseMessageBar(
            hint: 'Escreva uma mensagem',
            isSending: context.knobs.boolean(label: 'Sending'),
            leading: BaseRoundButton(
              icon: AppIcons.plus,
              onPressed: () {},
              semanticLabel: 'Anexar',
            ),
            onSend: (value) => BaseToast.show(context, 'Sent: $value'),
          ),
          const SizedBox(height: AppSpace.s20),
          BaseMessageBar(hint: 'Escreva uma mensagem', onSend: (_) {}),
        ],
      ),
    ),
    WidgetbookUseCase(
      name: 'Blocked and offline',
      builder: (context) => GalleryPage(
        title: 'Message bar, blocked',
        children: <Widget>[
          BaseMessageBar(isEnabled: false, hint: 'Limite de hoje atingido', onSend: (_) {}),
          const SizedBox(height: AppSpace.s20),
          BaseMessageBar(isEnabled: false, hint: 'Sem conexão', onSend: (_) {}),
        ],
      ),
    ),
  ],
);
