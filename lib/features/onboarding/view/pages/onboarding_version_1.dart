import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:bin7r4decl/components/custom_button.dart';
import 'package:bin7r4decl/core/constants/colors.dart';
import 'package:bin7r4decl/features/app_menu/view/pages/menu_screen.dart';

import '../widget/onboarding_widget.dart';

final version1Pages = [
  const OnboardingWidget(
    image: 'assets/images/on11.png',
    title: 'Practice on our simulator',
    subTitle: 'In our app',
  ),
  const OnboardingWidget(
    image: 'assets/images/on12.png',
    title: 'Practice on our simulator',
    subTitle: 'In our app',
  ),
];

class OnboardingVersion1 extends StatefulWidget {
  const OnboardingVersion1({super.key});

  @override
  State<OnboardingVersion1> createState() => _OnboardingVersion1State();
}

class _OnboardingVersion1State extends State<OnboardingVersion1> {
  final pages = [];
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final PageController controller = PageController();

    navigatorPush() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AppMenu(),
        ),
      );
    }

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: PageView.builder(
              controller: controller,
              onPageChanged: (int page) => setState(() {
                currentPage = page;
              }),
              itemCount: version1Pages.length,
              itemBuilder: (BuildContext context, int index) {
                return version1Pages[index];
              },
            ),
          ),
          const SizedBox(height: 32.0),
          PageViewDotIndicator(
            currentItem: currentPage,
            count: version1Pages.length,
            unselectedColor: AppColors.gray2,
            selectedColor: AppColors.yellow,
            size: const Size(8, 8),
            unselectedSize: const Size(8, 8),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: CustomButton(
              onTap: () {
                controller.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear,
                );
                if (currentPage == 1) navigatorPush();
              },
              child: Text(
                'Next',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.scaffoldBackgroundColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32.0),
        ],
      ),
    );
  }
}
