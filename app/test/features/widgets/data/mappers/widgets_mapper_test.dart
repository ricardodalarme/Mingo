import 'package:app/features/widgets/data/data_sources/remote/queries/generated/WidgetOverview.graphql.dart';
import 'package:app/features/widgets/data/mappers/widgets_mapper.dart';
import 'package:app/features/widgets/data/models/widget_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime.utc(2026, 11, 11, 12);

  QueryWidgetOverview response({Map<String, dynamic>? mySettings}) =>
      QueryWidgetOverview.fromJson(<String, dynamic>{
        'widget': <String, dynamic>{
          'nodeId': 'widget-1',
          'isPaired': true,
          'partnerName': 'Marina',
          'nextDateTitle': 'Aniversário',
          'nextDateOn': '2026-12-01',
          'unopenedCards': 0,
          '__typename': 'WidgetState',
        },
        'today': <String, dynamic>{
          'nodeId': 'today-1',
          'isPaired': true,
          'hasPlus': true,
          'partnerName': 'Redacted',
          'nextDateTitle': 'Redacted',
          'nextDateOn': '2099-01-01',
          '__typename': 'TodayState',
        },
        'mySettings':
            mySettings ??
            <String, dynamic>{
              'nodeId': 'settings-1',
              'profileId': 'profile-1',
              'partnerName': 'Redacted',
              'widgetAllowPartnerNotes': true,
              'widgetOnLockScreen': false,
              'widgetShowNames': true,
              '__typename': 'ProfileSettings',
            },
        'ritualsCollection': <String, dynamic>{
          'edges': <dynamic>[],
          '__typename': 'RitualsConnection',
        },
        'moodsCollection': <String, dynamic>{'edges': <dynamic>[], '__typename': 'MoodsConnection'},
        '__typename': 'Query',
      });

  WidgetOverview map(QueryWidgetOverview value) => value.toModel(
    contentSource: WidgetContentSource.favorites,
    rotationCadence: WidgetRotationCadence.daily,
    now: now,
  );

  test('partner name and date come only from the widget state', () {
    final overview = map(response());

    expect(overview.payload.partnerName, 'Marina');
    expect(overview.payload.nextDateTitle, 'Aniversário');
  });

  test('missing settings fail closed for names and notes', () {
    final overview =
        QueryWidgetOverview.fromJson(<String, dynamic>{
          'widget': <String, dynamic>{
            'nodeId': 'widget-1',
            'isPaired': true,
            'partnerName': 'Marina',
            '__typename': 'WidgetState',
          },
          'today': <String, dynamic>{
            'nodeId': 'today-1',
            'isPaired': true,
            'hasPlus': true,
            '__typename': 'TodayState',
          },
          'ritualsCollection': <String, dynamic>{
            'edges': <dynamic>[],
            '__typename': 'RitualsConnection',
          },
          'moodsCollection': <String, dynamic>{
            'edges': <dynamic>[],
            '__typename': 'MoodsConnection',
          },
          '__typename': 'Query',
        }).toModel(
          contentSource: WidgetContentSource.favorites,
          rotationCadence: WidgetRotationCadence.daily,
          now: now,
        );

    expect(overview.preferences.showNames, isFalse);
    expect(overview.preferences.allowPartnerNotes, isFalse);
    expect(overview.payload.partnerName, isNull);
  });
}
