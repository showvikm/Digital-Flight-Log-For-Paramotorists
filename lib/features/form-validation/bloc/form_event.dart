part of 'form_bloc.dart';
/// Differentiates between signUp and signUp.
enum Status { signIn, signUp }

/// Create event for each field. These events get added to onChanged().
/// Specifically on each TextFormField.
/// Whenever the user types anything, the event will be added.
/// The event handler inside the Bloc class would be called.
/// Emits a new state and according to that state we can show an error to user.
/// EmailChanged event contains a field called email.
/// Note: The Equatable package overrides both === and the hashcode internally
/// which save us from doing that manually. Therefore when you use props
/// and all the fields then whenever one of those fields change then we will have 
/// a state change.
abstract class FormEvent extends Equatable {
  const FormEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends FormEvent {
  final String email;
  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends FormEvent {
  final String password;
  const PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class NameChanged extends FormEvent {
  final String displayName;
  const NameChanged(this.displayName);

  @override
  List<Object> get props => [displayName];
}

class AgeChanged extends FormEvent {
  final int age;
  const AgeChanged(this.age);

  @override
  List<Object> get props => [age];
}

class FormSubmitted extends FormEvent {
  final Status value;
  const FormSubmitted({required this.value});

  @override
  List<Object> get props => [value];
}

class FormSucceeded extends FormEvent {
  const FormSucceeded();

  @override
  List<Object> get props => [];
}
