import 'package:connectivity/connectivity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:package_info/package_info.dart';

import 'package:diet_driven/blocs/blocs.dart';
import 'package:diet_driven/models/models.dart';
import 'package:diet_driven/repositories/repositories.dart';

import '../test_utils.dart';

void main() {
  ConfigurationBloc configurationBloc;
  
  /// Mocks
  ConfigurationRepository configurationRepository;

  /// Data
  final defaultConfig = RemoteConfiguration();
  final remoteConfig = RemoteConfiguration((b) => b
    ..liveConfiguration = true
    ..bonus = 35
  );

  final packageInfo = PackageInfo(
    appName: "Diet Driven",
    packageName : "diet_driven",
    version : "1.2.3",
    buildNumber : "14",
  );

  final connectivityList = [
    ConnectivityResult.wifi,
    ConnectivityResult.none,
    ConnectivityResult.mobile,
  ];

  /// Configuration
  setUp(() {
    configurationRepository = MockConfigurationRepository();
    configurationBloc = ConfigurationBloc(configurationRepository: configurationRepository);
  });

  tearDown(() {
    configurationBloc?.dispose();
  });

  /// Tests
  test("Initialize properly", () {
    expect(configurationBloc.initialState, ConfigurationUninitialized());
  });
  
  test("React to streams", () {
    when(configurationRepository.fetchRemoteConfig()).thenAnswer((_) => Future<RemoteConfiguration>.value(remoteConfig));
    when(configurationRepository.fetchPackageInfo()).thenAnswer((_) => Future<PackageInfo>.value(packageInfo));
    when(configurationRepository.connectivity$()).thenAnswer((_) => Stream<ConnectivityResult>.fromIterable(connectivityList));

    expectLater(
      configurationBloc.state,
      emitsInOrder(<ConfigurationState>[
        ConfigurationUninitialized(),
        for (var conn in connectivityList)
          ConfigurationLoaded((b) => b
            ..remoteConfiguration = remoteConfig.toBuilder()
            ..packageInfo = packageInfo
            ..connectivity = conn
          ),
      ])
    );

    configurationBloc.dispatch(InitConfiguration());
  });

  group("Handle runtime exceptions", () {
    test("Fallback to default remote configuration", () {
      when(configurationRepository.fetchRemoteConfig()).thenAnswer((_) => Future.error(Exception("Remote configuration failed")));
      when(configurationRepository.fetchPackageInfo()).thenAnswer((_) => Future<PackageInfo>.value(packageInfo));
      when(configurationRepository.connectivity$()).thenAnswer((_) => Stream<ConnectivityResult>.fromIterable(connectivityList));

      expectLater(
        configurationBloc.state,
        emitsInOrder(<ConfigurationState>[
          ConfigurationUninitialized(),
          for (var conn in connectivityList)
            ConfigurationLoaded((b) => b
              ..remoteConfiguration = defaultConfig.toBuilder()
              ..packageInfo = packageInfo
              ..connectivity = conn
            ),
        ])
      );

      configurationBloc.dispatch(InitConfiguration());
    });

    test("Show package info error page", () {
      when(configurationRepository.fetchRemoteConfig()).thenAnswer((_) => Future<RemoteConfiguration>.value(remoteConfig));
      when(configurationRepository.fetchPackageInfo()).thenAnswer((_) => Future.error(Exception("Package info failed")));
      when(configurationRepository.connectivity$()).thenAnswer((_) => Stream<ConnectivityResult>.fromIterable(connectivityList));

      expectLater(
        configurationBloc.state,
        emitsInOrder(<dynamic>[ // <ConfigurationState>
          ConfigurationUninitialized(),
          BuiltErrorMatcher("Package info failed"),
        ])
      );

      configurationBloc.dispatch(InitConfiguration());
    });

    test("Show connecitivity error page", () {
      when(configurationRepository.fetchRemoteConfig()).thenAnswer((_) => Future<RemoteConfiguration>.value(remoteConfig));
      when(configurationRepository.fetchPackageInfo()).thenAnswer((_) => Future<PackageInfo>.value(packageInfo));
      when(configurationRepository.connectivity$()).thenAnswer((_) => Stream<ConnectivityResult>.fromFuture(Future.error(Exception("Connectivity failed"))));
      // OPTIMIZE: dart 2.4.? Stream.error in future release
      //  https://github.com/dart-lang/sdk/blob/master/CHANGELOG.md#dartasync

      expectLater(
          configurationBloc.state,
          emitsInOrder(<dynamic>[ // <ConfigurationState>
            ConfigurationUninitialized(),
            BuiltErrorMatcher("Connectivity failed"),
          ])
      );

      configurationBloc.dispatch(InitConfiguration());
    });
  });
}

