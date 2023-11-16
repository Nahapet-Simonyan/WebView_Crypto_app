import 'package:flutter/material.dart';
import 'package:bin7r4decl/components/custom_button.dart';
import 'package:bin7r4decl/features/app_menu/view/menu_screen.dart';
import 'package:bin7r4decl/features/onboarding/view/widget/onboarding_widget.dart';

import '../../../../core/constants/colors.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    navigatorPush() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AppMenu(),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(100.0),
                  onTap: () => navigatorPush(),
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: AppColors.gray3,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                const Flexible(
                  child: OnboardingWidget(
                    image: 'assets/images/on24.png',
                    title: 'Don\'t miss anything important',
                    subTitle: 'In our app',
                  ),
                ),
                const SizedBox(height: 32.0),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32.0).copyWith(
                    bottom: 32.0,
                  ),
                  child: CustomButton(
                    onTap: () {},
                    child: Text(
                      'Enable notifications',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Enter your name...
// 12.000 points
