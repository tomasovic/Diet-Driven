/*
 * Copyright (c) 2019. Dennis Krasnov. All rights reserved.
 * Use of this source code is governed by the MIT license that can be found in the LICENSE file.
 */

import 'package:bloc/bloc.dart';
import 'package:bloc_logging/bloc_logging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_core/core.dart';

import 'package:diet_driven/blocs/blocs.dart';
import 'package:diet_driven/repositories/repositories.dart';
import 'package:diet_driven/widgets/core/core.dart';

/// Load file's contents from the main asset bundle.
Future<String> loadFileContent(String path) => rootBundle.loadString(path);

Future<void> main() async {
  // Configure logging
  BlocLogger()
    ..messageThreshold = LogLevel.ui
    ..enabled = !kReleaseMode
    ..blocEventsEnabled = false
    ..blocTransitionsEnabled = false;

  // Log every bloc event and state transition
  BlocSupervisor.delegate = LoggingBlocDelegate();

  // Lock to portrait mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Configure SyncFusion license
  // https://help.syncfusion.com/common/essential-studio/licensing/license-key#flutter
  SyncfusionLicense.registerLicense(await loadFileContent("assets/syncfusion.txt"));

  runApp(
    // Inject global repositories into application
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AnalyticsRepository>(create: (context) => AnalyticsRepository()),
        RepositoryProvider<ConfigurationRepository>(create: (context) => ConfigurationRepository()),
        RepositoryProvider<DiaryRepository>(create: (context) => DiaryRepository()),
        RepositoryProvider<FoodRepository>(create: (context) => FoodRepository()),
        RepositoryProvider<SettingsRepository>(create: (context) => SettingsRepository()),
        RepositoryProvider<UserRepository>(create: (context) => UserRepository()),
      ],
      // Inject global blocs into application
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ConfigurationBloc>(create: (context) =>
            ConfigurationBloc(
              configurationRepository: RepositoryProvider.of<ConfigurationRepository>(context),
            )..add(InitConfiguration())
          ),
          BlocProvider<UserDataBloc>(create: (context) =>
            UserDataBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context),
              settingsRepository: RepositoryProvider.of<SettingsRepository>(context),
            )..add(InitUserData())
          ),
          BlocProvider<FoodDiaryBloc>(create: (context) =>
            FoodDiaryBloc(
              diaryRepository: RepositoryProvider.of<DiaryRepository>(context),
            )
          ),
        ],
        child: App(),
      ),
    ),
  );
}