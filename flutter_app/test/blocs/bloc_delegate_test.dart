/*
 * Copyright (c) 2019. Dennis Krasnov. All rights reserved.
 * Use of this source code is governed by the MIT license that can be found
 * in the LICENSE file.
 */

import 'package:bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:diet_driven/blocs/blocs.dart';
import 'package:diet_driven/repositories/repositories.dart';

import '../test_utils.dart';

void main() {
  LoggingBlocDelegate sut;

  /// Mocks
  // TODO: mock logging repository

  /// Data
//  NavigationBloc navigationBloc;
  // TODO: pick simplest bloc with easy transitions

  /// Configuration
  setUp(() {
    // repo = mockLoggingRepo()

    // bloc = realBloc();

    sut = LoggingBlocDelegate();

    // ...
    BlocSupervisor.delegate = sut; // TODO: BlocSupervisor.delegate = Logging.blocDelegate !!!! - test in separate library!, follow similar template!
  });
}