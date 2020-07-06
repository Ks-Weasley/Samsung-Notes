import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samsungnotes/bloc/notes_bloc.dart';
import 'package:samsungnotes/bloc/notes_state.dart';
import 'package:samsungnotes/bloc_delegate.dart';
import 'package:samsungnotes/repository/words_repo.dart';
import 'package:samsungnotes/word_enter_bar.dart';
import 'package:samsungnotes/word_list_builder.dart';

import 'bloc/notes_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    BlocSupervisor.delegate = NoteBlocDelegate();
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider<NoteBloc>(
          create: (BuildContext context) => NoteBloc(
            repo: WordsRepository(<String>[]),
          ),
          child: SamsungNotes(),
        ));
  }
}

class SamsungNotes extends StatelessWidget {
  Future<void> _showBottomSheet(BuildContext context) async {
    await showModalBottomSheet<bool>(
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: BlocProvider<NoteBloc>.value(
              value: context.bloc<NoteBloc>(),
              child: WordEnterBar(),
            ),
          );
        });
  }

  void buildBottomSnackBar(String promptMessage) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(promptMessage),
      duration: const Duration(seconds: 2),
    ));
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: const Text('SAMSUNG NOTES'),
      ),
      body: BlocListener<NoteBloc, NoteState>(
        listener: (context, state) {
          if (state is WordFound) {
            buildBottomSnackBar('Word present');
          }
          if (state is WordNotFound) {
            buildBottomSnackBar('Word not present!');
          }
          if (state is UnsuccessfulUpdate) {
            buildBottomSnackBar('Update failed!');
          }
          if (state is SuccessfulUpdate) {
            buildBottomSnackBar('Updated!');
          }
        },
        child: BlocBuilder<NoteBloc, NoteState>(
          builder: (BuildContext context, NoteState state) {
            if (state is DisplayWordsState) {
              return WordListBuilder(
                wordList: state.words,
              );
            } else
              return Center(
                child: Container(
                  child: Text('No Words yet'),
                ),
              );
          },
        ),
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
