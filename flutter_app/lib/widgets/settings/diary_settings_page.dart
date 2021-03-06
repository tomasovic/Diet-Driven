/*
 * Copyright (c) 2019. Dennis Krasnov. All rights reserved.
 * Use of this source code is governed by the MIT license that can be found in the LICENSE file.
 */

import 'package:built_collection/built_collection.dart';

import 'package:diet_driven/blocs/blocs.dart';
import 'package:diet_driven/models/models.dart';
import 'package:diet_driven/widgets/completer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import 'package:diet_driven/providers/cloud_functions.dart'; // FIXME

//class DiarySettingsPage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return BlocBuilder<UserDataBloc, UserDataState>(
//      builder: (BuildContext context, UserDataState userDataState) {
//        return Scaffold(
//          appBar: AppBar(
//            title: const Text("Diary Settings"),
//            actions: <Widget>[
//              IconButton(
//                icon: const Icon(Icons.swap_horiz),
//                onPressed: () => BlocProvider.of<NavigationBloc>(context).dispatch(Navigate((b) => b
//                  ..page = Page.diary
//                )),
//              )
//            ],
//          ),
//          body: SafeArea(
//            child: Container(
//              child: Column(
//                children: <Widget>[
//                  RaisedButton(
//                    child: const Text("jump to theme settings"),
//                    onPressed: () => BlocProvider.of<NavigationBloc>(context).dispatch(Navigate((b) => b
//                      ..page = Page.settings
//                      ..deepLinks = ListBuilder(<DeepLink>[SettingsDeepLink(), ThemeSettingsDeepLink()])
//                    )),
//                  ),
//                  RaisedButton(
//                    child: const Text("jump to diary 200"),
//                    onPressed: () => BlocProvider.of<NavigationBloc>(context).dispatch(Navigate((b) => b
//                      ..page = Page.diary
//                      ..deepLinks = ListBuilder(<DeepLink>[DiaryDeepLink((b) => b
//                        ..date = 200
//                      )])
//                    )),
//                  ),
//                ],
//              ),
////                child: const Text("try out cloud function!"),
////                onPressed: () => CloudFunctionsProvider().searchFoodsByQuery("apple"), FIXME
//            ),
//          )
//        );
//      }
//    );
//  }
//}
