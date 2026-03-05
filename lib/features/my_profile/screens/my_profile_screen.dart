import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tob/core/utils/constants/assets/svg.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
   Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.tertiary,
        title: Text("Hi, Divine", style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500)),
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
                    child: SvgPicture.asset(SvgAssets.edit))
                ],
              ),

              const SizedBox(height: 30),

              /// Settings List
              Expanded(
                child: ListView(
                  children: const [
                    SettingsTile(
                      title: "Full Name",
                      trailingText: "John Doe",
                      showArrow: false,
                    ),

                    SettingsTile(
                      title: "Currency",
                      trailingText: "USD",
                      showArrow: false,
                    ),

                    SettingsTile(
                      title: "Security",
                      showArrow: true,
                    ),

                    SettingsTile(
                      title: "Contact Us",
                      showArrow: true,
                    ),

                    SettingsTile(
                      title: "Privacy Policy",
                      showArrow: true,
                    ),

                    SettingsTile(
                      title: "Terms & Conditions",
                      showArrow: true,
                    ),

                    SizedBox(height: 20),

                    SignOutButton()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final String title;
  final String? trailingText;
  final bool showArrow;

  const SettingsTile({
    super.key,
    required this.title,
    this.trailingText,
    this.showArrow = false,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [

          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),

          const Spacer(),

          if(trailingText != null)
            Text(
              trailingText!,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),

          if(showArrow)
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            )

        ],
      ),
    );
  }
}

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      alignment: Alignment.center,
      child: const Text(
        "Sign Out",
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}