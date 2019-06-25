import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseUser;
import 'package:meta/meta.dart';

import 'package:diet_driven/blocs/login/login.dart';
import 'package:diet_driven/repositories/repositories.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  // TODO: log

  final UserRepository authenticationRepository;
//  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.authenticationRepository,
//    @required this.authenticationBloc,
  }) : assert(authenticationRepository != null);//, assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();


//  @override
//  Stream<FoodDiaryState> transform(Stream<FoodDiaryEvent> events, Stream<FoodDiaryState> Function(FoodDiaryEvent event) next) {
//    return super.transform(
//      (events as Observable<FoodDiaryEvent>),
////        .debounce(Duration(milliseconds: 500)),
//      next,
//    );
//  @override
//  Stream<LoginEvent> transform(Stream<LoginEvent> events) {
//    // TODO: recommend to reset password if too many requests made
////    return DistinctUniqueStreamTransformer().bind(events);
//    return events;
//
//  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is PressLoginButton) {
      yield LoginLoading();

      try {
        // ignore: unused_local_variable
        final FirebaseUser user = await authenticationRepository.signInWithEmail(event.username, event.password);
//        authenticationBloc.dispatch(LoggedIn((b) => b..user = user)); // OPTIMIZE: not necessary with auth subscription
        yield LoginInitial();
      } catch (error) {
        // TODO: catch different types of errors once they improve error handling in android
        // https://github.com/flutter/plugins/pull/775
        print(error.runtimeType);
        yield LoginFailure((b) => b.error = error.toString());
      }
    }
    else {
      print("LOGIN EVENT NOT DEFINED: $event");
    }
  }

}