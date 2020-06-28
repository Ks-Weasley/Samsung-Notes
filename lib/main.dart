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

    void _showBottomSheet() {
      showModalBottomSheet<void>(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: BlocProvider.value(
                value: _bloc,
                child: WordEnterBar(),
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text('SAMSUNG NOTES'),
      ),
      body: BlocBuilder<NoteBloc, List<String>>(
          bloc: _bloc,
          // condition: (currentState, nextState) => currentState!=nextState,
          builder: (events, state) {
            return state.length > 0
                ? WordListBuilder(
                    wordList: state,
                  )
                : Container();
          }),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add a word',
        backgroundColor: Colors.amberAccent,
        child: Icon(Icons.add),
        onPressed: () => _showBottomSheet(),
      ),
    );
  }
}
