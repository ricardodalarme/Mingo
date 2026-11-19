import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:common_ui/common_ui.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

const List<String> _texts = [
  'Fez café sem eu pedir',
  'Lembrou da minha reunião e perguntou como foi',
  'Ficou comigo até tarde, mesmo cansada, para eu terminar o que precisava e deixou um bilhete na mesa',
  'Buscou o pão',
  'Disse que tem orgulho de mim',
  'Guardou meu lugar',
];

String _label(SlipNoteType type) => switch (type) {
  .good => 'Fez algo',
  .help => 'Me ajudou',
  .notice => 'Me notou',
  .said => 'Disse algo',
  .annoyed => 'Me incomodou',
};

final WidgetbookNode slipNoteExample = WidgetbookComponent(
  name: 'BaseSlipNote',
  useCases: <WidgetbookUseCase>[
    WidgetbookUseCase(
      name: 'One note',
      builder: (context) {
        final type = context.knobs.object.dropdown<SlipNoteType>(
          label: 'Type',
          options: SlipNoteType.values,
          labelBuilder: (value) => value.name,
        );
        final size = context.knobs.object.dropdown<SlipNoteSize>(
          label: 'Size',
          options: SlipNoteSize.values,
          labelBuilder: (value) => value.name,
        );
        final text = context.knobs.string(label: 'Text', initialValue: _texts.first);
        final tilt = context.knobs.double.slider(
          label: 'Tilt',
          initialValue: 1,
          min: -1.8,
          max: 1.8,
        );

        return GalleryPage(
          title: 'Slip note',
          children: <Widget>[
            GallerySurface(
              child: BaseSlipNote(
                text: text,
                type: type,
                typeLabel: _label(type),
                dayLabel: size == .large ? 'Seg 3 de nov' : 'Seg',
                tilt: tilt,
                size: size,
                onTap: () => BaseToast.show(context, 'Open'),
              ),
            ),
          ],
        );
      },
    ),
    WidgetbookUseCase(
      name: 'Every type, both sizes',
      builder: (context) => GalleryPage(
        title: 'Types',
        children: <Widget>[
          for (final size in SlipNoteSize.values)
            GallerySection(
              title: size.name,
              children: <Widget>[
                for (final type in SlipNoteType.values)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpace.s20),
                    child: GallerySurface(
                      width: size == .large ? 350 : 170,
                      child: BaseSlipNote(
                        text: _texts[type.index],
                        type: type,
                        typeLabel: _label(type),
                        dayLabel: size == .large ? 'Seg 3 de nov' : 'Seg',
                        tilt: slipNoteTilt(type.name),
                        size: size,
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    ),
    WidgetbookUseCase(
      name: 'Wall',
      builder: (context) {
        final count = context.knobs.int.slider(label: 'Notes', initialValue: 7, min: 1, max: 40);
        final reduceMotion = context.knobs.boolean(label: 'Reduce motion');

        return MediaQuery(
          data: MediaQuery.of(context).copyWith(disableAnimations: reduceMotion),
          child: ColoredBox(
            color: context.colors.bgScreen,
            child: CustomScrollView(
              key: ValueKey(reduceMotion),
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.all(AppSpace.screenMargin),
                  sliver: SliverWall(
                    itemCount: count + 1,
                    itemBuilder: (context, index) {
                      if (index == count) {
                        return BaseSlipNoteAdd(
                          label: 'Anotar mais um',
                          onTap: () => BaseToast.show(context, 'Add'),
                        );
                      }
                      final type = SlipNoteType.values[index % 4];

                      return BaseSlipNote(
                        text: _texts[index % _texts.length],
                        type: type,
                        typeLabel: _label(type),
                        dayLabel: 'Seg',
                        tilt: slipNoteTilt('note-$index'),
                        animatesEntrance: true,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
    WidgetbookUseCase(
      name: 'Add card',
      builder: (context) => GalleryPage(
        title: 'Wall end',
        children: <Widget>[
          GallerySection(
            title: 'Add card',
            children: <Widget>[
              GallerySurface(
                width: 170,
                child: BaseSlipNoteAdd(
                  label: 'Anotar mais um',
                  onTap: () => BaseToast.show(context, 'Add'),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    WidgetbookUseCase(
      name: 'Editable note',
      builder: (context) {
        final type = context.knobs.object.dropdown<SlipNoteType>(
          label: 'Type',
          options: SlipNoteType.values,
          labelBuilder: (value) => value.name,
        );

        return GalleryPage(
          title: 'Editable note',
          children: <Widget>[
            GallerySurface(
              child: BaseSlipNoteField(
                type: type,
                typeLabel: _label(type),
                hint: 'O que ela fez de bom?',
                tilt: 1,
              ),
            ),
          ],
        );
      },
    ),
    WidgetbookUseCase(
      name: 'Large text scale',
      builder: (context) {
        final scale = context.knobs.double.slider(
          label: 'Text scale',
          initialValue: 2,
          min: 1,
          max: 3,
        );

        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(scale)),
          child: GalleryPage(
            title: 'Text scale',
            children: <Widget>[
              GallerySurface(
                width: 170,
                child: BaseSlipNote(
                  text: _texts[2],
                  type: SlipNoteType.help,
                  typeLabel: _label(SlipNoteType.help),
                  dayLabel: 'Seg',
                  tilt: -1,
                ),
              ),
            ],
          ),
        );
      },
    ),
  ],
);
