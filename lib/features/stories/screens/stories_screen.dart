import 'package:audioplayers/audioplayers.dart';
import 'package:cti_yare_mehraban_test/features/stories/models/stories_item.dart';
import 'package:flutter/material.dart';

class StoryPage extends StatefulWidget {
  final Story story;

  const StoryPage({super.key, required this.story});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  final player = AudioPlayer();
  bool isPlaying = false;

  void toggleAudio() async {
    if (isPlaying) {
      await player.pause();
    } else {
      await player.play(AssetSource(widget.story.audio));
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.orange.shade50,

          appBar: AppBar(
            title: Text(
              widget.story.title,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Color(0xFF2E473B),
          ),

          body: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    widget.story.image,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  GestureDetector(
                    onTap: toggleAudio,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color(0xFF2E473B).withOpacity(0.7),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 10),
                        ],
                      ),
                      child: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      child: Text(
                        widget.story.text,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 18, height: 1.8),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
