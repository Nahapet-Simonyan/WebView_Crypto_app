import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:telegram/telegram.dart';
import 'package:bin7r4decl/components/custom_button.dart';
import 'package:bin7r4decl/core/constants/colors.dart';
import 'package:bin7r4decl/features/app_menu/app_menu.dart';
import 'package:bin7r4decl/features/onboarding/view/pages/notification_page.dart';
import 'package:bin7r4decl/features/onboarding/view/widget/onboarding_widget.dart';

class TelegramPage extends StatelessWidget {
  const TelegramPage({super.key, required this.tg});

  final String tg;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    navigatorPush() {
      bool needManagerScreen = FirebaseRemoteConfig.instance.getBool(
        'needManagerScreen',
      );
      if (needManagerScreen == true) {
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
                  onTap: () {
                    navigatorPush();
                  },
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Flexible(
                  child: OnboardingWidget(
                    image: 'assets/images/on23.png',
                    title: 'Join our Telegram Channel',
                    subTitle: 'And trade with our team',
                  ),
                ),
                const SizedBox(height: 32.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: CustomButton(
                    color: const Color(0xff00AEED),
                    onTap: () {
                      Telegram.send(
                        username: tg,
                        message: '',
                      );
                    },
                    child: Row(
                      children: [
                        Image.asset('assets/icons/telegram_icon.png'),
                        Text(
                          'Join',
                          style: theme.textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
