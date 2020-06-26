import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samsungnotes/bloc/notes_bloc.dart';
import 'package:samsungnotes/bloc/notes_events.dart';
import 'package:samsungnotes/word_enter_bar.dart';
import 'package:samsungnotes/word_list_builder.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text('SAMSUNG NOTES'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BlocBuilder<NoteBloc, List<String>>(
            bloc: BlocProvider.of<NoteBloc>(context),
            condition: (currentState, nextState) => currentState!=nextState,
            builder: (context, wordList) {
              return wordList.length > 0
                  ? WordListBuilder(
                      wordList: wordList,
                    )
                  : Container();
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 18.0, bottom: 18.0),
                child: FloatingActionButton(
                  backgroundColor: Colors.amberAccent,
                  child: Icon(Icons.add),
                  onPressed: () => showDialog<void>(
                      context: context,
                      builder: (context) => WordEnterBar()),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
