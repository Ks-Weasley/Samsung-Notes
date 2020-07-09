import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samsungnotes/SearchBloc/search_events.dart';
import 'package:samsungnotes/SearchBloc/search_state.dart';
import 'package:samsungnotes/repository/words_repo.dart';

class SearchBloc extends Bloc<SearchEvents, SearchState>{
  SearchBloc({this.repo});

  final WordsRepository repo;

  @override
  // TODO: implement initialState
  SearchState get initialState => SearchEmpty();

  @override
  Stream<SearchState> mapEventToState(SearchEvents event) async*{
    // TODO: implement mapEventToState
    if(event is SearchAWord){
      final List<String> result = repo.matchingWords(event.word);
      yield Searching(words: result);
    }
    else
      yield SearchCompleted();
  }
  
}