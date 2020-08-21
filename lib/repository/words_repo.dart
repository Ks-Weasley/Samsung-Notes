import 'package:shared_preferences/shared_preferences.dart';

class WordsRepository {
  WordsRepository({this.words});

  final List<String> words;

  Future<bool> addWord(String word) async {
    final bool result = await insertAWordToDatabase(word, word);
    words.add(word.trim());
    return result;
  }

  Future<bool> deleteWord(String word) async {
    final bool result = await deleteAWordFromDatabase(word);
    words.remove(word);
    return result;
  }

  Future<bool> clearAll() async{
    words.clear();
    return await clearAllInSharedPreferences();
  }

  bool checkRedundancy(String word) {
    if (word != null) {
      for (String existing in words) {
        if (existing.toLowerCase() == word.toLowerCase()) {
          return true;
        }
      }
    }
    return false;
  }

  List<String> matchingWords(String word) {
    final List<String> result = <String>[];
    for (String element in words) {
      if (element.toLowerCase().indexOf(word.toLowerCase()) == 0)
        result.add(element);
    }
    return result;
  }

  //DATABASE FUNCTIONS START HERE
  Future<bool> insertAWordToDatabase(String key, String word) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString(key, word);
  }

  Future<bool> deleteAWordFromDatabase(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.remove(key);
  }

  Future<bool> clearAllInSharedPreferences() async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.clear();
  }
}
