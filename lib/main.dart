import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Startup Name Generator',
      debugShowCheckedModeBanner: false,
      home: RandomWords(),
      );
  }
}
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        /*
        1-> The itemBuilder callback is called once per suggested
        word pairing, and places each suggestion into a ListTile row.
        For even rows, the function adds a ListTile row for the word pairing.
        For odd rows, the function adds a Divider widget to visually separate
        the entries.
        */
        itemBuilder: (context, i) {
          //Add a one-pixel-high divider widget before each row in the ListView
          if (i.isOdd) return Divider();
          /*
          The expression i ~/ 2 divides i by 2 and returns an integer result.
          For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
          This calculates the actual number of word pairings in the ListView,
          minus the divider widgets
          */
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            /*
             If you’ve reached the end of the available word pairings,
             then generate 10 more and add them to the suggestions list
             */
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }
  Widget _buildRow(WordPair pair) {
    final bool _alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        _alreadySaved ? Icons.favorite: Icons.favorite_border,
        color: _alreadySaved ? Colors.red: null,
      ),
    );
  }
}
