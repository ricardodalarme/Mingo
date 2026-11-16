import 'package:app/features/dev_menu/storybook/examples/catalog/input/calendar_grid_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/input/checkbox_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/input/chip_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/input/choice_chip_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/input/code_field_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/input/compact_calendar_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/input/date_field_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/input/face_selector_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/input/message_bar_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/input/option_tile_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/input/photo_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/input/radio_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/input/segmented_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/input/select_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/input/slider_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/input/switch_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/input/text_area_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/input/text_field_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/input/voice_example.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode inputExamples = WidgetbookFolder(
  name: 'Input',
  children: [
    textAreaExample,
    textFieldExample,
    selectExample,
    choiceChipExample,
    radioExample,
    checkboxExample,
    switchExample,
    sliderExample,
    segmentedExample,
    optionTileExample,
    dateFieldExample,
    calendarGridExample,
    chipExample,
    codeFieldExample,
    compactCalendarExample,
    messageBarExample,
    faceSelectorExample,
    photoExample,
    voiceExample,
  ],
);
