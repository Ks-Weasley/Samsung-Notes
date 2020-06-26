import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samsungnotes/bloc/notes_bloc.dart';
import 'package:samsungnotes/bloc/notes_events.dart';

class WordListTile extends StatelessWidget {
  final String word;

  const WordListTile({Key key, this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NoteBloc _noteBloc = BlocProvider.of<NoteBloc>(context);

    return ListTile(
      title: Text(word),
      trailing: GestureDetector(
        onTap: () async{
           await _noteBloc.add(DeleteAWord(word: word));
        },
          child: Icon(
        Icons.delete,
      )),
    );
  }
}
