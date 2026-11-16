import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

const _mood = <BaseFaceOption>[
  BaseFaceOption(kind: FaceKind.good, label: 'Bem'),
  BaseFaceOption(kind: FaceKind.affectionate, label: 'Carinho'),
  BaseFaceOption(kind: FaceKind.tired, label: 'Cansado'),
  BaseFaceOption(kind: FaceKind.tense, label: 'Tenso'),
  BaseFaceOption(kind: FaceKind.sad, label: 'Triste'),
];

const _reactions = <BaseFaceOption>[
  BaseFaceOption(kind: FaceKind.affectionate),
  BaseFaceOption(kind: FaceKind.smile),
  BaseFaceOption(kind: FaceKind.thinking),
];

final WidgetbookNode faceSelectorExample = WidgetbookComponent(
  name: 'BaseFaceSelector',
  useCases: <WidgetbookUseCase>[
    WidgetbookUseCase(
      name: 'Labeled and unlabeled',
      builder: (context) => const GalleryPage(
        title: 'Face selector',
        children: <Widget>[
          _Selector(options: _mood),
          SizedBox(height: AppSpace.s24),
          _Selector(options: _reactions, isLabeled: false),
        ],
      ),
    ),
    WidgetbookUseCase(
      name: 'Disabled and required',
      builder: (context) => GalleryPage(
        title: 'Face selector, states',
        children: <Widget>[
          BaseFaceSelector(
            options: _mood,
            value: FaceKind.tired,
            onChanged: (_) {},
            isEnabled: false,
          ),
          const SizedBox(height: AppSpace.s24),
          const _Selector(options: _mood, allowClear: false),
        ],
      ),
    ),
  ],
);

class const _Selector({
  required final List<BaseFaceOption> options,
  final bool isLabeled = true,
  final bool allowClear = true,
}) extends StatefulWidget {
  @override
  State<_Selector> createState() => _SelectorState();
}

class _SelectorState() extends State<_Selector> {
  FaceKind? _value;

  @override
  Widget build(BuildContext context) {
    return BaseFaceSelector(
      options: widget.options,
      value: _value,
      isLabeled: widget.isLabeled,
      allowClear: widget.allowClear,
      onChanged: (value) => setState(() => _value = value),
    );
  }
}
