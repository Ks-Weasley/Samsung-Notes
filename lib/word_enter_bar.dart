import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samsungnotes/NoteBloc/notes_bloc.dart';
import 'package:samsungnotes/SearchBloc/search_bloc.dart';
import 'package:samsungnotes/SearchBloc/search_state.dart';
import 'SearchBloc/search_events.dart' as se;
import 'word_list_builder.dart';

import 'NoteBloc/notes_events.dart';

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
    BlocProvider<SearchBloc>(
      create: (BuildContext context) => SearchBloc(repo: _noteBloc.repo),
      child: BuildDynamicPage(),
    );
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          BuildDynamicPage(),
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
class BuildDynamicPage extends StatelessWidget {
  String word;
  @override
  Widget build(BuildContext context) {
    final SearchBloc _searchBloc = BlocProvider.of<SearchBloc>(context);
    return Column(
      children: <Widget>[
        TextFormField(
          decoration: const InputDecoration(labelText: 'enter a word'),
          onChanged: (String val) {
            word = val;
            _searchBloc.add(se.SearchAWord(word: word));
          },
          validator: (String val) => val.isEmpty ? 'enter a word' : null,
        ),
        BlocBuilder<SearchBloc, SearchState>(
          builder: (BuildContext context, SearchState state){
            if(state is Searching)
              return WordListBuilder(wordList: state.words,);
            return Container();
          },
        )
      ],
    );
  }
}
