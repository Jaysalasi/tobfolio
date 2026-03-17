import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tob/core/theme/app_theme.dart';
import 'package:tob/core/utils/components/constants.dart';
import 'package:tob/core/utils/components/widgets.dart';
import 'package:tob/core/utils/constants/assets/pngs.dart';
import 'package:tob/core/utils/constants/assets/svg.dart';
import 'package:tob/features/referral/screen/referral_reward_screen.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Invite Friends", style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    theme.colorScheme.secondary.withValues(alpha: 0.8),
                    theme.colorScheme.primary.withValues(alpha: 1),
                  ],
                ),
                boxShadow: appShadow(context),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    width: size.width * 0.5,
                    child: Column(
                      spacing: 5,
                      children: [
                        Text(
                          "Invite your friends and earn \$1",
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.surface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),                        
                        Text(
                          "Enjoy your rewards with your friends through our rewards points system.",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.surface,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    width: size.width * 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.asset(
                          AppImages.glassGiftBox,
                          width: 130,
                          height: 130,
                        ),
                        Row(
                          children: [
                            Text(
                              "Terms & Conditions Applied",
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.surface,
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                "Your Referral Link",
                style: theme.textTheme.bodyLarge?.copyWith( 
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: theme.colorScheme.primary, width: 1,),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    child: Text(
                      "https//www.tobfolio/register?invitecode=FISBA",
                      style: theme.textTheme.bodySmall?.copyWith( 
                      ),
                    ),
                  ),
                  plusButtonMeth(label: "Copy", theme: theme, icon: SvgAssets.copy, borderRadius: 16),
                  
                ],
              ),
            ),

            SizedBox(height: 20), 
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.lightSurfaceColor,
                border: Border.all(color: AppTheme.grayAltColor, width: 1,),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ReferralRewardScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Earned", style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),),
                
                    Row(children: [ 
                      Text("\$ 10", style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),),
                      Icon(Icons.arrow_forward_ios_rounded)
                    ],)
                  ],
                ),
              )  ,
              Divider(
                height:   20,
                color: AppTheme.grayAltColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Invitation Record", style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),),
                  Text("10", style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),),
                ],
              )    
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
