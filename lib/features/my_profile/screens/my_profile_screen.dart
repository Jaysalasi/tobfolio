import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tob/core/theme/app_theme.dart';
import 'package:tob/core/utils/components/app_button.dart';
import 'package:tob/core/utils/constants/assets/svg.dart';
import 'package:tob/features/auth/bloc/auth_bloc.dart';
import 'package:tob/features/home/bloc/home_bloc.dart';
import 'package:tob/features/my_profile/screens/contact_us_screen.dart';
import 'package:tob/features/my_profile/screens/currency_screen.dart';
import 'package:tob/features/my_profile/screens/policy_screen.dart';
import 'package:tob/features/my_profile/screens/security_screen.dart';
import 'package:tob/features/my_profile/screens/terms_screen.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, homeState) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: theme.colorScheme.tertiary,
            title: Text(
              "Hi, ${homeState.dashboard?.userName ?? 'User'}",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      backgroundColor: theme.colorScheme.tertiary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              /// Avatar
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1507089947368-19c1da9775ae",
                    ),
                  ),

                  GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset(SvgAssets.edit),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// Settings List
              Expanded(
                child: ListView(
                  children: [
                    SettingsTile(
                      title: "Full Name",
                      trailingText: homeState.dashboard?.userName ?? "John Doe",
                      showArrow: false,
                      onTap: () {},
                    ),

                    SettingsTile(
                      title: "Currency",
                      trailingText: "USD",
                      showArrow: false,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CurrencyScreen(),
                          ),
                        );
                      },
                    ),

                    // SettingsTile(
                    //   title: "Security",
                    //   showArrow: true,
                    //   onTap: () {
                    //     Navigator.of(context).push(
                    //       MaterialPageRoute(
                    //         builder: (context) => const SecurityScreen(),
                    //       ),
                    //     );
                    //   },
                    // ),

                    SettingsTile(
                      title: "Contact Us",
                      showArrow: true,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ContactUsScreen(),
                          ),
                        );
                      },
                    ),

                    SettingsPremiumTile(
                      title: "Download Account Statement",
                      showArrow: true,
                      onTap: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => const PolicyScreen(),
                        //   ),
                        // );
                      },
                    ),
                    SettingsTile(
                      title: "Privacy Policy",
                      showArrow: true,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const PolicyScreen(),
                          ),
                        );
                      },
                    ),

                    SettingsTile(
                      title: "Terms & Conditions",
                      showArrow: true,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const TermsScreen(),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 20),

                    SignOutButton(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Center(
                                    child: Text(
                                      'Are you sure you want to sign out?',
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.titleLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    'For your security, when you sign out your passcode and touch id settings will reset.',
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 15),
                                  AppButton(
                                    borderRadius: 8,
                                    height: 40,
                                    fontSize: 12,
                                    title: "Sign Out",
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      context.read<AuthBloc>().add(
                                        LogoutRequested(),
                                      );
                                       Navigator.of(context).pushReplacementNamed('/login');
                                    },
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Cancel'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
         ) );
      },
    );
  }
}

class SettingsTile extends StatelessWidget {
  final String title;
  final String? trailingText;
  final bool showArrow;
  final VoidCallback? onTap;

  const SettingsTile({
    super.key,
    required this.title,
    this.trailingText,
    this.showArrow = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppTheme.lightSurfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.grayAltColor),
        ),
        child: Row(
          children: [
            Text(title, style: TextStyle(fontSize: 16)),

            const Spacer(),

            if (trailingText != null)
              Text(
                trailingText!,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),

            if (showArrow) const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
class SettingsPremiumTile extends StatelessWidget {
  final String title;
  final String? trailingText;
  final bool showArrow;
  final VoidCallback? onTap;

  const SettingsPremiumTile({
    super.key,
    required this.title,
    this.trailingText,
    this.showArrow = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppTheme.lightSurfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.grayAltColor),
        ),
        child: Row(
          children: [
            Text(title, style: TextStyle(fontSize: 16)),

            const Spacer(),

            if (trailingText != null)
              Text(
                trailingText!,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),

            if (showArrow) SvgPicture.asset(SvgAssets.premium),
          ],
        ),
      ),
    );
  }
}

class SignOutButton extends StatelessWidget {
  final VoidCallback onTap;
  const SignOutButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.grayAltColor),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        child: Text(
          "Sign Out",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
