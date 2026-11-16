import 'package:app/features/annoyances/data/models/gentle_response.dart';

/// The stored spelling of each answer, as the server keeps it.
extension GentleResponseMapper on GentleResponse {
  String toRemote() => switch (this) {
    GentleResponse.willDo => 'will_do',
    GentleResponse.later => 'later',
    GentleResponse.notNow => 'not_now',
    GentleResponse.talk => 'talk',
    GentleResponse.moreTime => 'more_time',
  };
}

extension GentleResponseNameMapper on String {
  /// Null for an answer this version does not know.
  GentleResponse? toGentleResponse() => switch (this) {
    'will_do' => GentleResponse.willDo,
    'later' => GentleResponse.later,
    'not_now' => GentleResponse.notNow,
    'talk' => GentleResponse.talk,
    'more_time' => GentleResponse.moreTime,
    _ => null,
  };
}
