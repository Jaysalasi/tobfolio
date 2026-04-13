import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:tob/core/utils/components/app_button.dart';
import 'package:tob/core/utils/constants/assets/svg.dart';

class Successful extends StatelessWidget {
  const Successful({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Lottie.asset('assets/lottie/confetti.json'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  Spacer(),
                  SvgPicture.asset(SvgAssets.good),
                  Text(
                    "Tenant created successfully",
                    style: theme.textTheme.headlineMedium,
                  ),
                  Spacer(),
                  AppButton(
                    title: "Close",
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
