import 'package:bloc/bloc.dart';
import 'package:my_finance/screens/login/bloc/login_event.dart';
import 'package:my_finance/screens/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call

    // Dummy validation logic
    if (event.email == "Username@gmail.com" &&
        event.password == "abcdef123456") {
      emit(LoginSuccess());
    } else {
      emit(LoginFailure("Invalid email or password"));
    }
  }
}
