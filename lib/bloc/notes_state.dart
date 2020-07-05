class NoteState {
  NoteState({this.words});

  List<String> words;
}

class Empty extends NoteState {
  Empty({List<String> words = const <String>[]});

}

class WordFound extends NoteState {}

class WordNotFound extends NoteState {}

class SuccessfulUpdate extends NoteState {}

class UnsuccessfulUpdate extends NoteState {}
