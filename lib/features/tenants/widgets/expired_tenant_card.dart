import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tob/core/theme/app_theme.dart';
import 'package:tob/core/utils/components/constants.dart';
import 'package:tob/features/add_property/utils/alt_text_field.dart';
import 'package:tob/features/tenants/bloc/tenant_bloc.dart';
import 'package:tob/features/tenants/bloc/tenant_event.dart';
import 'package:tob/features/tenants/bloc/tenant_state.dart';
import 'package:tob/features/tenants/widgets/overdue_tenant_card.dart';

class ExpiredTenantCard extends StatelessWidget {
  final Map<String, dynamic> tenant;
  final TenantState state;
  final VoidCallback onTap;
  const ExpiredTenantCard({
    super.key,
    required this.tenant,
    required this.state,
    required this.onTap,
  });

  double _calculateProgress() {
    try {
      final now = DateTime.now();
      final rentEndStr = tenant['rentEnd']?.toString();

      if (rentEndStr == null) {
        return 0.0;
      }

      final rentEnd = DateTime.tryParse(rentEndStr);

      if (rentEnd == null) {
        return 0.0;
      }

      // Calculate days left
      final daysLeft = rentEnd.difference(now).inDays;

      if (daysLeft <= 0) {
        return 1.0; // 100% complete (expired)
      }

      // Create percentage based on user requirements
      double percentage;
      if (daysLeft > 100) {
        // If days left > 100, use daysLeft/1000
        percentage = daysLeft / 1000;
      } else {
        // If days left <= 100, use daysLeft/100
        percentage = daysLeft / 100;
      }

      // Clamp between 0.0 and 1.0
      if (percentage < 0.0) return 0.0;
      if (percentage > 1.0) return 1.0;

      return percentage;
    } catch (e) {
      return 0.0;
    }
  }

  String _calculateDaysLeft() {
    try {
      final now = DateTime.now();
      final rentEndStr = tenant['rentEnd']?.toString();
      final rentStartStr = tenant['rentStart']?.toString();

      if (rentEndStr == null || rentStartStr == null) {
        return 'Unknown';
      }

      final rentEnd = DateTime.tryParse(rentEndStr);
      final rentStart = DateTime.tryParse(rentStartStr);

      if (rentEnd == null || rentStart == null) {
        return 'Unknown';
      }

      // Calculate remaining days
      final remainingDays = rentEnd.difference(now).inDays;

      if (remainingDays <= 0) {
        return 'Expired';
      }

      return '$remainingDays days left';
    } catch (e) {
      return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: appShadow(context),
            ),
            child: Column(
              children: [
                Row(
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
                            tenant['name'] ?? '',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const SizedBox(height: 8),

                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: _calculateProgress(),
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
                          tenant['unitNumber'] ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          _calculateDaysLeft(),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    expandedContainerMeth(
                      state: TenantState(),
                      theme: theme,
                      text: 'Evict',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            title: Text('Are you sure?'),
                            content: const Text(
                              'This will permanently evict your tenant. This action cannot be undone.',
                            ),
                            // actions: [
                            //   TextButton(
                            //     onPressed: () => Navigator.of(context).pop(),
                            //     child: const Text('Cancel'),
                            //   ),
                            //   TextButton(
                            //     onPressed: () {
                            //       // Navigator.of(context).pop();
                            //       // context.read<AuthBloc>().add(
                            //       //   LogoutRequested(),
                            //       // );
                            //     },
                            //     child: const Text('Logout'),
                            //   ),
                            // ],
                          ),
                        );
                      },
                    ),

                    SizedBox(width: 12),
                    expandedContainerMeth(
                      state: TenantState(),
                      theme: theme,
                      text: 'Renew',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            // title: Text('Are you sure?'),
                            content: SizedBox(
                              height: 300,
                              child: Column(
                                children: [
                                  AltTextField(
                                    label: "Rent Frequency",
                                    items: ["Monthly", "Quarterly", "Yearly"],
                                    hint: state.rentFrequency == ''
                                        ? "Select rent frequency"
                                        : state.rentFrequency,
                                    type: AltFieldType.dropdown,
                                    onChanged: (value) {
                                      context.read<TenantBloc>().add(
                                        UpdateRentFrequency(value),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      bgColor: theme.primaryColor,
                      txtColor: AppTheme.lightSurfaceColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
