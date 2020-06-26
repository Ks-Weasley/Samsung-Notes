import 'package:equatable/equatable.dart';

abstract class NoteState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Empty extends NoteState{}

class Redundant extends NoteState{}

class NotRedundant extends NoteState{}

class SuccessfulUpdate extends NoteState{}

class UnsuccessfulUpdate extends NoteState{}