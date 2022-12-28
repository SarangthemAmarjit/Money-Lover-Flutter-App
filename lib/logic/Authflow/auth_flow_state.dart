part of 'auth_flow_cubit.dart';

enum logStatus { initial, loggedIn, loggedOut }

class AuthflowState extends Equatable {
  const AuthflowState({required this.status});

  final logStatus status;

  @override
  List get props => [status];
}
