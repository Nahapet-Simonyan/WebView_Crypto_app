import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bin7r4decl/app.dart';

import '../../core/constants/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(
        builder: (_) => const App(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/logo.png'),
              SizedBox(
                height: 8,
                child: LinearProgressIndicator(
                  backgroundColor: AppColors.gray2,
                  color: AppColors.yellow,
                  borderRadius: BorderRadius.circular(27),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}