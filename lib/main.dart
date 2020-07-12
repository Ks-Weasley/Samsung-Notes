import 'package:coffeebrewbloc/authenticate/authenticate_bloc.dart';
import 'package:coffeebrewbloc/authenticate/authenticate_states.dart';
import 'package:coffeebrewbloc/bloc_delegate.dart';
import 'package:coffeebrewbloc/user_interface/loading_indicator.dart';
import 'package:coffeebrewbloc/user_interface/log_in.dart';
import 'package:coffeebrewbloc/user_interface/register.dart';
import 'package:coffeebrewbloc/user_interface/user_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authenticate/authenticate_events.dart';

void main() {
  BlocSupervisor.delegate = GeneralBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => AuthenticationBloc(),
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void buildBottomSnackBar(String promptMessage) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(promptMessage),
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc _authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Welcome!'),
          actions: <Widget>[
            BlocBuilder<AuthenticationBloc, AuthenticationStates>(
                builder: (context, state) {
              if (state is LogIn)
                return FlatButton.icon(
                    onPressed: () =>
                        _authenticationBloc.add(Swap(showLogIn: false)),
                    icon: Icon(Icons.person),
                    label: Text('Register'));
              else if (state is Register)
                return FlatButton.icon(
                    onPressed: () =>
                        _authenticationBloc.add(Swap(showLogIn: true)),
                    icon: Icon(Icons.person),
                    label: Text('LogIn'));
              else
                return FlatButton.icon(
                    onPressed: () => _authenticationBloc.add(Logout()),
                    icon: Icon(Icons.person),
                    label: Text('SignOut'));
            })
          ],
        ),
        body: BlocListener<AuthenticationBloc, AuthenticationStates>(
          listener: (BuildContext context, AuthenticationStates state){
            if (state is Unauthenticated) buildBottomSnackBar(state.error);
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationStates>(
              builder: (context, state) {
            if (state is Loading) return LoadingIndicator();
            if (state is Authenticated) return UserHomePage();
            if (state is Register) return RegisterPage();
            else return LogInPage();
          }),
        ));
  }
}
