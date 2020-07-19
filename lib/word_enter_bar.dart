import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samsungnotes/NoteBloc/notes_bloc.dart';
import 'package:samsungnotes/SearchBloc/search_bloc.dart';
import 'package:samsungnotes/SearchBloc/search_state.dart';
import 'NoteBloc/notes_events.dart';
import 'SearchBloc/search_events.dart' as se;

class WordEnterBar extends StatefulWidget {
  @override
  _WordEnterBarState createState() => _WordEnterBarState();
}

class _WordEnterBarState extends State<WordEnterBar> {
  String word;

  @override
  Widget build(BuildContext context) {
    final NoteBloc _noteBloc = BlocProvider.of<NoteBloc>(context);

    return BlocProvider<SearchBloc>(
      create: (BuildContext context) => SearchBloc(repo: _noteBloc.repo),
      child: BuildDynamicPage(),
    );
  }

}

class BuildDynamicPage extends StatefulWidget {
  @override
  _BuildDynamicPageState createState() => _BuildDynamicPageState();
}

class _BuildDynamicPageState extends State<BuildDynamicPage> {
  String word;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final NoteBloc _noteBloc = BlocProvider.of<NoteBloc>(context);
    final SearchBloc _searchBloc = BlocProvider.of<SearchBloc>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 26.0, right: 26.0, top: 26.0, bottom: MediaQuery.of(context).viewInsets.bottom+26.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  TextFormField(
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'enter a word'),
                    onChanged: (String val) {
                      word = val;
                      if(word.isEmpty)
                        _searchBloc.add(se.SearchAWord(word: ' '));
                      else
                        _searchBloc.add(se.SearchAWord(word: word));
                    },
                    validator: (String val) => val.isEmpty ? 'enter a word' : null,
                  ),
                  BlocBuilder<SearchBloc, SearchState>(
                    builder: (BuildContext context, SearchState state) {
                      if (state is Searching)
                        return state.words.isNotEmpty? Container(
                            height: 100.0,
                            width: MediaQuery.of(context).size.width,
                            child: searchListBuilder(wordList: state.words,)):
                        Container();
                      return Container();
                    },
                  )
                ],
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
        ),
      ),
    );
  }

  Widget searchListBuilder({List<String> wordList}) {
    return wordList!=null ? ListView.builder(
        itemCount: wordList.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              ListTile(title: Text(wordList[index])),
              const Divider(
                thickness: 1.0,
              )
            ],
          );
        }): Container();
  }
}
