class WordsRepository {
  WordsRepository(this.words);

  final List<String> words;

  void addWord(String word) {
    words.add(word);
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
}
