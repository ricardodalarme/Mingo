import 'package:app/features/help/data/mappers/support_topic_mapper.dart';
import 'package:app/features/help/data/models/support_topic.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every topic reads back from the label it sends', () {
    for (final topic in SupportTopic.values) {
      expect(topic.toRemote().name, topic.name);
      expect(topic.name.toSupportTopic(), topic);
    }
  });

  test('an unknown stored label reads as other', () {
    expect('not-a-topic'.toSupportTopic(), SupportTopic.other);
  });
}
