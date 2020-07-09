abstract class SearchState{}

class Searching extends SearchState{
  Searching({this.words});
  final List<String> words;
}

class SearchEmpty extends SearchState{}

class SearchCompleted extends SearchState{}
