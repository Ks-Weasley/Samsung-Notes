import 'package:coffeebrewbloc/authenticate/authenticate_events.dart';
import 'package:coffeebrewbloc/authenticate/authenticate_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvents, AuthenticationStates> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  // TODO: implement initialState
  AuthenticationStates get initialState => Initial();

  @override
  Stream<AuthenticationStates> mapEventToState(
      AuthenticationEvents event) async* {
    // TODO: implement mapEventToState
    if (event is GetDeviceUser) {
      final AuthenticationStates _authenticationResults = await loggedInUser();
      yield _authenticationResults;
    }
    if (event is LogInEvent) {
      yield Loading();
      final AuthenticationStates result =
      await signInWithEmailAndPassword(event.email, event.password);
      yield result;
      if (result is Unauthenticated)
        yield LogIn();
    }
    if (event is RegisterEvent) {
      yield Loading();
      final AuthenticationStates result =
      await registerWithEmailAndPassword(event.email, event.password);
      yield result;
      if (result is Unauthenticated)
        yield Register();
    }

    if (event is Swap) {
      yield event.showLogIn ? LogIn() : Register();
    }
    if (event is Logout) {
      yield Loading();
      if (signOut() == null)
        yield Unauthenticated('Falied Signing out');
      else
        yield LogIn();
    }
  }

  //for getting initial device user if already logged in
  Future<AuthenticationStates> loggedInUser() async {
    final FirebaseUser firebaseUser = await _auth.currentUser();
    return firebaseUser == null ? LogIn() : Authenticated(firebaseUser.uid);
  }


//for anonymous entry for testing purposes
  Future<AuthenticationStates> signInAnonymously() async {
    try {
      final AuthResult result = await _auth.signInAnonymously();
      print('Sucess');
      print(result.user);
      return Authenticated(result.user.uid);
    } catch (e) {
      print(e.toString());
      return Unauthenticated(e.message);
    }
  }

  //Signing in using email and password
  Future<AuthenticationStates> signInWithEmailAndPassword(String email,
      String password) async {
    try {
      final AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      print(result.user.toString());
      print('Sucess');
      return Authenticated(result.user.uid);
    } catch (e) {
      print(e.message);
      return Unauthenticated(e.message);
    }
  }

  Future<AuthenticationStates> registerWithEmailAndPassword(String email,
      String password) async {
    try {
      final AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      print('Sucess');
      print(result.user);
      return Authenticated(result.user.uid);
    } catch (e) {
      print(e.toString());
      return Unauthenticated(e.message);
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
