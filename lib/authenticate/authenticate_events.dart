class AuthenticationEvents{}

class LogInEvent extends AuthenticationEvents{
  final String email;
  final String password;

  LogInEvent({this.email, this.password});
}

class RegisterEvent extends AuthenticationEvents{
  final String email;
  final String password;

  RegisterEvent({this.email, this.password});

}

class Swap extends AuthenticationEvents{
  final bool showLogIn;

  Swap({this.showLogIn});
}
class Logout extends AuthenticationEvents{}
