class AuthenticationEvents{}

class LogInEvent extends AuthenticationEvents{
  LogInEvent({this.email, this.password});

  final String email;
  final String password;

}

class RegisterEvent extends AuthenticationEvents{
  RegisterEvent({this.email, this.password});

  final String email;
  final String password;


}

class Swap extends AuthenticationEvents{
  Swap({this.showLogIn});

  final bool showLogIn;

}
class Logout extends AuthenticationEvents{}

class GetDeviceUser extends AuthenticationEvents{}
