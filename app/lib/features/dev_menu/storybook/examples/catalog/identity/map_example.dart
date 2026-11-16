import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode mapExample = WidgetbookComponent(
  name: 'BaseMap',
  useCases: <WidgetbookUseCase>[
    WidgetbookUseCase(
      name: 'Preview with markers and route',
      builder: (context) => GalleryPage(
        title: 'Map',
        children: <Widget>[
          BaseMap(
            semanticLabel: 'Dois lugares, 12 km de distância',
            attribution: '© Provedor do mapa',
            onTap: () => BaseToast.show(context, 'Open full screen'),
            markers: <BaseMapMarker>[
              BaseMapMarker.person(position: const Alignment(-.6, .4), initials: 'R'),
              const BaseMapMarker.pin(position: Alignment(.6, -.3)),
            ],
            route: const <Alignment>[Alignment(-.6, .4), Alignment(.6, -.3)],
          ),
        ],
      ),
    ),
    WidgetbookUseCase(
      name: 'States',
      builder: (context) {
        final status = context.knobs.object.dropdown<BaseMapStatus>(
          label: 'Status',
          options: BaseMapStatus.values,
          initialOption: BaseMapStatus.offline,
          labelBuilder: (value) => value.name,
        );

        return GalleryPage(
          title: 'Map states',
          children: <Widget>[
            BaseMap(
              status: status,
              onAllowLocation: () => BaseToast.show(context, 'Open permission'),
            ),
            const SizedBox(height: AppSpace.s16),
            const BaseMap(status: BaseMapStatus.loading),
            const SizedBox(height: AppSpace.s16),
            BaseMap(status: BaseMapStatus.locationDenied, onAllowLocation: () {}),
          ],
        );
      },
    ),
  ],
);
