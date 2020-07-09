abstract class SearchEvents{}

class SearchAWord extends SearchEvents{
  SearchAWord({this.word});

  final String word;

}

class SearchComplete{
  SearchComplete(this.word);
  
  final String word;

}
