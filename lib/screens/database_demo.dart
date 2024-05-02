import 'package:paramotor/features/authentication/bloc/authentication_bloc.dart';
import 'package:paramotor/features/database/bloc/database_bloc.dart';
import 'package:paramotor/utils/constants.dart';
import 'package:paramotor/screens/welcome_view.dart';
// import 'package:paramotor/screens/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// BlocConsumer enables us to combine listener and builder,
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationFailure) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const WelcomeView()),
              (Route<dynamic> route) => false);
        }
      },
      buildWhen: ((previous, current) {
        if (current is AuthenticationFailure) {
          return false;
        }
        return true;
      }),
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              actions: <Widget>[
                IconButton(
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    /// onPressed button we add the event AuthenticationSignedOut()
                    /// which will emit the state AuthenticationFailure and then
                    /// we would navigate to the WelcomeView().
                    onPressed: () async {
                      context
                          .read<AuthenticationBloc>()
                          .add(AuthenticationSignedOut());
                    }),
              ],
              systemOverlayStyle:
                  const SystemUiOverlayStyle(statusBarColor: Colors.white),
              /// In the property title we use the displayName to show the user,
              /// we get the displayName only if the state is AuthenticationSuccess.
              title: Text((state as AuthenticationSuccess).displayName!),
            ),
            /// First we get the displayName from the AuthenticationSuccess state
            /// and check if the state is DatabaseSuccess and the displayName
            /// is different than the one inside DatabaseSuccess then we call
            /// DatabaseFetched event to update the list.
            body: BlocBuilder<DatabaseBloc, DatabaseState>(
              builder: (context, state) {
                String? displayName = (context.read<AuthenticationBloc>().state
                        as AuthenticationSuccess)
                    .displayName;
                if (state is DatabaseSuccess &&
                    displayName !=
                        (context.read<DatabaseBloc>().state as DatabaseSuccess)
                            .displayName) {
                  context
                      .read<DatabaseBloc>()
                      .add(DatabaseFetched(displayName));
                }
                /// If state is DatabaseInitial, then we add the event DatabaseFetched,
                /// which will emit a state of type DatabaseSuccess and will
                /// show the list of users.
                if (state is DatabaseInitial) {
                  context
                      .read<DatabaseBloc>()
                      .add(DatabaseFetched(displayName));
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DatabaseSuccess) {
                  if (state.listOfUserData.isEmpty) {
                    return const Center(
                      child: Text(Constants.textNoData),
                    );
                  } else {
                    return Center(
                      child: ListView.builder(
                        itemCount: state.listOfUserData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                  state.listOfUserData[index].displayName!),
                              subtitle:
                                  Text(state.listOfUserData[index].email!),
                              trailing: Text(
                                  state.listOfUserData[index].age!.toString()),
                            ),
                          );
                        },
                      ),
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ));
      },
    );
  }
}
