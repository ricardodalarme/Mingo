import 'dart:async';

import 'package:app/features/app/presentation/cubit/app_cubit.dart';
import 'package:app/infrastructure/initializers/authentication_initializer.dart';
import 'package:app/infrastructure/initializers/bloc_initializer.dart';
import 'package:app/infrastructure/initializers/preferences_initializer.dart';
import 'package:app/infrastructure/initializers/query_store_initializer.dart';
import 'package:core/core.dart';
import 'package:logger/logger.dart';

final class AppCubitInitializer() extends Initializer {
  static final Logger _logger = Logger('AppCubitInitializer');

  @override
  List<Type> get dependencies => const [
    PreferencesInitializer,
    AuthenticationInitializer,
    BlocInitializer,
    QueryStoreInitializer,
  ];

  @override
  void initialize() {
    _logger.info('Initializing App Cubit');

    unawaited(AppInjector.instance.get<AppCubit>().initialize());
  }
}
