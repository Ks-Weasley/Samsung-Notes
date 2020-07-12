import 'package:coffeebrewbloc/authenticate/authenticate_bloc.dart';
import 'package:coffeebrewbloc/authenticate/authenticate_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
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
              onChanged: (val) => email = val,
              validator: (val) =>
                  val.isEmpty ? 'Please enter an email' : null,
            ),
            SizedBox(
              height: 30.0,
            ),
            TextFormField(
              decoration: new InputDecoration(
                hintText: 'Enter password',
                icon: Icon(Icons.lock),
              ),
              onChanged: (val) => password = val,
              validator: (val) => val.length < 6 ? 'Please enter +6 chars password' : null,
              obscureText: true,
            ),
            SizedBox(
              height: 30.0,
            ),
            RaisedButton(
              child: Text('Register'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _authenticationBloc
                      .add(RegisterEvent(email: email, password: password));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
