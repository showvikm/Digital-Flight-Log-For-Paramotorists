import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paramotor/models/user_model.dart';

import '../database_repository_impl.dart';


part 'database_event.dart';
part 'database_state.dart';

/// If the event DatabaseFetched is triggered, it will call the method
/// _fetchUserData(), which will then call the method retrieveUserData() and 
/// after getting the response, it will emit a new state with the data that it 
/// got from Cloud Firestore.
class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final DatabaseRepository _databaseRepository;
  DatabaseBloc(this._databaseRepository) : super(DatabaseInitial()) {
    on<DatabaseFetched>(_fetchUserData);
  }

  _fetchUserData(DatabaseFetched event, Emitter<DatabaseState> emit) async {
      List<UserModel> listofUserData = await _databaseRepository.retrieveUserData();
      emit(DatabaseSuccess(listofUserData,event.displayName));
  }
}
