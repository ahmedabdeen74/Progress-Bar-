import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final int currentPoints;
  final List<int> milestones;
  final Color progressColor;
  final Color? trackColor;
  final Widget? completedIcon;
  final Widget? pendingIcon;

  const CustomProgressBar({
    super.key,
    required this.currentPoints,
    required this.milestones,
    this.progressColor = Colors.blue,
    this.trackColor = const Color(0xFFE0E0E0),
    this.completedIcon,
    this.pendingIcon,
  });

  @override
  Widget build(BuildContext context) {
    if (milestones.isEmpty || milestones.length <= 1) {
      return const SizedBox.shrink();
    }

    const double iconSize = 24.0;

    return SizedBox(
      height: iconSize,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: List.generate(
              milestones.length + (milestones.length - 1),
              (index) {
                if (index % 2 == 0) {
                  int milestoneIndex = index ~/ 2;
                  bool isCompleted =
                      currentPoints >= milestones[milestoneIndex];

                  return isCompleted
                      ? (completedIcon ??
                            const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: iconSize,
                            ))
                      : (pendingIcon ??
                            Icon(
                              Icons.circle_outlined,
                              color: trackColor,
                              size: iconSize,
                            ));
                } else {
                  int segmentIndex = index ~/ 2;
                  int startValue = milestones[segmentIndex];
                  int endValue = milestones[segmentIndex + 1];
                  double segmentProgress = 0.0;
                  if (currentPoints >= endValue) {
                    segmentProgress = 1.0;
                  } else if (currentPoints > startValue) {
                    segmentProgress =
                        (currentPoints - startValue) / (endValue - startValue);
                  }

                  return Expanded(
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 9),
                          height: 6,
                          decoration: BoxDecoration(
                            color: trackColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: segmentProgress,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 9),
                            height: 6,
                            decoration: BoxDecoration(
                              color: progressColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
