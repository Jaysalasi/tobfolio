import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tobfolio/core/theme/app_theme.dart';
import 'package:tobfolio/core/utils/components/app_button.dart';
import 'package:tobfolio/core/utils/constants/assets/svg.dart';
import 'package:tobfolio/features/add_property/utils/alt_text_field.dart';

class ReferralPointsWithdrawScreen extends StatefulWidget {
  const ReferralPointsWithdrawScreen({super.key});

  @override
  State<ReferralPointsWithdrawScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralPointsWithdrawScreen> {
  int selected = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final size = MediaQuery.of(context).size;
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
        title: Text("Withdraw"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            Text(
              "Choose your account for this withdrawal",
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.lightSurfaceColor,
                border: Border.all(color: AppTheme.grayAltColor, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = 1;
                      });
                    },
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 10,
                      children: [
                        SvgPicture.asset(
                          selected == 1 ? SvgAssets.checked : SvgAssets.circle,
                        ),
                        Text(
                          "Withdraw to bank account",
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AltTextField(
                    label: "",
                    hint: "Select Bank",
                    items: ["access bank", "GT bank", "uba bank"],
                    type: AltFieldType.dropdown,
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.lightSurfaceColor,
                border: Border.all(color: AppTheme.grayAltColor, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = 2;
                      });
                    },
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 10,
                      children: [
                        SvgPicture.asset(
                          selected == 2 ? SvgAssets.checked : SvgAssets.circle,
                        ),
                        Text(
                          "Withdraw to bank account",
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 20, color: AppTheme.grayAltColor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "To paypal account",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            AltTextField(label: "Amount", hint: "Enter amount"),
            SizedBox(height: 20),
            // AltTextField(label: "PayPal Email", hint: "Enter PayPal email"),
            AppButton(title: "Withdraw", onPressed: () {}, isActive: false,),
          ],
        ),
      ),
    );
  }
}
