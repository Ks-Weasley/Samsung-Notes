import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samsungnotes/bloc/notes_events.dart';

class NoteBloc extends Bloc<NoteEvents, List<String>> {
  @override
  // TODO: implement initialState
  List<String> get initialState => <String>[];

  @override
  List<String> get state => List.from(super.state);

  @override
  Stream<List<String>> mapEventToState(NoteEvents event) async* {
    final state = this.state;
    if (event is AddAWord) {
      if (checkRedundancy(state, event.word) == false) {
        state.add(event.word);
        yield state;
      } else {
        print('Word is present');
      }
    } else if (event is DeleteAWord) {
      if (checkRedundancy(state, event.word) == true) {
        state.remove(event.word);
        yield state;
      }
    }
    yield state;
  }

  bool checkRedundancy(List<String> state, String word) {
    return state.contains(word);
  }
}
