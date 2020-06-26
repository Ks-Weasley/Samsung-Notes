import 'package:flutter/material.dart';

class Notes{
  List<String> words;

  void NewWord(String newWord){
    words.add(newWord);
  }
  bool FindWord(String findWord) {
    return words.contains(findWord);
  }
  Future<bool> ClearList() async{
    await Future.delayed(Duration(seconds: 1));
    words.clear();
    return true;
  }
}