import 'package:design_system/src/components/surfaces/base_face.dart';

/// Picks how a face moves when the caller did not choose.
FaceMotion resolveFaceMotion({
  required FaceMotion? motion,
  required bool selected,
  required FaceSize size,
}) {
  if (motion != null) return motion;
  if (selected) return .idle;
  if (size == .showcase) return .enter;

  return .still;
}
