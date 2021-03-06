/*
 * Copyright (c) 2019. Dennis Krasnov. All rights reserved.
 * Use of this source code is governed by the MIT license that can be found in the LICENSE file.
 */

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_logging/bloc_logging.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:diet_driven/blocs/configuration/configuration.dart';
import 'package:diet_driven/models/models.dart';
import 'package:diet_driven/repositories/repositories.dart';

/// Aggregates and manages app-wide runtime configuration.
class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigurationState> {
  final ConfigurationRepository configurationRepository;

  ConfigurationLoaded get loadedState => state as ConfigurationLoaded;

  StreamSubscription<ConfigurationEvent> _configurationEventSubscription;

  ConfigurationBloc({@required this.configurationRepository}) : assert(configurationRepository != null);

  @override
  ConfigurationState get initialState => ConfigurationUninitialized();

  @override
  Future<void> close() {
    _configurationEventSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<ConfigurationState> mapEventToState(ConfigurationEvent event) async* {
    if (event is InitConfiguration) {
      // Maintain single instance of stream subscription
      await _configurationEventSubscription?.cancel();
      _configurationEventSubscription = CombineLatestStream.combine3<RemoteConfiguration, PackageInformation, ConnectivityStatus, ConfigurationEvent>(
        configurationRepository.fetchRemoteConfig().asStream()
          .doOnError((Object error, StackTrace stacktrace) => BlocLogger().expectedError("Default configuration used", error, stacktrace))
          .onErrorReturn(RemoteConfiguration()),
        configurationRepository.fetchPackageInfo().asStream(),
        // FIXME: start with needed on ios for some reason... .startWith(ConnectivityStatus.disconnected).doOnData(print),
        configurationRepository.connectivity$(),
        (remoteConfiguration, packageInfo, connectivity) => IngressConfigurationArrived((b) => b
          ..remoteConfiguration = remoteConfiguration.toBuilder()
          ..packageInfo = packageInfo.toBuilder()
          ..connectivity = connectivity
        ),
      )
      // Unrecoverable failure
      .onErrorReturnWith((dynamic error) => ConfigurationError((b) => b..error = error))
      .distinct()
      .listen(add);
    }

    if (event is IngressConfigurationArrived) {
      yield ConfigurationLoaded((b) => b
        ..remoteConfiguration = event.remoteConfiguration.toBuilder()
        ..packageInfo = event.packageInfo.toBuilder()
        ..connectivity = event.connectivity
      );

      BlocLogger().info("Configuration loaded");
    }

    if (event is ConfigurationError) {
      yield ConfigurationFailed((b) => b
        ..error = event.error
        ..stacktrace = event.stacktrace
      );

      BlocLogger().unexpectedError("Configuration failed", event.error, event.stacktrace);
    }
  }
}
