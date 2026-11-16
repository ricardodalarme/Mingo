import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode bubbleExample = WidgetbookComponent(
  name: 'BaseBubble',
  useCases: <WidgetbookUseCase>[
    WidgetbookUseCase(
      name: 'Own, other, typing and time',
      builder: (context) => const GalleryPage(
        title: 'Message bubble',
        children: <Widget>[
          GallerySurface(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: AppSpace.s8,
              children: <Widget>[
                BaseBubble(
                  variant: BaseBubbleVariant.own,
                  text: 'Quer jantar fora hoje?',
                  time: '18:42',
                ),
                BaseBubble(text: 'Quero! Pode ser aquele de sempre.', time: '18:44'),
                BaseBubble(variant: BaseBubbleVariant.typing),
              ],
            ),
          ),
        ],
      ),
    ),
    WidgetbookUseCase(
      name: 'Sending and send error',
      builder: (context) => GalleryPage(
        title: 'Message states',
        children: <Widget>[
          GallerySurface(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: AppSpace.s8,
              children: <Widget>[
                const BaseBubble(
                  variant: BaseBubbleVariant.own,
                  text: 'Chego em dez minutos.',
                  isSending: true,
                ),
                BaseBubble(
                  variant: BaseBubbleVariant.failure,
                  text: 'Não foi possível enviar esta mensagem.',
                  onRetry: () => BaseToast.show(context, 'Retry'),
                ),
                BaseBubble(
                  text: 'A resposta foi interrompida.',
                  isFailed: true,
                  onRetry: () => BaseToast.show(context, 'Retry'),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    WidgetbookUseCase(
      name: 'Long text (max width 84%)',
      builder: (context) => GalleryPage(
        title: 'Long messages',
        children: <Widget>[
          GallerySurface(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: AppSpace.s8,
              children: <Widget>[
                BaseBubble(
                  variant: BaseBubbleVariant.own,
                  text: context.knobs.string(
                    label: 'Own text',
                    initialValue: 'Hoje eu percebi que você deixou a luz acesa para mim e isso fez toda a diferença no meu dia, de verdade.',
                  ),
                  time: '21:04',
                ),
                const BaseBubble(
                  text: 'Pessoa_com_um_nome_extremamente_longo_sem_espacos_para_quebrar_linha_nenhuma',
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ],
);
