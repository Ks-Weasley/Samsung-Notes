
import 'package:meta/meta.dart';

abstract class NoteEvents{

}

class AddAWord extends NoteEvents{
  final String word;

  AddAWord({@required this.word});
}

class FindAWord extends NoteEvents{
  final String word;

  FindAWord({@required this.word});
}

class DeleteAWord extends NoteEvents{
  final String word;

  DeleteAWord({@required this.word});

}
class ClearTheList extends NoteEvents{}