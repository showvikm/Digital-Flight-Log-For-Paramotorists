import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paramotor/features/authentication/authentication_repository_impl.dart';
import 'package:paramotor/features/database/database_repository_impl.dart';
import 'package:paramotor/models/user_model.dart';

part 'form_event.dart';
part 'form_state.dart';

/// FormBloc depends on [AuthenticationRepository] and [DatabaseRepository].
/// Also have an [on] event handler assigning it a type of each event that can
/// occur.
class FormBloc extends Bloc<FormEvent, FormsValidate> {
  final AuthenticationRepository _authenticationRepository;
  final DatabaseRepository _databaseRepository;
  FormBloc(this._authenticationRepository, this._databaseRepository)
      : super(const FormsValidate(
            email: "example@gmail.com",
            password: "",
            isEmailValid: true,
            isPasswordValid: true,
            isFormValid: false,
            isLoading: false,
            isNameValid: true,
            age: 0,
            isAgeValid: true,
            isFormValidateFailed: false)) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<NameChanged>(_onNameChanged);
    on<AgeChanged>(_onAgeChanged);
    on<FormSubmitted>(_onFormSubmitted);
    on<FormSucceeded>(_onFormSucceeded);
  }
  final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );
  /// On email changed we check if the email matches the regex.
  /// Makes sure we enter a valid format.
  bool _isEmailValid(String email) {
    return _emailRegExp.hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  bool _isNameValid(String? displayName) {
    return displayName!.isNotEmpty;
  }

  bool _isAgeValid(int age) {
    return age >= 1 && age <= 120 ? true : false;
  }

  /// Uses copyWith() to update the state and emit a new state which
  /// will get observed by either the BlocBuilder, BlocListener or 
  /// BlocConsumer of type FormsBloc. All other methods are similar.
  _onEmailChanged(EmailChanged event, Emitter<FormsValidate> emit) {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValid: false,
      isFormValidateFailed: false,
      errorMessage: "",
      email: event.email,
      isEmailValid: _isEmailValid(event.email),
    ));
  }

  _onPasswordChanged(PasswordChanged event, Emitter<FormsValidate> emit) {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValidateFailed: false,
      errorMessage: "",
      password: event.password,
      isPasswordValid: _isPasswordValid(event.password),
    ));
  }

  _onNameChanged(NameChanged event, Emitter<FormsValidate> emit) {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValidateFailed: false,
      errorMessage: "",
      displayName: event.displayName,
      isNameValid: _isNameValid(event.displayName),
    ));
  }

  _onAgeChanged(AgeChanged event, Emitter<FormsValidate> emit) {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValidateFailed: false,
      errorMessage: "",
      age: event.age,
      isAgeValid: _isAgeValid(event.age),
    ));
  }
  /// This method is a bit different. Here I use the event FormSubmitted which
  /// has an instance variable of type Status. First we initialize the
  /// [UserModel] class then according to the value of Status we either use
  /// [_updateUIAndSignUp] or [_authenticateUser]
  _onFormSubmitted(FormSubmitted event, Emitter<FormsValidate> emit) async {
    UserModel user = UserModel(
        email: state.email,
        password: state.password,
        age: state.age,
        displayName: state.displayName);

    if (event.value == Status.signUp) {
      await _updateUIAndSignUp(event, emit, user);
    } else if (event.value == Status.signIn) {
      await _authenticateUser(event, emit, user);
    }
  }

  /// First emit() a new state that will check if the form is valid and that
  /// wukk assign true to [isLoading] which will show a 
  /// [CircularProgressIndicator] on the screen. Then, if the form is valid,
  /// I call the signUp() method that we saw before in
  /// the [AuthenticationRepository], then we call copyWith() method and return
  /// a new instance of [UserModel]. After that, call [saveUserData] which adds
  /// the data to Cloud Firestore.
  _updateUIAndSignUp(
      FormSubmitted event, Emitter<FormsValidate> emit, UserModel user) async {
    emit(
      state.copyWith(errorMessage: "",
        isFormValid: _isPasswordValid(state.password) &&
            _isEmailValid(state.email) &&
            _isAgeValid(state.age) &&
            _isNameValid(state.displayName),
        isLoading: true));
    if (state.isFormValid) {
      try {

        UserCredential? authUser = await _authenticationRepository.signUp(user);
        UserModel updatedUser = user.copyWith(
            uid: authUser!.user!.uid, isVerified: authUser.user!.emailVerified);
        await _databaseRepository.saveUserData(updatedUser);
        if (updatedUser.isVerified!) {
          emit(state.copyWith(isLoading: false, errorMessage: ""));
        } else {
          emit(state.copyWith(isFormValid: false,errorMessage: "Please Verify your email, by clicking the link sent to you by mail.",isLoading: false));
        }
      } on FirebaseAuthException catch (e) {
        emit(state.copyWith(
            isLoading: false, errorMessage: e.message, isFormValid: false));
      }
    } else {
      emit(state.copyWith(
          isLoading: false, isFormValid: false, isFormValidateFailed: true));
    }
  }

  _authenticateUser(
      FormSubmitted event, Emitter<FormsValidate> emit, UserModel user) async {
    emit(state.copyWith(errorMessage: "",
        isFormValid:
            _isPasswordValid(state.password) && _isEmailValid(state.email),
        isLoading: true));
    if (state.isFormValid) {
      try {
        UserCredential? authUser = await _authenticationRepository.signIn(user);
        UserModel updatedUser = user.copyWith(isVerified: authUser!.user!.emailVerified);
        if (updatedUser.isVerified!) {
          emit(state.copyWith(isLoading: false, errorMessage: ""));
        } else {
          emit(state.copyWith(isFormValid: false,errorMessage: "Please Verify your email, by clicking the link sent to you by mail.",isLoading: false));
        }
      } on FirebaseAuthException catch (e) {
        emit(state.copyWith(
            isLoading: false, errorMessage: e.message, isFormValid: false));
      }
    } else {
      emit(state.copyWith(
          isLoading: false, isFormValid: false, isFormValidateFailed: true));
    }
  }

  _onFormSucceeded(FormSucceeded event, Emitter<FormsValidate> emit) {
    emit(state.copyWith(isFormSuccessful: true));
  }
}
