import 'package:flutter/material.dart';
import 'package:tob/core/router/app_router.dart';
import 'package:tob/core/theme/app_theme.dart';
import 'package:tob/core/utils/components/constants.dart';

class RentalsScreen extends StatelessWidget {
  const RentalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.tertiary,
        title: Text("Rentals", style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500)),
      ),
      backgroundColor: theme.colorScheme.tertiary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              const SizedBox(height: 25),

              /// Stats Grid
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                childAspectRatio: 0.96,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  OccupancyCard(theme: theme),
                  StatCard(theme: theme, title: "Occupied Units", value: "12"),
                  StatCard(theme: theme, title: "Vacant Units", value: "12"),
                ],
              ),

              const SizedBox(height: 30),

              /// Properties header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Properties",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontSize: 20,
                      color: AppTheme.secondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRouter.allProperties);
                    },
                    child: Text(
                      "View All",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppTheme.accentColor,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// Properties List
              Expanded(
                child: ListView(
                  children: [
                    PropertyTile(theme: theme),
                    PropertyTile(theme: theme),
                    PropertyTile(theme: theme),
                    PropertyTile(theme: theme),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final ThemeData theme;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 160,
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: appShadow(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.bodyLarge),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    value,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontStyle: FontStyle.italic,color: AppTheme.accentColor,
                      fontSize: 25,fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OccupancyCard extends StatelessWidget {
  final ThemeData theme;
  const OccupancyCard({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 160,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: appShadow(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text("Occupancy \nRate", style: theme.textTheme.bodyLarge),
          SizedBox(height: 10),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 58,
                  height: 58,
                  child: TweenAnimationBuilder(
                    tween: Tween(begin: 0.0, end: 0.50),
                    duration: Duration(milliseconds: 900),
                    builder: (context, value, child) {
                      return CircularProgressIndicator(
                        value: value,
                        strokeWidth: 8,
                        color: AppTheme.accentColor,
                        backgroundColor: AppTheme.grayColor,
                      );
                    },
                  ),
                ),
                Text(
                  "50%",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.accentColor,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PropertyTile extends StatelessWidget {
  final ThemeData theme;
  const PropertyTile({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.grayColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text("Property Name", style: theme.textTheme.bodyLarge),
          ),
          Text(
            "7 Unit",
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
