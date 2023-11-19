import 'package:flutter/material.dart';

import 'package:bin7r4decl/core/constants/colors.dart';

class RelatedBarWidget extends StatelessWidget {
  const RelatedBarWidget({super.key, required this.downRatePercentage});

  final double downRatePercentage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$downRatePercentage %",
          style: const TextStyle(color: AppColors.red),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: LayoutBuilder(
              builder: (context, constrains) {
                const double indicatorHeight = 8.0;
                const double emptyWidth = 6.0;
                final double downWidth = downRatePercentage *
                    (constrains.maxWidth - emptyWidth) /
                    100;
                final double upWidth = (100 - downRatePercentage) *
                    (constrains.maxWidth - emptyWidth) /
                    100;

                return Row(
                  children: [
                    Container(
                      height: indicatorHeight,
                      width: downWidth,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: AppColors.red,
                      ),
                    ),
                    const SizedBox(
                      width: emptyWidth,
                    ),
                    Container(
                      height: indicatorHeight,
                      width: upWidth,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: AppColors.green,
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
        Text(
          "${100 - downRatePercentage} %",
          style: const TextStyle(color: AppColors.green),
        ),
      ],
    );
  }
}
