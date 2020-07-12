import 'package:coffeebrewbloc/authenticate/authenticate_events.dart';
import 'package:coffeebrewbloc/authenticate/authenticate_states.dart';
import 'package:coffeebrewbloc/authenticate/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvents, AuthenticationStates> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  // TODO: implement initialState
  AuthenticationStates get initialState => LogIn();

  @override
  Stream<AuthenticationStates> mapEventToState(
      AuthenticationEvents event) async* {
    // TODO: implement mapEventToState
    if (event is LogInEvent) {
      yield Loading();
      final result =
          await signInWithEmailAndPassword(event.email, event.password);
      if (result == null) {
        yield Unauthenticated('Failed Login');
        yield LogIn();

      } else
        yield Authenticated(result.uid);
    }
    if (event is RegisterEvent) {
      yield Loading();
      final result =
          await registerWithEmailAndPassword(event.email, event.password);
      if (result == null) {
        yield Unauthenticated('Failed register!');
        yield Register();
      } else
        yield Authenticated(result.uid);
    }
    if(event is Swap){
      yield event.showLogIn ? LogIn() : Register();
    }
    if(event is Logout){
      yield Loading();
      if(signOut() == null)
       yield Unauthenticated('Falied Signing out');
      else
        yield LogIn();
    }
  }

//for anonymous entry for testing purposes
  Future<User> signInAnonymously() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      print('Sucess');
      print(result.user);
      return User(uid: result.user.uid);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Signing in using email and password
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      print(result.user.toString());
      print('Sucess');
      return User(uid: result.user.uid);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      print('Sucess');
      print(result.user);
      return User(uid: result.user.uid);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
