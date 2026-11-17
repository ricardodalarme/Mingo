import 'dart:async';

import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/infrastructure/initializers/authentication_initializer.dart';
import 'package:core/core.dart';
import 'package:logger/logger.dart';
import 'package:network/network.dart';

/// Drops the cached query results when the person signs out, so the next sign-in starts clean.
final class QueryCacheInitializer({
  final GQLClient? gqlClient,
  final AuthenticationRepository? authenticationRepository,
}) extends Initializer {
  static final Logger _logger = Logger('QueryCacheInitializer');

  @override
  List<Type> get dependencies => const [AuthenticationInitializer];

  @override
  void initialize() {
    _logger.info('Clearing the query cache on sign-out');

    final client = gqlClient ?? AppInjector.instance.get<GQLClient>();
    final repository =
        authenticationRepository ?? AppInjector.instance.get<AuthenticationRepository>();
    unawaited(
      repository.isAuthenticatedStream
          .where((isAuthenticated) => !isAuthenticated)
          .forEach((_) => client.resetCache()),
    );
  }
}
