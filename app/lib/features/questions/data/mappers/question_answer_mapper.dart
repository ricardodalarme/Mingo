import 'package:app/features/questions/data/data_sources/remote/questions_data_source.dart';
import 'package:app/features/questions/data/models/question_thread.dart';

extension QuestionAnswerMapper on QuestionAnswerWriteRecord {
  QuestionAnswer toModel() => QuestionAnswer(id: id, body: body);
}

extension QuestionAnswerRecordMapper on QuestionAnswerRecord {
  QuestionAnswer toModel() => QuestionAnswer(id: id, body: body);
}
