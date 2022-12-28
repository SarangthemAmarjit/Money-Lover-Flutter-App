import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'auth_flow_state.dart';

class AuthFlowCubit extends Cubit<AuthflowState> {
  AuthFlowCubit() : super(const AuthflowState(status: logStatus.initial));

  void getloginstatus() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('uid')) {
      emit(const AuthflowState(status: logStatus.loggedIn));
    } else {
      emit(const AuthflowState(status: logStatus.loggedOut));
    }
  }
}
