import 'package:app/features/dev_menu/storybook/helpers/widgets/face_motion_playground.dart';
import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode facesExample = WidgetbookComponent(
  name: 'Faces',
  useCases: <WidgetbookUseCase>[
    WidgetbookUseCase(
      name: 'Faces',
      builder: (context) {
        const faceLabels = <(FaceKind, String)>[
          (FaceKind.good, 'Good'),
          (FaceKind.affectionate, 'Affectionate'),
          (FaceKind.tired, 'Tired'),
          (FaceKind.tense, 'Tense'),
          (FaceKind.sad, 'Sad'),
          (FaceKind.thinking, 'Thinking'),
          (FaceKind.smile, 'Smile'),
        ];

        final knobs = readFaceKnobs(context);

        return FaceMotionPlayground(
          isReduced: knobs.isReduced,
          builder: (context, popToken) => GalleryPage(
            title: 'Faces',
            children: <Widget>[
              GallerySection(
                title: 'Faces · seven expressions',
                children: <Widget>[
                  Wrap(
                    spacing: AppSpace.s16,
                    runSpacing: AppSpace.s16,
                    children: <Widget>[
                      for (final (kind, label) in faceLabels)
                        GalleryItem(
                          label: label,
                          child: BaseFace(
                            kind: kind,
                            size: knobs.size,
                            semanticLabel: '$label face',
                            motion: knobs.motion,
                            popToken: popToken,
                            tint: knobs.tint,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              GallerySection(
                title: 'Faces · five sizes',
                children: <Widget>[
                  GalleryRow(
                    children: <Widget>[
                      for (final size in FaceSize.values)
                        GalleryItem(
                          label: size.name,
                          child: BaseFace(
                            kind: FaceKind.smile,
                            size: size,
                            motion: knobs.motion,
                            popToken: popToken,
                            tint: knobs.tint,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              GallerySection(
                title: 'Faces · selected',
                children: <Widget>[
                  GalleryRow(
                    children: <Widget>[
                      for (final (kind, _) in faceLabels)
                        BaseFace(
                          kind: kind,
                          size: knobs.size,
                          selected: true,
                          motion: knobs.motion,
                          popToken: popToken,
                          tint: knobs.tint,
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ),
  ],
);
