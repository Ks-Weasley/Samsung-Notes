class AuthenticationStates{}

class Initial extends AuthenticationStates{}

class Loading extends AuthenticationStates{}

class Authenticated extends AuthenticationStates{
  final String uid;

  Authenticated(this.uid);
}

class Unauthenticated extends AuthenticationStates{
  final String error;

  Unauthenticated(this.error);
}

class LogIn extends AuthenticationStates{}

class Register extends AuthenticationStates{}

