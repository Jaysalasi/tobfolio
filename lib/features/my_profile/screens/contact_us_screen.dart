import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tob/core/utils/components/app_button.dart';
import 'package:tob/core/utils/constants/assets/svg.dart';
import 'package:tob/features/add_property/utils/alt_text_field.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
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
        title: const Text("Contact Us"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 30),
            Center(
              child: Text(
                "Let us know how we can help you",
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 30),
            AltTextField(label: "Name", hint: "Max"),
            AltTextField(label: "Email", hint: "max@example.com"),
            AltTextField(
              label: "Message",
              hint: "Your message here...",
              type: AltFieldType.multiline,
              maxLines: 4,
            ),
            SizedBox(height: 30),
            AppButton(title: "Send Message", onPressed: () {}),
            SizedBox(height: 20),
                Center(
                  child: Text(
                    "Or find us on",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                SvgPicture.asset(SvgAssets.twitterX),
                SvgPicture.asset(SvgAssets.tiktok),
                SvgPicture.asset(SvgAssets.insta),
                SvgPicture.asset(SvgAssets.thread),
              ],
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
