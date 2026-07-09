// import 'package:cti_yare_mehraban_test/features/stories/models/stories_item.dart';
import 'package:cti_yare_mehraban_test/features/stories/models/stories_item.dart';
import 'package:cti_yare_mehraban_test/features/stories/screens/stories_screen.dart';
import 'package:flutter/material.dart';

class StoriesPage extends StatelessWidget {
  StoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "📚 داستان‌ها",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),

        body: ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: stories.length,

          itemBuilder: (context, index) {
            final story = stories[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => StoryPage(story: stories[index]),
                  ),
                );
              },

              child: Container(
                height: 170,
                margin: const EdgeInsets.only(bottom: 20),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),

                  image: DecorationImage(
                    image: AssetImage(story.image),
                    fit: BoxFit.cover,
                  ),
                ),

                child: Container(
                  alignment: Alignment.bottomCenter,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),

                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(.7),
                        Colors.transparent,
                      ],

                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(15),

                    child: Text(
                      story.title,

                      style: const TextStyle(color: Colors.white, fontSize: 22),
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
}
