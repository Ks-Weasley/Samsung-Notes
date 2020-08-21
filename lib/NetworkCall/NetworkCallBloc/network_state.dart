import '../json_to_dart.dart';

class NetworkCallState{}

class InitialState extends NetworkCallState{}

class Loading extends NetworkCallState{}

class SuccessfulCall extends NetworkCallState{
  SuccessfulCall({this.dictionary});

  final List<Dictionary> dictionary;
}

class FailedRequest extends NetworkCallState{}