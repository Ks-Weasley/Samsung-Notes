
import 'package:meta/meta.dart';

abstract class NoteEvents{}

class AddAWord extends NoteEvents{
  AddAWord({@required this.word});

  final String word;
}

class FindAWord extends NoteEvents{
  FindAWord({@required this.word});

  final String word;
}

class DeleteAWord extends NoteEvents{
  DeleteAWord({@required this.word});
  final String word;
}
class ClearTheList extends NoteEvents{}

class SearchAWord extends NoteEvents{
  SearchAWord({@required this.word});

  final String word;
}
class SearchDone extends NoteEvents{}