import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class Phrase {
  String text;
  String path;

  Phrase({required this.text, required this.path});
}

class _HomePageState extends State<HomePage> {
  bool enabled = true;
  AudioCache player = AudioCache(prefix: 'assets/audio/');
  final List<Phrase> phrases = [
    Phrase(text: 'Bună ziua', path: 'sample1RO.mp3'),
    Phrase(text: 'Bună ziua\n(Franceză)', path: 'sample1FR.mp3'),
    Phrase(text: 'De ce mai suntem aici?', path: 'sample2RO.mp3'),
    Phrase(text: 'De ce mai suntem aici?\n(Franceză)', path: 'sample2FR.mp3'),
    Phrase(text: 'O mașină parcată pe dos', path: 'sample3RO.mp3'),
    Phrase(text: 'O mașină parcată pe dos\n(Franceză)', path: 'sample3FR.mp3'),
    Phrase(text: 'Plec departe, plec pe Marte', path: 'sample4RO.mp3'),
    Phrase(text: 'Plec departe, plec pe Marte\n(Franceză)', path: 'sample4FR.mp3')
  ];

  void _onTap(String path) {
    setState(() {
      enabled = !enabled;
    });
    Timer(
      const Duration(milliseconds: 2000),
      () => setState(() {
        enabled = !enabled;
      }),
    );
    player.play(path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Phrases'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsetsDirectional.all(10),
        itemCount: phrases.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 32,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (BuildContext ctx, int index) {
          Phrase crtPhrase = phrases[index];
          return InkWell(
            onTap: enabled ? () => _onTap(crtPhrase.path) : null,
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.blue.shade800,
                    Colors.lightBlueAccent,
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  crtPhrase.text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
