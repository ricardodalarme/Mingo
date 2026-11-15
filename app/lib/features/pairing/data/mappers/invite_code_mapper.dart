/// The invite code carried by [uri], upper-cased, or null when it is not an invite link.
///
/// Accepts `mingo://invite/<code>`, `mingo://invite?code=<code>` and an
/// `https://<host>/invite/<code>` (or `?code=`) link.
String? inviteCodeFromUri(Uri uri) {
  final segments = <String>[
    if (uri.host.trim().isNotEmpty) uri.host.trim().toLowerCase(),
    for (final segment in uri.pathSegments)
      if (segment.trim().isNotEmpty) segment.trim().toLowerCase(),
  ];
  final inviteIndex = segments.indexOf('invite');
  if (inviteIndex == -1) return null;

  final pathCode = inviteIndex + 1 < segments.length ? segments[inviteIndex + 1] : null;
  final code = (pathCode ?? uri.queryParameters['code'])
      ?.replaceAll(RegExp(r'\s'), '')
      .toUpperCase();

  return code == null || code.isEmpty ? null : code;
}
