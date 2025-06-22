import 'package:flutter/material.dart';

import '../../../core/constants/app_styles.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../services/alphabet_service.dart';
import '../widgets/letter_button.dart';
import '../widgets/path_segment_painter.dart';
import 'letter_screen.dart';

class AlphabetScreen extends StatelessWidget {
  const AlphabetScreen({super.key});

  final List<String> letters = const [
    'ا', 'آ', 'ب', 'پ', 'ت', 'ث', 'ج', 'چ', 'ح', 'خ', 'د',
    'ذ', 'ر', 'ز', 'ژ', 'س', 'ش', 'ص', 'ض', 'ط', 'ظ',
    'ع', 'غ', 'ف', 'ق', 'ک', 'گ', 'ل', 'م', 'ن', 'و', 'ه', 'ی'
  ];

  @override
  Widget build(BuildContext context) {
    const double itemHeight = 110;

    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,

      appBar: buildAppBar(context, 'آموزش الفبا'),
      body: FutureBuilder<int>(
        future: ProgressService.getLearnedCount(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("خطا در بارگذاری اطلاعات"));
          }

          final int learnedCount = snapshot.data!;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: LinearProgressIndicator(
                  value: learnedCount / letters.length,
                  backgroundColor: Colors.white,
                  color: AppColors.primary,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: letters.length,
                  itemExtent: itemHeight,
                  itemBuilder: (context, index) {
                    final bool isActive = index <= learnedCount;

                    return Stack(
                      children: [
                        if (index < letters.length - 1)
                          CustomPaint(
                            painter: PathSegmentPainter(
                              fromLeft: index.isEven,
                              toLeft: (index + 1).isEven,
                              itemHeight: itemHeight,
                            ),
                            size: Size.infinite,
                          ),
                        Align(
                          alignment: index.isEven
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: LetterButton(
                            text: letters[index],
                            isActive: isActive,
                            onPressed: isActive
                                ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LetterDetailPage(
                                    letter: letters[index],
                                    index: index,
                                  ),
                                ),
                              );
                            }
                                : null,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
