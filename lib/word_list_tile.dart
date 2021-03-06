import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samsungnotes/NoteBloc/notes_bloc.dart';
import 'package:samsungnotes/NoteBloc/notes_events.dart';

class WordListTile extends StatelessWidget {
  const WordListTile({Key key, this.word}) : super(key: key);

  final String word;

  @override
  Widget build(BuildContext context) {
    final NoteBloc _noteBloc = BlocProvider.of<NoteBloc>(context);

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListTile(
        title: Text(word),
        trailing: GestureDetector(
            onTap: () {
              _noteBloc.add(DeleteAWord(word: word));
            },
            child: Icon(
              Icons.delete,
            )),
      ),
    );
  }
}
