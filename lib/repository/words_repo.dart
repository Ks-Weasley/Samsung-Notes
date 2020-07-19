class WordsRepository {
  WordsRepository(this.words);

  final List<String> words;

  void addWord(String word) {
    words.add(word.trim());
  }

  void deleteWord(String word) {
    words.remove(word);
  }

  bool checkRedundancy(String word) {
    if (word != null) {
      for (String existing in words) {
        if (existing == word) {
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
}
