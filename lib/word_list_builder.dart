import 'package:flutter/material.dart';
import 'package:samsungnotes/word_list_tile.dart';

class WordListBuilder extends StatelessWidget {
  final List<String> wordList;

  const WordListBuilder({Key key, this.wordList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: wordList.length,
        itemBuilder: (context, index){
          return WordListTile(word: wordList[index]);
        });
  }
}
