import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samsungnotes/bloc/notes_bloc.dart';
import 'package:samsungnotes/bloc/notes_state.dart';
import 'package:samsungnotes/bloc_delegate.dart';
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
          create: (BuildContext context) => NoteBloc(),
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

  Widget buildBottomsnackBar(BuildContext context, String promptMessage) {
    return Builder(
      builder: (context) {
        Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(promptMessage),
        duration: Duration(seconds: 2),
      ));
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: const Text('SAMSUNG NOTES'),
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
          builder: (BuildContext context, NoteState state) {

        if (state is WordFound) buildBottomsnackBar(context, 'Word present');
        if (state is WordNotFound)
          buildBottomsnackBar(context, 'Word not present!');
        if (state is UnsuccessfulUpdate)
          buildBottomsnackBar(context, 'Update failed!');
        if (state is SuccessfulUpdate)
          buildBottomsnackBar(context, 'Updated!');
        return WordListBuilder(
          wordList: state.words,
        );
      }),
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
