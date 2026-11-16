import 'dart:async';

import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode stepperExample = WidgetbookComponent(
  name: 'BaseStepper',
  useCases: <WidgetbookUseCase>[
    WidgetbookUseCase(
      name: 'Step bars',
      builder: (context) => const GalleryPage(
        title: 'Step indicator',
        children: <Widget>[
          GalleryItem(label: 'Step 1 of 3', child: BaseStepper(count: 3, currentIndex: 0)),
          SizedBox(height: AppSpace.s16),
          GalleryItem(label: 'Step 3 of 5', child: BaseStepper(count: 5, currentIndex: 2)),
        ],
      ),
    ),
    WidgetbookUseCase(
      name: 'Continuous · story progress',
      builder: (context) {
        final index = context.knobs.int.slider(label: 'Part', initialValue: 1, max: 2);
        final progress = context.knobs.double.slider(label: 'Progress', initialValue: .5, max: 1);

        return GalleryPage(
          title: 'Story progress',
          children: <Widget>[
            GalleryItem(
              label: 'Part ${index + 1} of 3',
              child: BaseStepper.continuous(count: 3, currentIndex: index, progress: progress),
            ),
            const SizedBox(height: AppSpace.s20),
            const GalleryItem(label: 'Timed, plays by itself', child: _TimedStory()),
          ],
        );
      },
    ),
  ],
);

class const _TimedStory() extends StatefulWidget {
  @override
  State<_TimedStory> createState() => _TimedStoryState();
}

class _TimedStoryState() extends State<_TimedStory> {
  Timer? _timer;
  int _tick = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (mounted) setState(() => _tick = (_tick + 1) % 150);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseStepper.continuous(count: 3, currentIndex: _tick ~/ 50, progress: (_tick % 50) / 50);
  }
}
