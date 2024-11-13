import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Animation Package")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExpandedImageView(
                      imagePath: 'assets/Bennett.png',
                      audioPath: 'BennettBurst.wav',
                      audioPlayer: _audioPlayer,
                    ),
                  ),
                );
              },
              icon: Hero(
                tag: 'hero-image-bennett',
                child: Image.asset(
                  'assets/Bennett.png',
                  width: 50,
                  height: 50,
                ),
              ),
              label: const Text("Show Bennett"),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExpandedImageView(
                      imagePath: 'assets/Fischl.png',
                      audioPath: 'FischlBurst.wav',
                      audioPlayer: _audioPlayer,
                    ),
                  ),
                );
              },
              icon: Hero(
                tag: 'hero-image-fischl',
                child: Image.asset(
                  'assets/Fischl.png',
                  width: 50,
                  height: 50,
                ),
              ),
              label: const Text("Show Fischl"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}

class ExpandedImageView extends StatelessWidget {
  final String imagePath;
  final String audioPath;
  final AudioPlayer audioPlayer;

  const ExpandedImageView({
    super.key,
    required this.imagePath,
    required this.audioPath,
    required this.audioPlayer,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = imagePath == 'assets/Bennett.png' ? Colors.orange : Colors.purple;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Audio Player Package"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: backgroundColor,
      body: Center(
        child: OpenContainer(
          closedElevation: 0,
          closedColor: Colors.transparent,
          closedBuilder: (BuildContext context, VoidCallback openContainer) {
            return Hero(
              tag: imagePath == 'assets/Bennett.png' ? 'hero-image-bennett' : 'hero-image-fischl',
              child: GestureDetector(
                onTap: () {
                  _playAudio(audioPath);
                },
                child: Image.asset(
                  imagePath,
                  width: 300,
                  height: 300,
                ),
              ),
            );
          },
          openBuilder: (BuildContext context, VoidCallback _) {
            return Scaffold(
              backgroundColor: backgroundColor,
              body: Center(
                child: Hero(
                  tag: imagePath == 'assets/Bennett.png' ? 'hero-image-bennett' : 'hero-image-fischl',
                  child: GestureDetector(
                    onTap: () {
                      _playAudio(audioPath);
                    },
                    child: Image.asset(
                      imagePath,
                      width: 300,
                      height: 300,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _playAudio(String audioPath) async {
    await audioPlayer.stop();
    await audioPlayer.play(AssetSource(audioPath));
  }
}
