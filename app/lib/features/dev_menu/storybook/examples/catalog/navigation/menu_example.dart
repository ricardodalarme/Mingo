import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

const _slip = BaseMenuItem(
  id: 'slip',
  icon: AppIcons.pencil,
  label: 'Anotar um slip',
  isPrimary: true,
);
const _need = BaseMenuItem(id: 'need', icon: AppIcons.heart, label: 'Preciso de…');
const _note = BaseMenuItem(id: 'note', icon: AppIcons.send, label: 'Mandar um recado');
const _memory = BaseMenuItem(id: 'memory', icon: AppIcons.bookmark, label: 'Guardar uma memória');

final WidgetbookNode menuExample = WidgetbookComponent(
  name: 'BaseMenu',
  useCases: <WidgetbookUseCase>[
    WidgetbookUseCase(
      name: 'Two items',
      builder: (context) => const _MenuDemo(items: [_slip, _need]),
    ),
    WidgetbookUseCase(
      name: 'Three items',
      builder: (context) => const _MenuDemo(items: [_slip, _need, _note]),
    ),
    WidgetbookUseCase(
      name: 'Four items',
      builder: (context) => const _MenuDemo(items: [_slip, _need, _note, _memory]),
    ),
    WidgetbookUseCase(
      name: 'Large text',
      builder: (context) => const _MenuDemo(items: [_slip, _need, _note, _memory], textScale: 2),
    ),
  ],
);

class const _MenuDemo({required final List<BaseMenuItem> items, final double textScale = 1})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(textScale)),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: AppSpace.s44),
          child: Builder(
            builder: (buttonContext) => BaseRoundButton(
              icon: AppIcons.plus,
              semanticLabel: 'Open the menu',
              onPressed: () {
                final box = buttonContext.findRenderObject()! as RenderBox;
                showBaseMenu(
                  buttonContext,
                  anchor: box.localToGlobal(Offset.zero) & box.size,
                  items: items,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
