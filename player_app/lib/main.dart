import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:player_app/providers/audio_player_provider.dart';
import 'package:player_app/screens/audio_player_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AudioPlayerProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AudioPlayerScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}