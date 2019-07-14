import 'package:built_value/built_value.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseUser;

import 'package:diet_driven/blocs/bloc_utils.dart';
import 'package:diet_driven/models/models.dart';

part 'user_data_state.g.dart';

abstract class UserDataState {}

/// Splash page blocks rest of application.
abstract class UserDataUninitialized implements UserDataState, Built<UserDataUninitialized, UserDataUninitializedBuilder> {
  factory UserDataUninitialized([void Function(UserDataUninitializedBuilder b)]) = _$UserDataUninitialized;
  UserDataUninitialized._();

  @override String toString() => runtimeType.toString();
}

/// Global error page.
abstract class UserDataFailed implements BuiltError, UserDataState, Built<UserDataFailed, UserDataFailedBuilder> {
  factory UserDataFailed([void Function(UserDataFailedBuilder b)]) = _$UserDataFailed;
  UserDataFailed._();
}

// TODO: create separate onboarding bloc
/// Unauthenticated user onboarding / sign in.
abstract class UserDataUnauthenticated implements UserDataState, Built<UserDataUnauthenticated, UserDataUnauthenticatedBuilder> {
  factory UserDataUnauthenticated([void Function(UserDataUnauthenticatedBuilder b)]) = _$UserDataUnauthenticated;
  UserDataUnauthenticated._();

  @override String toString() => runtimeType.toString();
}

/// Application.
abstract class UserDataLoaded implements UserDataState, Built<UserDataLoaded, UserDataLoadedBuilder> {
  /// Firebase authentication user.
  FirebaseUser get authentication;

  /// Read-only user metadata.
  UserDocument get userDocument; // TODO: accepted terms

  /// Synchronized application settings.
  Settings get settings;

  /// Paid subscription status.
  SubscriptionType get subscription;

  factory UserDataLoaded([void Function(UserDataLoadedBuilder b)]) = _$UserDataLoaded;
  UserDataLoaded._();
}
