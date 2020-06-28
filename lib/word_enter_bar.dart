import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samsungnotes/bloc/notes_bloc.dart';

import 'bloc/notes_events.dart';

class WordEnterBar extends StatelessWidget {
  String word;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final NoteBloc _noteBloc = BlocProvider.of<NoteBloc>(context);
    return  myForm(_noteBloc);
  }

  Widget myForm(NoteBloc _noteBloc) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'enter a word'),
            onChanged: (val) {
              word = val;
            },
            validator: (val) => val.isEmpty ? 'enter a word' : null,
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
              child: Text('Submit'),
              onPressed: () {
                if(_formKey.currentState.validate())
                  _noteBloc.add(AddAWord(word: word));
              })
        ],
      ),
    );
  }
}
