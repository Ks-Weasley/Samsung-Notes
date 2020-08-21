import 'package:flutter/material.dart';
import 'package:samsungnotes/word_list_tile.dart';

class WordListBuilder extends StatelessWidget {
  const WordListBuilder({Key key, this.wordList}) : super(key: key);

  final List<String> wordList;

  @override
  Widget build(BuildContext context) {
    return wordList!=null ? ListView.builder(
        itemCount: wordList.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              WordListTile(word: wordList[index]),
              const Divider(
                thickness: 2.0,
                color: Colors.amberAccent,
              )
            ],
          );
        }): Container();
  }
}
