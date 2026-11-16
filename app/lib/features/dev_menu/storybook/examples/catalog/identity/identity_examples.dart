import 'package:app/features/dev_menu/storybook/examples/catalog/identity/avatar_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/identity/avatar_pair_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/identity/date_badge_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/identity/icon_tile_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/identity/image_placeholder_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/identity/map_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/identity/plus_badge_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/identity/stat_example.dart';
import 'package:app/features/dev_menu/storybook/examples/catalog/identity/timeline_example.dart';
import 'package:widgetbook/widgetbook.dart';

final WidgetbookNode identityExamples = WidgetbookFolder(
  name: 'Identity',
  children: <WidgetbookNode>[
    avatarExample,
    avatarPairExample,
    iconTileExample,
    plusBadgeExample,
    imagePlaceholderExample,
    dateBadgeExample,
    statExample,
    timelineExample,
    mapExample,
  ],
);
