import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:samsungnotes/bloc/notes_events.dart';
import 'package:samsungnotes/bloc/notes_state.dart';

import 'notes_structure.dart';

class NoteBloc extends Bloc<NoteEvents, List<String>> {

  @override
  // TODO: implement initialState
  List<String> get initialState => [];

  @override
  Stream<List<String>> mapEventToState(NoteEvents event) async* {
    // TODO: implement mapEventToState
    if (event is AddAWord) {
      if (checkRedundancy(state, event.word) == false) {
        state.add(event.word);
        yield state;
      } else
        yield ['Redundant word!'];
    } else if (event is DeleteAWord) {
      if (checkRedundancy(state, event.word) == true) {
        state.remove(event.word);
        yield state;
      }else yield ['Word not found'];
    } else if (event is FindAWord) {
      if (checkRedundancy(state, event.word) == true)
        yield state;
      else
        yield ['Word not found'];
    }
  }

  bool checkRedundancy(List<String> state, String word) {
    return state.contains(word);
  }
}
