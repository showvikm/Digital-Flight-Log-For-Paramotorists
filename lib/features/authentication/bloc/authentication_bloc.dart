import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paramotor/features/authentication/authentication_repository_impl.dart';
import 'package:paramotor/models/user_model.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

/// Events are sent from the UI to the Bloc class.
/// In the Bloc class we call the repository class.
/// Class the data layer which usually contain calls to web service or Database.
/// Authentication Bloc extends the Bloc class providing it with both events and states.
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  /// We will also pass an instance of the AuthenticationRepository to the constructor of Authentication Bloc.
  /// Initially has the state of AuthenticationInitial
  AuthenticationBloc(this._authenticationRepository)
      : super(AuthenticationInitial()) {
    /// on() Method is the Event handler of type AuthenticationEvent.
    /// When add(AuthenticationStarted) in main.dart is called this event triggers.
    /// I.e. AuthenticationStarted event extends the AuthenticationEvent class.
    on<AuthenticationEvent>((event, emit) async {
      /// If even is AuthenticationStarted, We retrieve the uid.
      /// If the uid is valid then we emit the state AuthenticationSuccess
      /// with the the displayName of the user, else if it failed then
      /// we emit AuthenticationFailure.
      /// Because we emitted a new state then the 
      /// [BlocBuilder<AuthenticationBloc, AuthenticationState>] in app.dart,
      /// will rebuild the widget and navigate to the correct page.
      /// 
      if (event is AuthenticationStarted) {
        UserModel user = await _authenticationRepository.getCurrentUser().first;
        if (user.uid != "uid") {
          String? displayName = await _authenticationRepository.retrieveUserName(user);
          emit(AuthenticationSuccess(displayName: displayName));
        } else {
          emit(AuthenticationFailure());
        }
      }
      else if(event is AuthenticationSignedOut){
        await _authenticationRepository.signOut();
        emit(AuthenticationFailure());
      }
    });
  }
}
