import 'package:app/features/repair/data/data_sources/remote/queries/generated/MyLearnings.graphql.dart';
import 'package:app/features/repair/data/mappers/repair_enum_mapper.dart';
import 'package:app/features/repair/data/models/guided_session.dart';

extension LearningMapper on QueryMyLearningsrepairLearnings {
  Learning toModel() => Learning(id: id, kind: kind.toModel(), note: note, createdAt: createdAt);
}
