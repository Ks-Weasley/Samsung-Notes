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
  Future<void> _showBottomSheet(BuildContext context) async {
    await showModalBottomSheet<bool>(
        context: context,
        builder: (ctx) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: BlocProvider<NoteBloc>.value(
              value: context.bloc<NoteBloc>(),
              child: WordEnterBar(),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text('SAMSUNG NOTES'),
      ),
      body: BlocBuilder<NoteBloc, List<String>>(
        builder: (ctx, words) {
          return WordListBuilder(
            wordList: words,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add a word',
        backgroundColor: Colors.amberAccent,
        child: Icon(Icons.add),
        onPressed: () {
          _showBottomSheet(context);
        },
      ),
    );
  }
}
