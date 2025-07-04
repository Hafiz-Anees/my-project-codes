import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:player_app/models/audio_file.dart';

class AudioPlayerProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<AudioFile> audioFiles = [];
  int _currentIndex = 0;
  bool _isPlaying = false;

  AudioPlayerProvider() {
    _initializeAudioFiles();
    _audioPlayer.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      notifyListeners();
    });
  }

  void _initializeAudioFiles() {
    // Add your audio files here
    audioFiles = [
      AudioFile(name: "Audio 1", path: "assets/audio1.mp3"),
      AudioFile(name: "Audio 2", path: "assets/audio2.mp3"),
      AudioFile(name: "Audio 3", path: "assets/audio3.mp3"),
    ];
  }

  bool get isPlaying => _isPlaying;
  int get currentIndex => _currentIndex;
  AudioFile get currentAudio => audioFiles[_currentIndex];

  Future<void> play() async {
    try {
      await _audioPlayer.setAsset(audioFiles[_currentIndex].path);
      await _audioPlayer.play();
      _isPlaying = true;
      notifyListeners();
    } catch (e) {
      debugPrint("Error playing audio: $e");
    }
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  Future<void> next() async {
    if (_currentIndex < audioFiles.length - 1) {
      _currentIndex++;
      await play();
    }
  }

  Future<void> previous() async {
    if (_currentIndex > 0) {
      _currentIndex--;
      await play();
    }
  }

  Future<void> seekForward() async {
    final newPosition = _audioPlayer.position + const Duration(seconds: 5);
    await _audioPlayer.seek(newPosition);
  }

  Future<void> seekBackward() async {
    final newPosition = _audioPlayer.position - const Duration(seconds: 5);
    await _audioPlayer.seek(newPosition);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}