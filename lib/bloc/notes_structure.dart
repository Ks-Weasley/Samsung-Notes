class Notes {
  List<String> words;

  void NewWord(String newWord) {
    words.add(newWord);
  }

  bool FindWord(String findWord) {
    return words.contains(findWord);
  }

  Future<bool> ClearList() async {
    await Future<Duration>.delayed(const Duration(seconds: 1));
    words.clear();
    return true;
  }
}
