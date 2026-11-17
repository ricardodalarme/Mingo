import 'package:app/features/checkin/data/data_sources/remote/checkin_data_source.dart';
import 'package:app/features/checkin/data/models/checkin_answer.dart';

extension CheckinAnswerRecordMapper on CheckinAnswerRecord {
  CheckinAnswer toModel() => CheckinAnswer(id: id, question: question, body: body);
}

extension CheckinAnswerWriteRecordMapper on CheckinAnswerWriteRecord {
  CheckinAnswer toModel() => CheckinAnswer(id: id, question: question, body: body);
}
