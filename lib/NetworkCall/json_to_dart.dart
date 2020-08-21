// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Dictionary> dictionaryFromJson(String str) => List<Dictionary>.from(json.decode(str).map((dynamic x) => Dictionary.fromJson(x)));

String dictionaryToJson(List<Dictionary> data) => json.encode(List<dynamic>.from(data.map<dynamic>((dynamic x) => x.toJson())));

class Dictionary {
  Dictionary({
    this.word,
    this.phonetics,
    this.meanings,
  });
  factory Dictionary.fromJson(Map<String, dynamic> json) => Dictionary(
    word: json['word'],
    phonetics: List<Phonetic>.from(json['phonetics'].map((dynamic x) => Phonetic.fromJson(x))),
    meanings: List<Meaning>.from(json['meanings'].map((dynamic x) => Meaning.fromJson(x))),
  );

  final String word;
  final List<Phonetic> phonetics;
  final List<Meaning> meanings;


  Map<String, dynamic> toJson() => <String, dynamic>{
    'word': word,
    'phonetics': List<dynamic>.from(phonetics.map<dynamic>((Phonetic x) => x.toJson())),
    'meanings': List<dynamic>.from(meanings.map<dynamic>((Meaning x) => x.toJson())),
  };
}

class Meaning {
  Meaning({
    this.partOfSpeech,
    this.definitions,
  });

  factory Meaning.fromJson(Map<String, dynamic> json) => Meaning(
    partOfSpeech: json['partOfSpeech'],
    definitions: List<Definition>.from(json['definitions'].map((dynamic x) => Definition.fromJson(x))),
  );

  final String partOfSpeech;
  final List<Definition> definitions;



  Map<String, dynamic> toJson() => <String, dynamic>{
    'partOfSpeech': partOfSpeech,
    'definitions': List<dynamic>.from(definitions.map<dynamic>((dynamic x) => x.toJson())),
  };
}

class Definition {
  Definition({
    this.definition,
    this.example,
    this.synonyms,
  });

  factory Definition.fromJson(Map<String, dynamic> json) => Definition(
    definition: json['definition'],
    example: json['example'] == null ? null : json['example'],
    synonyms: json['synonyms'] == null ? null : List<String>.from(json['synonyms'].map((String x) => x)),
  );

  final String definition;
  final String example;
  final List<String> synonyms;



  Map<String, dynamic> toJson() => <String, dynamic>{
    'definition': definition,
    'example': example == null ? null : example,
    'synonyms': synonyms == null ? null : List<dynamic>.from(synonyms.map<dynamic>((dynamic x) => x)),
  };
}

class Phonetic {
  Phonetic({
    this.text,
    this.audio,
  });

  factory Phonetic.fromJson(Map<String, dynamic> json) => Phonetic(
    text: json['text'],
    audio: json['audio'],
  );

  final String text;
  final String audio;



  Map<String, dynamic> toJson() => <String, dynamic>{
    'text': text,
    'audio': audio,
  };
}
