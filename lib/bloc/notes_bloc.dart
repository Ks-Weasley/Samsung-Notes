import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samsungnotes/bloc/notes_events.dart';
import 'package:samsungnotes/bloc/notes_state.dart';
import 'package:samsungnotes/repository/words_repo.dart';

class NoteBloc extends Bloc<NoteEvents, NoteState> {
  NoteBloc({this.repo});

  final WordsRepository repo;

  @override
  NoteState get initialState => Empty();

  @override
  NoteState get state => super.state;

  @override
  Stream<NoteState> mapEventToState(NoteEvents event) async* {
    if (event is AddAWord) {
      if (!repo.checkRedundancy(event.word)) {
        yield WordNotFound();
        repo.addWord(event.word);
        yield SuccessfulUpdate();
        yield DisplayWordsState(words: repo.words);
      } else {
        yield WordFound();
        yield UnsuccessfulUpdate();
        yield DisplayWordsState(words: repo.words);
      }
    } else if (event is DeleteAWord) {
      if (repo.checkRedundancy(event.word)) {
        yield WordFound();
        repo.deleteWord(event.word);
        yield SuccessfulUpdate();
        yield DisplayWordsState(words: repo.words);
      } else {
        yield WordNotFound();
        yield UnsuccessfulUpdate();
        yield DisplayWordsState(words: repo.words);
      }
    }else if(event is SearchAWord){
      final List<String> result= repo.matchingWords(event.word);
      yield Searching(words: result);
    }else{
      yield DisplayWordsState(words: repo.words);
    }
  }

}
