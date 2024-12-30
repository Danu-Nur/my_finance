import 'package:bloc/bloc.dart';
import 'package:my_finance/screens/signup/bloc/signup_event.dart';
import 'package:my_finance/screens/signup/bloc/signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SubmitSignup>((event, emit) async {
      emit(SignupLoading());
      await Future.delayed(const Duration(seconds: 2)); // Simulasi proses
      emit(SignupSuccess());
    });
  }
}
