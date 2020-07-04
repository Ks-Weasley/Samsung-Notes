
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

class Update extends NoteEvents{}

class Search extends NoteEvents{}