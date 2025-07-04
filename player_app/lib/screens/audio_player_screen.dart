import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:player_app/providers/audio_player_provider.dart';


class AudioPlayerScreen extends StatelessWidget {
  const AudioPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioPlayerProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Player'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.6),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: screenWidth * 0.85,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white30, width: 1),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: screenWidth * 0.75,
                      ),
                      child: Text(
                        audioProvider.currentAudio.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Single row for all buttons with adjusted spacing
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildControlButton(Icons.replay_5, audioProvider.seekBackward, 28),
                          const SizedBox(width: 6), // Reduced spacing
                          _buildControlButton(Icons.skip_previous, audioProvider.previous, 30),
                          const SizedBox(width: 6),
                          _buildPlayPauseButton(audioProvider, 36),
                          const SizedBox(width: 6),
                          _buildControlButton(Icons.skip_next, audioProvider.next, 30),
                          const SizedBox(width: 6),
                          _buildControlButton(Icons.forward_5, audioProvider.seekForward, 28),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildControlButton(IconData icon, VoidCallback onPressed, double size) {
    return IconButton(
      icon: Icon(icon, size: size, color: Colors.white),
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(
        minWidth: size + 10, // Adjusted minimum width
        maxWidth: size + 10,
        minHeight: size + 10,
        maxHeight: size + 10,
      ),
    );
  }

  Widget _buildPlayPauseButton(AudioPlayerProvider provider, double size) {
    return Container(
      width: size + 10,
      height: size + 10,
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.5),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          provider.isPlaying ? Icons.pause : Icons.play_arrow,
          size: size,
          color: Colors.white,
        ),
        onPressed: () {
          if (provider.isPlaying) {
            provider.pause();
          } else {
            provider.play();
          }
        },
        padding: EdgeInsets.zero,
      ),
    );
  }
}