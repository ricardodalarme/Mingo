import 'package:app/features/questions/data/data_sources/remote/questions_data_source.dart';
import 'package:app/features/questions/data/models/question_thread.dart';

extension QuestionPromptMapper on QuestionPromptRecord {
  QuestionPrompt toModel() => QuestionPrompt(
    slug: slug,
    title: title,
    body: body,
    tags: tags,
    isPaired: isPaired,
    partnerName: partnerName,
    coupleId: coupleId,
    selfId: selfId,
  );
}
