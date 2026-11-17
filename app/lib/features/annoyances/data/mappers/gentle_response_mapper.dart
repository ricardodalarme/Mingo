import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/annoyances/data/models/gentle_response.dart';

extension GentleResponseMapper on GentleResponse {
  EnumGentleResponse_enum toRemote() => switch (this) {
    GentleResponse.willDo => EnumGentleResponse_enum.will_do,
    GentleResponse.later => EnumGentleResponse_enum.later,
    GentleResponse.notNow => EnumGentleResponse_enum.not_now,
    GentleResponse.talk => EnumGentleResponse_enum.talk,
    GentleResponse.moreTime => EnumGentleResponse_enum.more_time,
  };
}

extension EnumGentleResponseMapper on EnumGentleResponse_enum {
  /// Null for an answer this version does not know, so the request reads as unanswered.
  GentleResponse? toModel() => switch (this) {
    EnumGentleResponse_enum.will_do => GentleResponse.willDo,
    EnumGentleResponse_enum.later => GentleResponse.later,
    EnumGentleResponse_enum.not_now => GentleResponse.notNow,
    EnumGentleResponse_enum.talk => GentleResponse.talk,
    EnumGentleResponse_enum.more_time => GentleResponse.moreTime,
    EnumGentleResponse_enum.$unknown => null,
  };
}
