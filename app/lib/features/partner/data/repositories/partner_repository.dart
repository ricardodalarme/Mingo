import 'package:app/features/partner/data/data_sources/remote/partner_data_source.dart';
import 'package:app/features/partner/data/mappers/partner_fact_category_mapper.dart';
import 'package:app/features/partner/data/mappers/partner_fact_mapper.dart';
import 'package:app/features/partner/data/models/partner_fact.dart';
import 'package:app/features/partner/data/models/partner_fact_category.dart';

class PartnerRepository({required final PartnerDataSource _dataSource}) {
  Future<List<PartnerFact>> getFacts() async {
    return [for (final node in await _dataSource.getFacts()) node.toModel()];
  }

  /// Saves a private note; the client [id] makes retries safe.
  Future<void> addFact({
    required String id,
    required String label,
    required String value,
    PartnerFactCategory? category,
  }) async {
    await _dataSource.addFact(
      id: id,
      label: label.trim(),
      value: value.trim(),
      category: category?.toRemote(),
    );
  }

  Future<void> deleteFact(String id) async {
    await _dataSource.deleteFact(id);
  }
}
