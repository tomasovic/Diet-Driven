/*
 * Copyright (c) 2019. Dennis Krasnov. All rights reserved.
 * Use of this source code is governed by the MIT license that can be found
 * in the LICENSE file.
 */

import 'package:diet_driven/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      // Avoid firing deep link logic on pops to avoid unnecessary animations.
      condition: (NavigationState previous, NavigationState current) => !current.wasPopped,
      listener: (BuildContext context, NavigationState navigationState) {
        // Settings deep link handler
        if (navigationState is SettingsTab && navigationState.deepLink != null) {
          // Single push with animation
          if (navigationState.wasSinglePush) {
            Navigator.of(context).pushNamed(navigationState.path(Routes.settings), arguments: true);
          }
          // No animation for multiple pushes
          else {
            // Reset to root settings page
            Navigator.of(context).popUntil(ModalRoute.withName(Routes.settings));

            // Push each sublist of deep link
            for (int i = 1; i <= navigationState.deepLink.length; i++) {
              Navigator.of(context).pushNamed(navigationState.path(Routes.settings, until: i), arguments: false);
            }
          }
        }
      },
        // TODO: remove unused bloc builder!?
      child: BlocBuilder<UserDataBloc, UserDataState>(
//        condition: (previous, current) => true,
        builder: (BuildContext context, UserDataState userDataState) {
//          if (userDataState is UserDataLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Settings"),
            ),
            body: SafeArea(
              child: ListView(
                children: <Widget>[
                  SettingsListTile(
//                      iconData: FaRegular(0xf013),
                    iconData: FontAwesomeIcons.gamepad,
                    titleText: "General",
                    subtitleText: "Language, Units, Time",
                    navigationEvent: NavigateToSettings.general(),
                  ),

                  const SettingsListTile(
//                      iconData: FaRegular(0xf007),
                    iconData: FontAwesomeIcons.gamepad,
                    titleText: "Account",
                    subtitleText: "Profile, Subscriptions, Import/Export data",
                  ),

                  SettingsListTile(
//                      iconData: const FaRegular(0xf5d1),
                    iconData: FontAwesomeIcons.gamepad,
                    titleText: "Diary",
                    subtitleText: "Calories, Nutrients, Meals, Logging",
                    navigationEvent: NavigateToSettings.diary(),
                  ),

                  const SettingsListTile(
//                      iconData: FaRegular(0xf496),
                    iconData: FontAwesomeIcons.gamepad,
                    titleText: "Track",
                    subtitleText: "Measurements, Goals",
                  ),

                  const SettingsListTile(
//                      iconData: FaRegular(0xf201),
                    iconData: FontAwesomeIcons.gamepad,
                    titleText: "Reports",
                    subtitleText: "Time intervals, ",
                  ),

                  SettingsListTile(
//                      iconData: const FaRegular(0xf53f),
                    iconData: FontAwesomeIcons.gamepad,
                    titleText: "Theme",  // TODO: rename bloc, from theme to visuals?
                    subtitleText: "Navigation, Dark mode, Colour scheme",
                    navigationEvent: NavigateToSettings.theme(),
                  ),

                  const SettingsListTile(
//                      iconData: FaRegular(0xf021),
                    iconData: FontAwesomeIcons.gamepad,
                    titleText: "Integrations",
                    subtitleText: "Google Fit, Fitbit",
                  ),

                  const SettingsListTile(
//                      iconData: FaRegular(0xf0f3),
                    iconData: FontAwesomeIcons.gamepad,
                    titleText: "Notifications",
                    subtitleText: "Google Fit, Fitbit",
                  ),

                  const SettingsListTile(
//                      iconData: FaRegular(0xf460),
                    iconData: FontAwesomeIcons.gamepad,
                    titleText: "Coaching",
                    subtitleText: "None",
                  ),

                  const SettingsListTile(
//                      iconData: FaRegular(0xf059),
                    iconData: FontAwesomeIcons.gamepad,
                    titleText: "About",
                    subtitleText: "Help, MIT license, Feedback",
                  ),

                  BlocBuilder<ConfigurationBloc, ConfigurationState>(
                    condition: (previous, current) => true,
                    builder: (BuildContext context, ConfigurationState configurationState) {
                      final packageInfo = (configurationState as ConfigurationLoaded).packageInfo;
                      return Text("${packageInfo.appName} ${packageInfo.version}+${packageInfo.buildNumber}; bonus is ${(configurationState as ConfigurationLoaded).remoteConfiguration.bonus}");
                    }
                  )
                ],
              )
            )
          );
//          }
        }
      )
    );
  }
}


class SettingsListTile extends StatelessWidget {
  final IconData iconData;
  final String titleText;
  final String subtitleText;
//  final String chipText; this.chipText,
  final NavigationEvent navigationEvent;

  const SettingsListTile({Key key, @required this.iconData, @required this.titleText, this.subtitleText, this.navigationEvent})
      : assert(iconData != null), assert(titleText != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: iconData != null ? CircleAvatar(
        child: Icon(iconData), 
        backgroundColor: Colors.transparent, 
        foregroundColor: Theme.of(context).unselectedWidgetColor // OPTIMIZE
      ) : null,
      title: Text(titleText, style: Theme.of(context).textTheme.body2),
      subtitle: subtitleText != null ? Text(subtitleText, style: Theme.of(context).textTheme.body1) : null,
      onTap: navigationEvent != null ? () => BlocProvider.of<NavigationBloc>(context).dispatch(navigationEvent) : null,
//      trailing: chipText != null ? Transform(
//        transform: Matrix4.identity()..scale(0.75),
//        child: Chip(
//          label: Text(chipText),
//          labelStyle: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600, letterSpacing: 1.5),
//          shape: BeveledRectangleBorder(borderRadius: const BorderRadius.all(Radius.circular(2))),
//          backgroundColor: Theme.of(context).primaryColorDark,
//          labelPadding: const EdgeInsets.symmetric(horizontal: 5),
//        ),
//      ) : null,
    );
  }
}
