import 'dart:ui' as ui;

import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

Future<MemoryImage> _gradientImage() async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  const size = Size(640, 480);
  canvas
    ..drawRect(
      Offset.zero & size,
      Paint()
        ..shader = const LinearGradient(colors: <Color>[AppHue.roseHighlight, AppHue.blueHighlight])
            .createShader(Offset.zero & size),
    )
    ..drawCircle(const Offset(320, 240), 90, Paint()..color = AppPalette.white);
  final image = await recorder.endRecording().toImage(640, 480);
  final data = await image.toByteData(format: ui.ImageByteFormat.png);

  return MemoryImage(data!.buffer.asUint8List());
}

final WidgetbookNode photoExample = WidgetbookComponent(
  name: 'BasePhotoPicker and BasePhotoCropper',
  useCases: <WidgetbookUseCase>[
    WidgetbookUseCase(
      name: 'Source sheet',
      builder: (context) {
        final hasPhoto = context.knobs.boolean(label: 'Has photo');
        final hasCamera = context.knobs.boolean(label: 'Has camera', initialValue: true);

        return GalleryPage(
          title: 'Photo picker',
          children: <Widget>[
            BaseButton.secondary(
              text: 'Mudar foto',
              onPressed: () async {
                final source = await BasePhotoPicker.show(
                  context,
                  hasPhoto: hasPhoto,
                  hasCamera: hasCamera,
                );
                if (context.mounted) {
                  BaseToast.show(context, 'Picked: ${source?.name ?? 'nothing'}');
                }
              },
            ),
          ],
        );
      },
    ),
    WidgetbookUseCase(
      name: 'Cropper',
      builder: (context) => FutureBuilder<MemoryImage>(
        future: _gradientImage(),
        builder: (context, snapshot) {
          final image = snapshot.data;
          if (image == null) return const Center(child: BaseLoadingDots());

          return ColoredBox(
            color: context.colors.bgScreen,
            child: SafeArea(
              child: BasePhotoCropper(
                image: image,
                isSaving: context.knobs.boolean(label: 'Saving'),
                onDone: (bytes) => BaseToast.show(context, 'Cropped ${bytes.length} bytes'),
                onChooseAnother: () => BaseToast.show(context, 'Choose another'),
              ),
            ),
          );
        },
      ),
    ),
  ],
);
