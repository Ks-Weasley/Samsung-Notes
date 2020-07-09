import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samsungnotes/NoteBloc/notes_bloc.dart';
import 'package:samsungnotes/NoteBloc/notes_state.dart';
import 'package:samsungnotes/bloc_delegate.dart';
import 'package:samsungnotes/repository/words_repo.dart';
import 'package:samsungnotes/word_enter_bar.dart';
import 'package:samsungnotes/word_list_builder.dart';

import 'NoteBloc/notes_events.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocSupervisor.delegate = NoteBlocDelegate();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider<NoteBloc>(
            create: (BuildContext context) => NoteBloc(
              repo: WordsRepository(<String>[]),
            ),
        child: SamsungNotes(),),);
  }
}

class SamsungNotes extends StatefulWidget {
  @override
  _SamsungNotesState createState() => _SamsungNotesState();
}

class _SamsungNotesState extends State<SamsungNotes> {
  Widget appBarTitle = const Text('SAMSUNG NOTES');
  bool showSearch = true;
  String currentWord;

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
      duration: const Duration(milliseconds: 70),
    ));
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  @override
  Widget build(BuildContext context) {
    final NoteBloc _noteBloc = BlocProvider.of<NoteBloc>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: appBarTitle,
        actions: <Widget>[
          BlocBuilder<NoteBloc, NoteState>(
              builder: (BuildContext context, NoteState state) {
            if (state is Searching)
              return FlatButton(
                  shape: const CircleBorder(side: BorderSide.none),
                  child: Icon(Icons.close),
                  onPressed: () {
                    _noteBloc.add(SearchDone());
                    setState(() {
                      appBarTitle = const Text('SAMSUNG NOTES');
                    });
                  });
            return FlatButton(
                shape: const CircleBorder(side: BorderSide.none),
                child: const Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    currentWord = '';
                    appBarTitle = TextFormField(
                      onChanged: (String val) {
                        currentWord = val;
                        _noteBloc.add(SearchAWord(word: currentWord));
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.search),
                        hintText: 'Enter a word to search',
                      ),
                    );
                  });
                  _noteBloc.add(SearchAWord(word: currentWord));
                });
          })
        ],
      ),
      body: BlocListener<NoteBloc, NoteState>(
        listener: (BuildContext context, NoteState state) {
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
              return state.words.isNotEmpty
                  ? WordListBuilder(
                      wordList: state.words,
                    )
                  : Center(
                      child: Container(
                        child: const Text('No Words yet'),
                      ),
                    );
            }
            if (state is Searching) {
              return state.words.isNotEmpty
                  ? WordListBuilder(
                      wordList: state.words,
                    )
                  : Center(
                      child: Container(
                        child: const Text('No matches found'),
                      ),
                    );
            } else
              return Center(
                child: Container(
                  child: const Text('No Words yet'),
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
