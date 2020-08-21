import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samsungnotes/NoteBloc/notes_events.dart';
import 'package:samsungnotes/NoteBloc/notes_state.dart';
import 'package:samsungnotes/repository/words_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NoteBloc extends Bloc<NoteEvents, NoteState> {
  WordsRepository repo;

  @override
  NoteState get initialState => Empty();

  @override
  NoteState get state => super.state;

  @override
  Stream<NoteState> mapEventToState(NoteEvents event) async* {
    if (event is InitializeDatabase) {
      yield Loading();
      final List<String> notes = await getDataFromSharedPreferences();
      repo = WordsRepository(words: notes);
      yield DatabaseInitialized();
      yield DisplayWordsState(words: repo.words);
    }
    if (event is AddAWord) {
      if (!repo.checkRedundancy(event.word)) {
        yield WordNotFound();
        final bool result = await repo.addWord(event.word);
        if(result==true)
          yield SuccessfulUpdate();
        else
          yield UnsuccessfulUpdate();
        yield DisplayWordsState(words: repo.words);
      } else {
        yield WordFound();
        yield UnsuccessfulUpdate();
        yield DisplayWordsState(words: repo.words);
      }
    } else if (event is DeleteAWord) {
      final NoteState _currentState = state;
      if (repo.checkRedundancy(event.word)) {
        yield WordFound();
        final bool result = await repo.deleteWord(event.word);
        if(result == true)
          yield SuccessfulUpdate();
        else
          yield UnsuccessfulUpdate();
        if(_currentState is Searching){
          _currentState.words.remove(event.word);
          yield Searching(words: _currentState.words);
        }
        else
          yield DisplayWordsState(words: repo.words);
      } else {
        yield WordNotFound();
        yield UnsuccessfulUpdate();
        yield DisplayWordsState(words: repo.words);
      }
    } else if (event is SearchAWord) {
      final List<String> result = repo.matchingWords(event.word);
      yield Searching(words: result);
    } else if (event is ClearTheList) {
      final bool result = await repo.clearAll();
      if (result == true) {
        yield SuccessfulUpdate();
        yield Empty();
      } else {
        yield UnsuccessfulUpdate();
        yield DisplayWordsState(words: repo.words);
      }
    } else {
      yield DisplayWordsState(words: repo.words);
    }
  }

  Future<List<String>> getDataFromSharedPreferences() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final List<String> keys = pref.getKeys().toList()..sort();
    debugPrint(keys.toString());
    final List<String> notes = keys.map((String key) => pref.getString(key)).toList();
    return notes ?? <String>[] ;
  }
}
