import 'package:app/features/dev_menu/storybook/examples/catalog/surfaces/bubble_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/surfaces/carousel_card_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/surfaces/category_label_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/surfaces/divider_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/surfaces/face_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/surfaces/feature_card_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/surfaces/list_card_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/surfaces/slip_note_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/surfaces/surface_card_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/surfaces/tag_example.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode surfacesExamples = WidgetbookFolder(
  name: 'Surfaces',
  children: <WidgetbookNode>[
    featureCardExample,
    listCardExample,
    surfaceCardExample,
    slipNoteExample,
    carouselCardExample,
    tagExample,
    categoryLabelExample,
    faceExample,
    bubbleExample,
    dividerExample,
  ],
);
