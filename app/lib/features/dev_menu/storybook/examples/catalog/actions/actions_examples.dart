import 'package:app/features/dev_menu/storybook/examples/catalog/actions/button_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/actions/round_button_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/actions/text_link_example.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode actionsExamples = WidgetbookFolder(
  name: 'Actions',
  children: <WidgetbookNode>[buttonExample, roundButtonExample, textLinkExample],
);
