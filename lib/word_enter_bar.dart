import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samsungnotes/bloc/notes_bloc.dart';

import 'bloc/notes_events.dart';

class WordEnterBar extends StatefulWidget {
  @override
  _WordEnterBarState createState() => _WordEnterBarState();
}

class _WordEnterBarState extends State<WordEnterBar> {
  String word;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final NoteBloc _noteBloc = BlocProvider.of<NoteBloc>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(labelText: 'enter a word'),
            onChanged: (String val) {
              word = val;
            },
            validator: (String val) => val.isEmpty ? 'enter a word' : null,
          ),
          const SizedBox(
            height: 20.0,
          ),
          RaisedButton(
              child: const Text('Add'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _noteBloc.add(AddAWord(word: word));
                  Navigator.of(context).pop();
                }
              })
        ],
      ),
    );
  }
}
