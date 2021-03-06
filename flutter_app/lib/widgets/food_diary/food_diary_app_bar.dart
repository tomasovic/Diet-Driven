/*
 * Copyright (c) 2019. Dennis Krasnov. All rights reserved.
 * Use of this source code is governed by the MIT license that can be found in the LICENSE file.
 */

import 'package:bloc_logging/bloc_logging.dart';
import 'package:deep_link_navigation/deep_link_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:diet_driven/blocs/blocs.dart';
import 'package:diet_driven/navigation/navigation.dart';
import 'package:diet_driven/widgets/food_diary/food_diary.dart';
import 'package:diet_driven/utils/utils.dart';

/// ...
/// Scaffold's appBar field requires a PreferredSizeWidget.
class FoodDiaryAppBar extends PreferredSize {
  final int initialDate;
  final PageController controller;

  static const appBarHeight = Size.fromHeight(kToolbarHeight);

  const FoodDiaryAppBar({Key key, this.initialDate, this.controller}) : super(
    key: key,
    preferredSize: appBarHeight,
    child: null,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodDiaryBloc, FoodDiaryState>(
      // Rebuild only if state changed
      condition: (previous, current) => previous is! FoodDiaryLoaded || current is! FoodDiaryLoaded,
      builder: (BuildContext context, FoodDiaryState foodDiaryState) {
        BlocLogger().ui("Food diary app bar rebuild");

        // Skeleton diary app bar
        if (foodDiaryState is FoodDiaryUninitialized) {
          return AppBar(title: const Text("loading..."));
//              return const SplashPage(); // FIXME: different splash page for diary, without bottom navigation
        }

        // Loading food diary days failed
        if (foodDiaryState is FoodDiaryFailed) {
          // OPTIMIZE: food diary day blocs inherit diary bloc's error state!
          return Container();
//              return ErrorPage(
//                error: foodDiaryState.error.toString(),
//                trace: foodDiaryState.stacktrace.toString()
//              );
        }

        // Food diary is loaded from now on
        assert(foodDiaryState is FoodDiaryLoaded);

        final loadedState = foodDiaryState as FoodDiaryLoaded;

        return PageControllerDate(
          initialPage: initialDate,
          pageController: controller,
          builder: (BuildContext context, int currentDate) {
            if (currentDate == null) {
              return AppBar(
                title: Text(
                  "Loading...",
                  style: Theme.of(context).textTheme.title,
                ),
              );
            }
            return AppBar(
              // Disable to avoid flashing back arrow during deep link navigation
              automaticallyImplyLeading: false,
              title: Text(
                currentDate.relativeString,
                style: Theme.of(context).textTheme.title,
              ),
              actions: <Widget>[
                // HISTORICAL FOOD DIARY DAY
//                if (currentDate - DateTime.now().asInt < -30)
//                  const CircleAvatar(),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  // Doesn't build / fetch data for intermediate pages (but no animation, whatever)
                  onPressed: () async {
                    final datePicked = await showDatePicker(
                      context: context,
                      initialDate: currentDate.asDateTime,
                      firstDate: DateTime(0),
                      lastDate: DateTime(2100),
                    );

                    if (datePicked != null) {
                      print("DATE PICKED IS $datePicked");
                      DeepLinkNavigator.of(context).navigateTo([DiaryDateDL(datePicked.asInt)]);
                      // _controller.animateToPage(currentDaysSinceEpoch(), duration: Duration(milliseconds: 100), curve: Curves.ease),
                    }
                  },
                ),
                Text(
                  currentDate.toString(),
                  style: TextStyle(color: Colors.black),
                ),
              ],
              elevation: 0,
            );
          },
        );
      }
    );
  }
}