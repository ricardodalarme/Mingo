import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/slips/data/mappers/slip_enum_mapper.dart';
import 'package:app/features/slips/data/models/slip_category.dart';
import 'package:app/features/slips/data/models/slip_kind.dart';
import 'package:app/features/slips/data/models/slip_polarity.dart';
import 'package:app/features/slips/data/models/slip_work_area.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a slip category survives a trip to the remote enum and back', () {
    for (final value in SlipCategory.values) {
      expect(value.toRemote().toModel(), value);
    }
  });
  test('a work area survives a trip to the remote enum and back', () {
    for (final value in SlipWorkArea.values) {
      expect(value.toRemote().toModel(), value);
    }
  });
  test('a slip kind survives a trip to the remote enum and back', () {
    for (final value in SlipKind.values) {
      expect(value.toRemote().toModel(), value);
    }
  });
  test('a polarity survives a trip to the remote enum and back', () {
    for (final value in SlipPolarity.values) {
      expect(value.toRemote().toModel(), value);
    }
  });
  test('an unknown category, area, kind or polarity is left out', () {
    expect(EnumSlipCategory_enum.$unknown.toModel(), isNull);
    expect(EnumWorkArea_enum.$unknown.toModel(), isNull);
    expect(EnumSlipKind_enum.$unknown.toModel(), isNull);
    expect(EnumSlipPolarity_enum.$unknown.toModel(), isNull);
  });

  test('the two-word kind is sent with the stored spelling', () {
    expect(EnumSlipKind_enum.if_then.toJson(), 'if_then');
    expect(SlipKind.ifThen.toRemote(), EnumSlipKind_enum.if_then);
  });
}
