import 'package:paramotor/features/authentication/authentication_repository_impl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'app_bloc_observer.dart';
import 'features/authentication/bloc/authentication_bloc.dart';
import 'features/database/bloc/database_bloc.dart';
import 'features/database/database_repository_impl.dart';
import 'features/form-validation/bloc/form_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Need this line to initialize Firebase services.
  await Firebase.initializeApp();

  /// Contains the blocObserver property.
  /// Lets us observe any change that is happening in the bloc.
  /// Important and it makes it easier to debug any issues.
  BlocOverrides.runZoned(
    /// MultiBlocProvider lets us declare multiple Blocs.
    /// If we needed just one we can just use BlocProvider.
        () => runApp(MultiBlocProvider(
      /// Bloc declarations go here and then they will be consumed later on.
      providers: [
        BlocProvider(
          /// Authentication Bloc is used for authentication.
          create: (context) =>

          /// Immediately add AuthenticationStarted event which will trigger
          /// the event handler inside the Bloc class.
          AuthenticationBloc(AuthenticationRepositoryImpl())
            ..add(AuthenticationStarted()),
        ),

        /// For credential Validation purposes.
        BlocProvider(
          create: (context) => FormBloc(
              AuthenticationRepositoryImpl(), DatabaseRepositoryImpl()),
        ),

        /// Database operations.
        BlocProvider(
          create: (context) => DatabaseBloc(DatabaseRepositoryImpl()),
        )
      ],
      child: const ParamotorApp(),
    )),
    blocObserver: AppBlocObserver(),
  );
}
