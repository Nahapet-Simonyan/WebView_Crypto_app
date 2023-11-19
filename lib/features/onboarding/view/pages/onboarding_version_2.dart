import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:bin7r4decl/components/custom_button.dart';
import 'package:bin7r4decl/core/constants/colors.dart';
import 'package:bin7r4decl/features/app_menu/view/pages/menu_screen.dart';
import 'package:bin7r4decl/features/onboarding/view/pages/telegram_page.dart';

import '../widget/onboarding_widget.dart';
import 'notification_page.dart';

final version2Pages = [
  const OnboardingWidget(
    image: 'assets/images/on11.png',
    title: 'Practice on our simulator',
    subTitle: 'In our app',
  ),
  const OnboardingWidget(
    image: 'assets/images/on22.png',
    title: 'Practice on our simulator',
    subTitle: 'In our app',
  ),
];

class OnboardingVersion2 extends StatefulWidget {
  const OnboardingVersion2({super.key});

  @override
  State<OnboardingVersion2> createState() => _OnboardingVersion2State();
}

class _OnboardingVersion2State extends State<OnboardingVersion2> {
  final pages = [];
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final PageController controller = PageController();

    void navigatorPush() {
      bool needManagerScreen =
          FirebaseRemoteConfig.instance.getBool('needManagerScreen');
      bool needTg = FirebaseRemoteConfig.instance.getBool('needTg');
      String tg = FirebaseRemoteConfig.instance.getString('tg');
      if (needTg == true && tg.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TelegramPage(tg: tg),
          ),
        );
      } else if (needManagerScreen == true) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NotificationPage(),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AppMenu(),
          ),
        );
      }
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
              itemCount: version2Pages.length,
              itemBuilder: (BuildContext context, int index) {
                return version2Pages[index];
              },
            ),
          ),
          const SizedBox(height: 32.0),
          PageViewDotIndicator(
            currentItem: currentPage,
            count: version2Pages.length,
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
