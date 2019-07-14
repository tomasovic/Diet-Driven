// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_events.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$InitUserData extends InitUserData {
  factory _$InitUserData([void Function(InitUserDataBuilder) updates]) =>
      (new InitUserDataBuilder()..update(updates)).build();

  _$InitUserData._() : super._();

  @override
  InitUserData rebuild(void Function(InitUserDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InitUserDataBuilder toBuilder() => new InitUserDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InitUserData;
  }

  @override
  int get hashCode {
    return 437658457;
  }
}

class InitUserDataBuilder
    implements Builder<InitUserData, InitUserDataBuilder> {
  _$InitUserData _$v;

  InitUserDataBuilder();

  @override
  void replace(InitUserData other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InitUserData;
  }

  @override
  void update(void Function(InitUserDataBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$InitUserData build() {
    final _$result = _$v ?? new _$InitUserData._();
    replace(_$result);
    return _$result;
  }
}

class _$RemoteUserDataArrived extends RemoteUserDataArrived {
  @override
  final FirebaseUser authentication;
  @override
  final UserDocument userDocument;
  @override
  final Settings settings;
  @override
  final SubscriptionType subscription;

  factory _$RemoteUserDataArrived(
          [void Function(RemoteUserDataArrivedBuilder) updates]) =>
      (new RemoteUserDataArrivedBuilder()..update(updates)).build();

  _$RemoteUserDataArrived._(
      {this.authentication,
      this.userDocument,
      this.settings,
      this.subscription})
      : super._() {
    if (authentication == null) {
      throw new BuiltValueNullFieldError(
          'RemoteUserDataArrived', 'authentication');
    }
    if (userDocument == null) {
      throw new BuiltValueNullFieldError(
          'RemoteUserDataArrived', 'userDocument');
    }
    if (settings == null) {
      throw new BuiltValueNullFieldError('RemoteUserDataArrived', 'settings');
    }
    if (subscription == null) {
      throw new BuiltValueNullFieldError(
          'RemoteUserDataArrived', 'subscription');
    }
  }

  @override
  RemoteUserDataArrived rebuild(
          void Function(RemoteUserDataArrivedBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RemoteUserDataArrivedBuilder toBuilder() =>
      new RemoteUserDataArrivedBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RemoteUserDataArrived &&
        authentication == other.authentication &&
        userDocument == other.userDocument &&
        settings == other.settings &&
        subscription == other.subscription;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, authentication.hashCode), userDocument.hashCode),
            settings.hashCode),
        subscription.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('RemoteUserDataArrived')
          ..add('authentication', authentication)
          ..add('userDocument', userDocument)
          ..add('settings', settings)
          ..add('subscription', subscription))
        .toString();
  }
}

class RemoteUserDataArrivedBuilder
    implements Builder<RemoteUserDataArrived, RemoteUserDataArrivedBuilder> {
  _$RemoteUserDataArrived _$v;

  FirebaseUser _authentication;
  FirebaseUser get authentication => _$this._authentication;
  set authentication(FirebaseUser authentication) =>
      _$this._authentication = authentication;

  UserDocumentBuilder _userDocument;
  UserDocumentBuilder get userDocument =>
      _$this._userDocument ??= new UserDocumentBuilder();
  set userDocument(UserDocumentBuilder userDocument) =>
      _$this._userDocument = userDocument;

  SettingsBuilder _settings;
  SettingsBuilder get settings => _$this._settings ??= new SettingsBuilder();
  set settings(SettingsBuilder settings) => _$this._settings = settings;

  SubscriptionType _subscription;
  SubscriptionType get subscription => _$this._subscription;
  set subscription(SubscriptionType subscription) =>
      _$this._subscription = subscription;

  RemoteUserDataArrivedBuilder();

  RemoteUserDataArrivedBuilder get _$this {
    if (_$v != null) {
      _authentication = _$v.authentication;
      _userDocument = _$v.userDocument?.toBuilder();
      _settings = _$v.settings?.toBuilder();
      _subscription = _$v.subscription;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RemoteUserDataArrived other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$RemoteUserDataArrived;
  }

  @override
  void update(void Function(RemoteUserDataArrivedBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$RemoteUserDataArrived build() {
    _$RemoteUserDataArrived _$result;
    try {
      _$result = _$v ??
          new _$RemoteUserDataArrived._(
              authentication: authentication,
              userDocument: userDocument.build(),
              settings: settings.build(),
              subscription: subscription);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'userDocument';
        userDocument.build();
        _$failedField = 'settings';
        settings.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'RemoteUserDataArrived', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$UserDataError extends UserDataError {
  @override
  final Object error;
  @override
  final StackTrace stacktrace;

  factory _$UserDataError([void Function(UserDataErrorBuilder) updates]) =>
      (new UserDataErrorBuilder()..update(updates)).build();

  _$UserDataError._({this.error, this.stacktrace}) : super._() {
    if (error == null) {
      throw new BuiltValueNullFieldError('UserDataError', 'error');
    }
  }

  @override
  UserDataError rebuild(void Function(UserDataErrorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserDataErrorBuilder toBuilder() => new UserDataErrorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserDataError &&
        error == other.error &&
        stacktrace == other.stacktrace;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, error.hashCode), stacktrace.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserDataError')
          ..add('error', error)
          ..add('stacktrace', stacktrace))
        .toString();
  }
}

class UserDataErrorBuilder
    implements Builder<UserDataError, UserDataErrorBuilder>, BuiltErrorBuilder {
  _$UserDataError _$v;

  Object _error;
  Object get error => _$this._error;
  set error(Object error) => _$this._error = error;

  StackTrace _stacktrace;
  StackTrace get stacktrace => _$this._stacktrace;
  set stacktrace(StackTrace stacktrace) => _$this._stacktrace = stacktrace;

  UserDataErrorBuilder();

  UserDataErrorBuilder get _$this {
    if (_$v != null) {
      _error = _$v.error;
      _stacktrace = _$v.stacktrace;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant UserDataError other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserDataError;
  }

  @override
  void update(void Function(UserDataErrorBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserDataError build() {
    final _$result =
        _$v ?? new _$UserDataError._(error: error, stacktrace: stacktrace);
    replace(_$result);
    return _$result;
  }
}

class _$OnboardUser extends OnboardUser {
  factory _$OnboardUser([void Function(OnboardUserBuilder) updates]) =>
      (new OnboardUserBuilder()..update(updates)).build();

  _$OnboardUser._() : super._();

  @override
  OnboardUser rebuild(void Function(OnboardUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OnboardUserBuilder toBuilder() => new OnboardUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OnboardUser;
  }

  @override
  int get hashCode {
    return 509793739;
  }
}

class OnboardUserBuilder implements Builder<OnboardUser, OnboardUserBuilder> {
  _$OnboardUser _$v;

  OnboardUserBuilder();

  @override
  void replace(OnboardUser other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$OnboardUser;
  }

  @override
  void update(void Function(OnboardUserBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OnboardUser build() {
    final _$result = _$v ?? new _$OnboardUser._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
