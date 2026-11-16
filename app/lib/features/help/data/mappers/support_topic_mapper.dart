import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/help/data/models/support_topic.dart';

/// Converts the support topics the app uses into the ones the backend stores.
extension SupportTopicMapper on SupportTopic {
  EnumSupportTopic_enum toRemote() => switch (this) {
    SupportTopic.account => EnumSupportTopic_enum.account,
    SupportTopic.billing => EnumSupportTopic_enum.billing,
    SupportTopic.bug => EnumSupportTopic_enum.bug,
    SupportTopic.other => EnumSupportTopic_enum.other,
  };
}

extension RemoteSupportTopicMapper on String {
  /// The topic for a stored label; an unknown label reads as `other`.
  SupportTopic toSupportTopic() => switch (this) {
    'account' => SupportTopic.account,
    'billing' => SupportTopic.billing,
    'bug' => SupportTopic.bug,
    _ => SupportTopic.other,
  };
}
