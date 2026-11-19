/// Turns `mingo://<host>/<path>` into `/<host>/<path>` so the router matches it like any other path.
Uri transformDeepLinkUri(Uri uri) {
  if (uri.scheme != 'mingo') return uri;

  final segments = [
    if (uri.host.isNotEmpty) uri.host,
    ...uri.pathSegments.where((segment) => segment.isNotEmpty),
  ];

  return Uri(
    path: '/${segments.join('/')}',
    queryParameters: uri.queryParameters.isEmpty ? null : uri.queryParameters,
  );
}
