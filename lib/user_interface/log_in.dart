import 'package:coffeebrewbloc/authenticate/authenticate_bloc.dart';
import 'package:coffeebrewbloc/authenticate/authenticate_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  String email, password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc _authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: new InputDecoration(
                  hintText: 'Enter email', icon: Icon(Icons.email)),
              onChanged: (String val) => email = val,
              validator: (String val) =>
                  val.isEmpty ? 'Please enter an email' : null,
            ),
            const SizedBox(
              height: 30.0,
            ),
            TextFormField(
              decoration: new InputDecoration(
                hintText: 'Enter password',
                icon: Icon(Icons.lock),
              ),
              onChanged: (String val) => password = val,
              validator: (String val) => val.isEmpty ? 'Please enter password' : null,
              obscureText: true,
            ),
            const SizedBox(
              height: 30.0,
            ),
            RaisedButton(
              child: const Text('Log In'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _authenticationBloc
                      .add(LogInEvent(email: email, password: password));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
