import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cti_yare_mehraban_test/core/constants/app_styles.dart';
import 'package:cti_yare_mehraban_test/core/widgets/custom_app_bar.dart';
import '../models/image_item.dart';

class MemoryGameScreen extends StatefulWidget {
  final int levelIndex; // 0: 4 cards, 1: 6 cards, 2: 8 cards

  const MemoryGameScreen({super.key, required this.levelIndex});

  @override
  State<MemoryGameScreen> createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> with TickerProviderStateMixin {
  late List<String> cards;
  late List<bool> flipped;
  List<int> selectedIndices = [];
  Set<int> matchedIndices = {};
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  bool boardLocked = false;

  final List<int> levelCardCounts = [4, 6, 8];

  @override
  void initState() {
    super.initState();
    setupLevel();
  }

  void setupLevel() {
    final totalCards = levelCardCounts[widget.levelIndex];
    final pairCount = totalCards ~/ 2;

    final allKeys = imageWords.map((e) => e['key']!).toList()..shuffle();
    final chosen = allKeys.take(pairCount).toList();
    cards = [...chosen, ...chosen]..shuffle();

    flipped = List.generate(cards.length, (_) => false);
    selectedIndices.clear();
    matchedIndices.clear();

    _controllers = List.generate(
      cards.length,
          (_) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );

    _animations = _controllers
        .map((controller) => Tween<double>(begin: 0.0, end: 1.0).animate(controller))
        .toList();
  }

  void handleTap(int index) {
    if (flipped[index] || selectedIndices.length == 2 || boardLocked) return;

    setState(() {
      flipped[index] = true;
      selectedIndices.add(index);
    });

    _controllers[index].forward();

    if (selectedIndices.length == 2) {
      boardLocked = true;

      final first = selectedIndices[0];
      final second = selectedIndices[1];

      if (cards[first] == cards[second]) {
        matchedIndices.addAll([first, second]);
        selectedIndices.clear();
        boardLocked = false;

        if (matchedIndices.length == cards.length) {
          Future.delayed(const Duration(milliseconds: 700), showEndDialog);
        }
      } else {
        Future.delayed(const Duration(milliseconds: 700), () {
          _controllers[first].reverse();
          _controllers[second].reverse();
          setState(() {
            flipped[first] = false;
            flipped[second] = false;
            selectedIndices.clear();
            boardLocked = false;
          });
        });
      }
    }
  }

  void showEndDialog() {
    showDialog(
      context: context,
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text('🎉 آفرین'),
          content: const Text('تمام تصاویر را درست پیدا کردی!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (widget.levelIndex < 2) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MemoryGameScreen(levelIndex: widget.levelIndex + 1),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MemoryGameScreen(levelIndex: 2),
                    ),
                  );                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.arrow_circle_right, color: AppColors.primary),
                  Text('   مرحله بعد', style: TextStyle(color: AppColors.primary)),
                  SizedBox(width: 15),
                ],
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('بازگشت', style: TextStyle(color: AppColors.primary)),
                  SizedBox(width: 15),
                  Icon(Icons.arrow_circle_left, color: AppColors.primary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(int index) {
    final isFlipped = flipped[index] || matchedIndices.contains(index);
    final imgKey = cards[index];

    return GestureDetector(
      onTap: () => handleTap(index),
      child: AnimatedBuilder(
        animation: _animations[index],
        builder: (context, child) {
          final angle = _animations[index].value * pi;
          final isUnderHalf = angle <= pi / 2;

          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            alignment: Alignment.center,
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
                ),
                child: isUnderHalf
                    ? Padding(
                  padding: const EdgeInsets.all(4),
                  child: Image.asset(
                    'assets/images/back_card.webp',
                    fit: BoxFit.cover,
                  ),
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/words/$imgKey.webp',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      appBar: buildAppBar(context, 'بازی حافظه'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: GridView.builder(
          itemCount: cards.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) => buildCard(index),
        ),
      ),

    );
  }
}
