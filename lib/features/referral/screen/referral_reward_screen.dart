import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tobfolio/core/utils/components/app_button.dart';
import 'package:tobfolio/core/utils/components/constants.dart';
import 'package:tobfolio/core/utils/constants/assets/svg.dart';
import 'package:tobfolio/features/referral/screen/referral_points_withdraw_screen.dart';

class ReferralRewardScreen extends StatefulWidget {
  const ReferralRewardScreen({super.key});

  @override
  State<ReferralRewardScreen> createState() => _ReferralRewardScreenState();
}

class _ReferralRewardScreenState extends State<ReferralRewardScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.tertiary,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(SvgAssets.backOutline),
        ),
        backgroundColor: theme.colorScheme.tertiary,
        title: Text("Referral"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),

                boxShadow: appShadow(context),
              ),
              child: Row(
                spacing: 10,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(SvgAssets.pokemon),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Text(
                        "Your reward",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          // color: theme.colorScheme.surface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "1",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              // color: theme.colorScheme.surface,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            "/10",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              // color: theme.colorScheme.surface,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(height: 20),
            AppButton(title: "Withdraw", onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ReferralPointsWithdrawScreen()));
            }),
           ],
        ),
      ),
    );
  }
}
