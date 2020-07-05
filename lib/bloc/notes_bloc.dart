import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samsungnotes/bloc/notes_events.dart';
import 'package:samsungnotes/bloc/notes_state.dart';

class NoteBloc extends Bloc<NoteEvents, NoteState> {
  @override
  // TODO: implement initialState
  NoteState get initialState => Empty();

  @override
  NoteState get state => super.state;

  @override
  Stream<NoteState> mapEventToState(NoteEvents event) async* {
    if(state is Empty){
      state.words = <String>[];
    }
    if (event is AddAWord) {
      if (checkRedundancy(state.words, event.word) == false) {
        yield WordNotFound();
        state.words.add(event.word);
        yield SuccessfulUpdate();
      } else {
        yield WordFound();
        yield UnsuccessfulUpdate();
      }
    } else if (event is DeleteAWord) {
      if (checkRedundancy(state.words, event.word) == true) {
        yield WordFound();
        state.words.remove(event.word);
        yield SuccessfulUpdate();
      }
      else {
        yield WordNotFound();
        yield UnsuccessfulUpdate();
      }
    }
  }

  bool checkRedundancy(List<String> state, String word) {
    return state.contains(word);
  }
}
