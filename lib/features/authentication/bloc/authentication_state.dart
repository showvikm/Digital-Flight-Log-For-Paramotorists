part of 'authentication_bloc.dart';
/// Three states: Initial State, Success State, Failure State
/// Success stat contains the displayName of the user as well
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  
  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
      @override
  List<Object?> get props => [];
}

class AuthenticationSuccess extends AuthenticationState {
  final String? displayName;
  const AuthenticationSuccess({this.displayName});

    @override
  List<Object?> get props => [displayName];
}

class AuthenticationFailure extends AuthenticationState {
      @override
  List<Object?> get props => [];
}
