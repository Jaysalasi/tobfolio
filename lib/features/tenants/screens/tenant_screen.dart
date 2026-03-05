import 'package:flutter/material.dart';
import 'package:tob/core/theme/app_theme.dart';
import 'package:tob/core/utils/components/constants.dart';

class TenantScreen extends StatefulWidget {
  const TenantScreen({super.key});

  @override
  State<TenantScreen> createState() => _TenantScreenState();
}

class _TenantScreenState extends State<TenantScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.tertiary,
        title: Text("Tenants", style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500)),
        actions: [
          Container(
            height: 28,
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.circular(9),
              boxShadow: appShadow(context),
            ),
            child: Row(
              children: [
                Icon(Icons.add, color: Colors.white, size: 16),
                SizedBox(width: 3),
                Text(
                  "Add Tenant",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightSurfaceColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 10
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: theme.colorScheme.tertiary,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),

            /// TAB SWITCH
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                // height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.neutralColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    _tabButton("Active", 0, theme),
                    _tabButton("Overdue", 1, theme),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: 6,
                itemBuilder: (context, index) {
                  if (selectedTab == 0) {
                    return const ActiveTenantCard();
                  } else {
                    return const OverdueTenantCard();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabButton(String title, int index, ThemeData theme) {
    bool selected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = index;
          });
        },
        child: AnimatedContainer(
          height: 40,
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: selected ? theme.primaryColor : AppTheme.neutralColor,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: !selected ? theme.primaryColor : theme.colorScheme.surface,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class ActiveTenantCard extends StatelessWidget {
  const ActiveTenantCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: appShadow(context),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(
              "https://images.unsplash.com/photo-1507089947368-19c1da9775ae",
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bella J",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 8),

                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: .65,
                    backgroundColor: AppTheme.grayColor,
                    color: Colors.black,
                    minHeight: 2,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Room D5",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 4),
              Text(
                "128 days left",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.secondaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OverdueTenantCard extends StatelessWidget {
  const OverdueTenantCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: appShadow(context),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1507089947368-19c1da9775ae",
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bella J",
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text("6 days overdue", style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),

              Text(
                "Room D5",
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              expandedContainerMeth(theme: theme, text: 'Evict', onTap: () {}),

              SizedBox(width: 12),
              expandedContainerMeth(
                theme: theme,
                text: 'Renew',
                onTap: () {},
                bgColor: theme.primaryColor,
                txtColor: AppTheme.lightSurfaceColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Expanded expandedContainerMeth({
    required ThemeData theme,
    Color? bgColor,
    Function()? onTap,
    required String text,
    Color? txtColor,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 30,
          decoration: BoxDecoration(
            color: bgColor ?? theme.scaffoldBackgroundColor,
            border: Border.all(color: theme.primaryColor, width: 1),
            borderRadius: BorderRadius.circular(9.5),
          ),
          child: Center(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: txtColor ?? theme.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
