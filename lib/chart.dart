import 'package:chart_practice/app_colors.dart';
import 'package:chart_practice/batch.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartSample3 extends StatefulWidget {
  const PieChartSample3({super.key});

  @override
  State<StatefulWidget> createState() => PieChartSample3State();
}

class PieChartSample3State extends State<PieChartSample3> {
  int touchedIndex = -1;
  bool isInteractionDisabled = false;

  void _onSectionSelected(int index) {
    if (isInteractionDisabled) return;

    setState(() {
      touchedIndex = index;
      isInteractionDisabled = true;
    });

    // 少し待ってからページ遷移
    Future.delayed(const Duration(milliseconds: 600), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NextPage(touchedIndex: index),
        ),
      ).then((_) {
        setState(() {
          touchedIndex = -1;
          isInteractionDisabled = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: 1.2,
          child: PieChart(
            PieChartData(
              // pieTouchData: PieTouchData(
              //   touchCallback: (FlTouchEvent event, pieTouchResponse) {
              //     if (!event.isInterestedForInteractions ||
              //         pieTouchResponse?.touchedSection == null) {
              //       setState(() => touchedIndex = -1);
              //       return;
              //     }
              //     _onSectionSelected(
              //         pieTouchResponse!.touchedSection!.touchedSectionIndex);
              //   },
              // ),
              borderData: FlBorderData(show: false),
              sectionsSpace: 2,
              centerSpaceRadius: 50, // 真ん中の穴を大きく
              sections: showingSections(),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Column(
          children: List.generate(4, (index) {
            bool isSelected = index == touchedIndex;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                  onPressed: isInteractionDisabled
                      ? null
                      : () => _onSectionSelected(index),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      isSelected ? getSectionColor(index) : Colors.white,
                    ),
                    foregroundColor: WidgetStateProperty.all(
                      isSelected ? Colors.white : getSectionColor(index),
                    ),
                    textStyle: WidgetStateProperty.all(
                      const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    side: WidgetStateProperty.all(
                      const BorderSide(
                          color: AppColors.contentColorGray, width: 1),
                    ),
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                  ),
                  child: Text(getSectionTitle(index)),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 45.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      return PieChartSectionData(
        color: getSectionColor(i),
        value: 25,
        title: getSectionTitle(i),
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
        badgeWidget: IconBadge(
          'assets/icons/${getSectionTitle(i)}.svg',
          size: widgetSize,
          borderColor: AppColors.contentColorBlack,
        ),
        badgePositionPercentageOffset: 1.05,
      );
    });
  }

  Color getSectionColor(int index) {
    return [
      AppColors.contentColorRed,
      AppColors.contentColorBrown,
      AppColors.contentColorOrange,
      AppColors.contentColorPink
    ][index];
  }

  String getSectionTitle(int index) {
    return ["Fruits", "Nuts", "Syrup", "Flower"][index];
  }
}

class NextPage extends StatelessWidget {
  final int touchedIndex;

  const NextPage({super.key, required this.touchedIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Next Page")),
      body: Center(
        child: Text(
          "Selected: ${["Fruits", "Nuts", "Syrup", "Flower"][touchedIndex]}",
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
