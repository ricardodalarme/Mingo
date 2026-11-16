import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

const _levels = <double>[.2, .5, .8, .4, .9, .6, .3, .7, .5, .2, .6, .8, .4, .3];

final WidgetbookNode voiceExample = WidgetbookComponent(
  name: 'BaseVoiceRecorder and BaseVoicePlayer',
  useCases: <WidgetbookUseCase>[
    WidgetbookUseCase(
      name: 'Recorder',
      builder: (context) {
        final status = context.knobs.object.dropdown<BaseVoiceStatus>(
          label: 'Status',
          options: BaseVoiceStatus.values,
          initialOption: BaseVoiceStatus.recording,
          labelBuilder: (value) => value.name,
        );
        final seconds = context.knobs.int.slider(label: 'Elapsed (s)', initialValue: 12, max: 30);

        return GalleryPage(
          title: 'Voice recorder',
          children: <Widget>[
            BaseVoiceRecorder(
              status: status,
              elapsed: Duration(seconds: seconds),
              maxDuration: const Duration(seconds: 30),
              levels: _levels,
              errorText: status == BaseVoiceStatus.failed
                  ? 'Não foi possível enviar. Tente de novo.'
                  : null,
              onRecord: () {},
              onStop: () {},
              onCancel: () {},
              onSend: () {},
              onRerecord: () {},
            ),
          ],
        );
      },
    ),
    WidgetbookUseCase(
      name: 'Player',
      builder: (context) {
        final progress = context.knobs.double.slider(label: 'Progress', initialValue: .4, max: 1);
        final isPlaying = context.knobs.boolean(label: 'Playing');

        return GalleryPage(
          title: 'Voice player',
          children: <Widget>[
            BaseVoicePlayer(
              duration: const Duration(seconds: 12),
              isPlaying: isPlaying,
              progress: progress,
              onToggle: () {},
              onSeek: (_) {},
            ),
          ],
        );
      },
    ),
  ],
);
