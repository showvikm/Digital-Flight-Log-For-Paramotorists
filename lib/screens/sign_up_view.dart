import 'package:paramotor/features/authentication/bloc/authentication_bloc.dart';
import 'package:paramotor/screens/database_demo.dart';
import 'package:paramotor/features/form-validation/bloc/form_bloc.dart';
import 'package:paramotor/utils/constants.dart';
import 'package:paramotor/screens/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

OutlineInputBorder border = const OutlineInputBorder(
    borderSide: BorderSide(color: Constants.kBorderColor, width: 3.0));

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    /// Use [MultiBlocListener] and inside of it listen to any change inside the
    /// [AuthenticationBloc] and inside the [FormBloc].
    return MultiBlocListener(
        listeners: [
          BlocListener<FormBloc, FormsValidate>(
            listener: (context, state) {
              // If the errorMessage in the FormsValidate class is not empty,
              // then the email is not validated or the signUp method threw an
              // error message. Show a Dialog with the error message
              if (state.errorMessage.isNotEmpty) {
                showDialog(
                    context: context,
                    builder: (context) =>
                        ErrorDialog(errorMessage: state.errorMessage));
              /// If isFormValid is true and isLoading is false, then signUp
              /// worked and therefore can add AuthenticationStarted() which
              /// will trigger the event handler in the AuthenticationBloc and
              /// it will return AuthenticationSuccess state.
              /// After AuthenticationSuccess is emitted, it will then trigger
              /// the Bloclistener of type AuthenticationBloc and navigate to
              /// the HomeView page.
              } else if (state.isFormValid && !state.isLoading) {
                context.read<AuthenticationBloc>().add(AuthenticationStarted());
                context.read<FormBloc>().add(const FormSucceeded());
              } else if (state.isFormValidateFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text(Constants.textFixIssues)));
              }
            },
          ),
          BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationSuccess) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomeView()),
                    (Route<dynamic> route) => false);
              }
            },
          ),
        ],
        child: Scaffold(
            backgroundColor: Constants.kPrimaryColor,
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset("assets/images/sign-in.jpg"),
                      const Text(Constants.textRegister,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Constants.kBlackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          )),
                      Padding(
                          padding: EdgeInsets.only(bottom: size.height * 0.02)),
                      const _EmailField(),
                      SizedBox(height: size.height * 0.01),
                      const _PasswordField(),
                      SizedBox(height: size.height * 0.01),
                      const _DisplayNameField(),
                      SizedBox(height: size.height * 0.01),
                      const _AgeField(),
                      SizedBox(height: size.height * 0.01),
                      const _SubmitButton()
                    ]),
              ),
            )));
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
              onChanged: (value) {
                context.read<FormBloc>().add(EmailChanged(value));
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                helperText: 'A complete, valid email e.g. joeschmoe@email.com',
                errorText: !state.isEmailValid
                    ? 'Error: Please ensure the email entered is valid.'
                    : null,
                hintText: 'Email',
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
                border: border,
              )),
        );
      },
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              border: border,
              helperText:
                  '''Password should be at least 8 characters with at least one letter and number''',
              helperMaxLines: 2,
              labelText: 'Password',
              errorMaxLines: 2,
              errorText: !state.isPasswordValid
                  ? '''Error: Password must be at least 8 characters and contain at least one letter and number'''
                  : null,
            ),
            onChanged: (value) {
              context.read<FormBloc>().add(PasswordChanged(value));
            },
          ),
        );
      },
    );
  }
}

class _DisplayNameField extends StatelessWidget {
  const _DisplayNameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              border: border,
              helperText: '''The name you would like to be seen as''',
              helperMaxLines: 2,
              labelText: 'Name',
              errorMaxLines: 2,
              errorText: !state.isNameValid ? '''Error: Invalid name!''' : null,
            ),
            onChanged: (value) {
              context.read<FormBloc>().add(NameChanged(value));
            },
          ),
        );
      },
    );
  }
}

class _AgeField extends StatelessWidget {
  const _AgeField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              border: border,
              helperText: 'Age must be between 1 - 120',
              helperMaxLines: 1,
              labelText: 'Age',
              errorMaxLines: 1,
              errorText: !state.isAgeValid
                  ? 'Error: Age must be valid, e.g. between 1 - 120'
                  : null,
            ),
            onChanged: (value) {
              context.read<FormBloc>().add(AgeChanged(int.parse(value)));
            },
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
                width: size.width * 0.8,
                child: OutlinedButton(
                  onPressed: !state.isFormValid
                      ? () => context
                          .read<FormBloc>()
                          .add(const FormSubmitted(value: Status.signUp))
                      : null,
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Constants.kPrimaryColor),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Constants.kBlackColor),
                      side: MaterialStateProperty.all<BorderSide>(
                          BorderSide.none)),
                  child: const Text(Constants.textSignUpBtn),
                ),
              );
      },
    );
  }
}

class ErrorDialog extends StatelessWidget {
  final String? errorMessage;
  const ErrorDialog({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Alert!"),
      content: Text(errorMessage!),
      actions: [
        TextButton(
          child: const Text("Ok"),
          onPressed: () => errorMessage!.contains(
                  "Thank you for creating an account. Please verify your email (may be in your spam folder) to login.")
              ? Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const WelcomeView()),
                  (Route<dynamic> route) => false)
              : Navigator.of(context).pop(),
        )
      ],
    );
  }
}
