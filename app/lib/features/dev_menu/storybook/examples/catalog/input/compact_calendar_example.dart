import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode compactCalendarExample = WidgetbookComponent(
  name: 'BaseCompactCalendar',
  useCases: <WidgetbookUseCase>[
    WidgetbookUseCase(
      name: 'Marked days and a face marker',
      builder: (context) {
        final monday = context.knobs.boolean(label: 'Week starts on Monday');
        final marked = <DateTime>{
          DateTime(2026, 11, 2),
          DateTime(2026, 11, 3),
          DateTime(2026, 11, 7),
          DateTime(2026, 11, 12),
        };

        return GalleryPage(
          title: 'Calendar grid, compact month',
          children: <Widget>[
            GallerySurface(
              child: BaseCompactCalendar(
                month: DateTime(2026, 11),
                today: DateTime(2026, 11, 12),
                marked: marked,
                weekStart: monday ? BaseCalendarWeekStart.monday : BaseCalendarWeekStart.sunday,
                onDayTap: (day) => BaseToast.show(context, '${day.day}/${day.month}'),
              ),
            ),
            const SizedBox(height: AppSpace.s20),
            GallerySurface(
              child: BaseCompactCalendar(
                month: DateTime(2026, 11),
                marked: marked,
                markerBuilder: (_) => const BaseFace(kind: FaceKind.good, size: FaceSize.small),
              ),
            ),
            const SizedBox(height: AppSpace.s20),
            GallerySurface(child: BaseCompactCalendar(month: DateTime(2026, 2))),
          ],
        );
      },
    ),
  ],
);
