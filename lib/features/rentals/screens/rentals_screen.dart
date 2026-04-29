import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobfolio/core/router/app_router.dart';
import 'package:tobfolio/core/theme/app_theme.dart';
import 'package:tobfolio/core/utils/components/constants.dart';
import 'package:tobfolio/features/all_properties/bloc/all_properties_bloc.dart';
import 'package:tobfolio/features/all_properties/bloc/all_properties_event.dart';
import 'package:tobfolio/features/all_properties/bloc/all_properties_state.dart';
import 'package:tobfolio/features/all_properties/repositories/all_properties_repository.dart';
import 'package:tobfolio/features/home/bloc/home_bloc.dart';

class RentalsScreen extends StatefulWidget {
  const RentalsScreen({super.key});

  @override
  State<RentalsScreen> createState() => _RentalsScreenState();
}

class _RentalsScreenState extends State<RentalsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, homeState) {
        if (homeState.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: theme.colorScheme.tertiary,
              title: Text(
                "Rentals",
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
                        OccupancyCard(
                          theme: theme,
                          occupancyRate:
                              homeState.dashboard?.occupancyRate?.toDouble() ??
                              0.0,
                        ),
                        StatCard(
                          theme: theme,
                          title: "Occupied Units",
                          value:
                              homeState.dashboard?.occupiedUnits?.toString() ??
                              "0",
                        ),
                        StatCard(
                          theme: theme,
                          title: "Vacant Units",
                          value:
                              homeState.dashboard?.vacantUnits?.toString() ??
                              "0",
                        ),
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
                            Navigator.pushNamed(
                              context,
                              AppRouter.allProperties,
                            );
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

                    Expanded(
                      child: BlocProvider(
                        create: (context) => AllPropertyBloc(
                          repository: context.read<AllPropertiesRepository>(),
                        )..add(LoadProperties()),
                        child: RefreshIndicator(
                          onRefresh: () async {
                            context.read<AllPropertyBloc>().add(
                              LoadProperties(),
                            );
                          },
                          child: BlocBuilder<AllPropertyBloc, AllPropertyState>(
                            builder: (context, state) {
                              if (state is PropertyLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (state is PropertyError) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Error: ${state.message}',
                                        style: const TextStyle(
                                          color: Colors.red,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 16),
                                      ElevatedButton(
                                        onPressed: () {
                                          context.read<AllPropertyBloc>().add(
                                            LoadProperties(),
                                          );
                                        },
                                        child: const Text('Retry'),
                                      ),
                                    ],
                                  ),
                                );
                              }

                              if (state is PropertyLoaded) {
                                if (state.properties.isEmpty) {
                                  return const Center(
                                    child: Text("No properties"),
                                  );
                                }

                                return ListView.builder(
                                  padding: const EdgeInsets.all(0),
                                  itemCount: state.properties.length,
                                  itemBuilder: (context, index) {
                                    return PropertyTile(
                                      theme: theme,
                                      propertyName:
                                          state.properties[index].name,
                                      unit: state.properties[index].units,
                                    );
                                  },
                                );
                              }

                              return const Center(
                                child: Text("No data available"),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
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
                      fontStyle: FontStyle.italic,
                      color: AppTheme.accentColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
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
  final double occupancyRate;

  const OccupancyCard({
    super.key,
    required this.theme,
    required this.occupancyRate,
  });

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
                    duration: Duration(seconds: 1),
                    tween: Tween<double>(begin: 0, end: occupancyRate),
                    builder: (context, double value, child) {
                      return CircularProgressIndicator(
                        value: value,
                        strokeWidth: 6,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppTheme.accentColor,
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  // "${(occupancyRate * 100).round()}%",
                  "$occupancyRate %",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.accentColor,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
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
  final String propertyName;
  final int unit;
  const PropertyTile({
    super.key,
    required this.theme,
    required this.propertyName,
    required this.unit,
  });

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
          Expanded(child: Text(propertyName, style: theme.textTheme.bodyLarge)),
          Text(
            "$unit Unit(s)",
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
