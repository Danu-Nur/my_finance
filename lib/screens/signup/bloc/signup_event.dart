abstract class SignupEvent {}

class SubmitSignup extends SignupEvent {
  final String fullName;
  final String email;
  final String password;
  
  SubmitSignup(this.fullName, this.email, this.password);
}
