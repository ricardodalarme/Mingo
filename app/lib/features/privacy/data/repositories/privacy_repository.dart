import 'package:app/features/privacy/data/data_sources/remote/privacy_data_source.dart';
import 'package:app/features/privacy/data/mappers/consent_kind_mapper.dart';
import 'package:app/features/privacy/data/models/consent.dart';

/// Reads the latest consent per kind and records changes.
///
/// Consents are append-only rows: a withdrawal is a new row with `granted` false.
class PrivacyRepository({required final PrivacyDataSource _dataSource}) {
  /// The consent text version this build asks for.
  static const String consentVersion = '1';

  /// Terms are required; the optional ones start off.
  static const Map<ConsentKind, bool> defaults = {
    ConsentKind.terms: true,
    ConsentKind.analytics: false,
    ConsentKind.marketing: false,
    ConsentKind.ai: false,
  };

  Future<Map<ConsentKind, bool>> getConsents() async {
    final rows = await _dataSource.getConsents();
    final latest = {...defaults};
    final seen = <ConsentKind>{};
    for (final row in rows) {
      final kind = row.kind.toModel();
      if (seen.contains(kind)) continue;
      seen.add(kind);
      latest[kind] = row.granted;
    }

    return latest;
  }

  Future<void> setConsent(ConsentKind kind, {required bool granted}) async {
    await _dataSource.grant(kind: kind.toRemote(), granted: granted, version: consentVersion);
  }
}
