import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tobfolio/core/utils/components/constants.dart';
import 'package:tobfolio/core/utils/constants/assets/svg.dart';

class LeasePropertyScreen extends StatefulWidget {
  const LeasePropertyScreen({super.key});

  @override
  State<LeasePropertyScreen> createState() => _LeasePropertyScreenState();
}

class _LeasePropertyScreenState extends State<LeasePropertyScreen> {
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
        title: Text("Lease Property"),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 20),
            leasingCardMeth(
              title: "Lease Property",
              theme: theme,
              context: context,
              onTap: () {},
            ),
            SizedBox(height: 20),
            leasingCardMeth(
              title: "Stay assist",
              theme: theme,
              context: context,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector leasingCardMeth({
    required String title,
    required ThemeData theme,
    required BuildContext context,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: appShadow(context),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1507089947368-19c1da9775ae",
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
