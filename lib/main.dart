import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samsungnotes/bloc/notes_bloc.dart';
import 'package:samsungnotes/word_enter_bar.dart';
import 'package:samsungnotes/word_list_builder.dart';

import 'bloc/notes_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider<NoteBloc>(
          create: (context) => NoteBloc(),
          child: SamsungNotes(),
        ));
  }
}

class SamsungNotes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NoteBloc _bloc = BlocProvider.of<NoteBloc>(context);
    return BlocBuilder<NoteBloc, List<String>>(
      bloc: _bloc,
      condition: (currentState, nextState) => currentState != nextState,
      builder: (context, wordList) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amberAccent,
            title: Text('SAMSUNG NOTES'),
          ),
          body: wordList.length > 0
              ? WordListBuilder(
                  wordList: wordList,
                )
              : Container(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.amberAccent,
            child: Icon(Icons.add),
            onPressed: () => buildShowDialog(context, _bloc),
          ),
        );
      },
    );
  }

  Future<void> buildShowDialog(BuildContext context, NoteBloc noteBloc) {
    return showDialog<void>(
      context: context,
      builder: (context) => BlocProvider.value(
        value: noteBloc,
        child: WordEnterBar(),
      ),
    );
  }
}
