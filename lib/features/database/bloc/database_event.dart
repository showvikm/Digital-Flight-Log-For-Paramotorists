part of 'database_bloc.dart';

abstract class DatabaseEvent extends Equatable {
  const DatabaseEvent();

  @override
  List<Object?> get props => [];
}
/// Event DatabaseFetched will get called to fetch the data from Cloud Firestore.
class DatabaseFetched extends DatabaseEvent {
  final String? displayName;
  const DatabaseFetched(this.displayName);
  @override
  List<Object?> get props => [displayName];
}
