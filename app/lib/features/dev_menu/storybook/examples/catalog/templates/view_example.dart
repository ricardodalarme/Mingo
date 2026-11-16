import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode viewExample = WidgetbookComponent(
  name: 'BaseView slots',
  useCases: <WidgetbookUseCase>[
    WidgetbookUseCase(
      name: 'App bar, notice, body and footer',
      builder: (context) => BaseView(
        appBar: const BaseAppBar(title: 'Detalhe'),
        notice: const BaseBanner(
          text: 'Notificações desligadas. Ative para receber o cartão.',
          variant: BaseBannerVariant.warning,
        ),
        footer: Column(
          spacing: AppSpace.s10,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            BaseButton.primary(text: 'Salvar', onPressed: () {}),
            BaseButton.text(text: 'Agora não', onPressed: () {}),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.screenMargin),
          children: <Widget>[
            for (var index = 0; index < 8; index++)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpace.cardGap),
                child: BaseSurfaceCard(
                  title: 'Cartão ${index + 1}',
                  supportText: 'Conteúdo que rola sob a barra.',
                ),
              ),
          ],
        ),
      ),
    ),
  ],
);
