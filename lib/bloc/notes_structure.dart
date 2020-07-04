class Notes {
  List<String> words;

  void newWord(String newWord) {
    words.add(newWord);
  }

  bool findWord(String findWord) {
    return words.contains(findWord);
  }

  Future<bool> clearList() async {
    await Future<Duration>.delayed(const Duration(seconds: 1));
    words.clear();
    return true;
  }
}
