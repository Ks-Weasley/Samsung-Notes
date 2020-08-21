abstract class NoteState {}

class DatabaseInitialized extends NoteState{}

class Empty extends NoteState {}

class WordFound extends NoteState {}

class WordNotFound extends NoteState {}

class SuccessfulUpdate extends NoteState {}

class UnsuccessfulUpdate extends NoteState {}

class DisplayWordsState extends NoteState {
  DisplayWordsState({this.words});

  final List<String> words;
}
class Searching extends NoteState{
  Searching({this.words});

  final List<String> words;
}

class Loading extends NoteState{}