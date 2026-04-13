import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tob/core/theme/app_theme.dart';
import 'package:tob/core/utils/components/app_button.dart';
import 'package:tob/core/utils/components/constants.dart';
import 'package:tob/core/utils/components/widgets.dart';
import 'package:tob/core/utils/constants/assets/svg.dart';
import 'package:tob/features/add_property/utils/alt_text_field.dart';
import 'package:tob/features/tenant_profile/screens/tenant_profile_screen.dart';
import 'package:tob/features/tenants/bloc/tenant_bloc.dart';
import 'package:tob/features/tenants/bloc/tenant_event.dart';
import 'package:tob/features/tenants/bloc/tenant_state.dart';
import 'package:tob/features/tenants/screens/add_tenant.dart';
import 'package:tob/features/tenants/widgets/active_tenant_card.dart';
import 'package:tob/features/tenants/widgets/overdue_tenant_card.dart';

class TenantScreen extends StatefulWidget {
  const TenantScreen({super.key});

  @override
  State<TenantScreen> createState() => _TenantScreenState();
}

class _TenantScreenState extends State<TenantScreen> {
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    // Fetch tenants when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TenantBloc>().add(FetchTenants());
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.colorScheme.tertiary,
        title: Text(
          "Tenants",
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: plusButtonMeth(
              label: "Add Tenant",
              theme: theme,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddTenantScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: theme.colorScheme.tertiary,
      body: SafeArea(
        child: BlocBuilder<TenantBloc, TenantState>(
          builder: (context, state) {
            return Column(
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
                  child: BlocBuilder<TenantBloc, TenantState>(
                    builder: (context, tenantState) {
                      if (tenantState.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (tenantState.error != null) {
                        return Center(
                          child: Text(
                            'Error: ${tenantState.error}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }

                      final tenants = tenantState.tenants ?? [];
                      final now = DateTime.now();

                      // Separate tenants into active and overdue
                      final activeTenants = tenants.where((tenant) {
                        if (tenant['rentEnd'] == null) return true;
                        final rentEnd = DateTime.tryParse(tenant['rentEnd']?.toString() ?? '');
                        if (rentEnd == null) return true;
                        return rentEnd.isAfter(now);
                      }).toList();

                      final overdueTenants = tenants.where((tenant) {
                        if (tenant['rentEnd'] == null) return false;
                        final rentEnd = DateTime.tryParse(tenant['rentEnd']?.toString() ?? '');
                        if (rentEnd == null) return false;
                        return !rentEnd.isAfter(now);
                      }).toList();

                      final displayTenants = selectedTab == 0 ? activeTenants : overdueTenants;

                      if (displayTenants.isEmpty) {
                        return Center(
                          child: Text(
                            selectedTab == 0 ? 'No active tenants' : 'No overdue tenants',
                            style: theme.textTheme.bodyLarge,
                          ),
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<TenantBloc>().add(FetchTenants());
                        },
                        child: ListView.builder(
                          padding: const EdgeInsets.all(20),
                          itemCount: displayTenants.length,
                          itemBuilder: (context, index) {
                            final tenant = displayTenants[index];
                            return ActiveTenantCard(
                              tenant: tenant,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TenantProfileScreen(tenantId: tenant['_id']),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Column overdueCardMeth(
    ThemeData theme,
    BuildContext context,
    TenantState state,
  ) {
    return Column(
      children: [
        Container(
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
                        Text(
                          "6 days overdue",
                          style: theme.textTheme.bodyMedium,
                        ),
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
                          content: SizedBox(
                            height: 130,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'This will permanently evict your tenant. This action cannot be undone.',
                                ),
                                Row(
                                  spacing: 5,
                                  children: [
                                    SvgPicture.asset(SvgAssets.evict),
                                    Text(
                                      'Yes, I want to evict this tenant',
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                AppButton(
                                  title: 'Vacate',
                                  onPressed: () {
                                    // TODO: Implement eviction logic
                                  },
                                ),
                              ],
                            ),
                          ),
                          
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
                          content: BlocBuilder<TenantBloc, TenantState>(
                            builder: (context, state) {
                              return SizedBox(
                                height: 450,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                    AltTextField(
                                       onTap: () async {
                                        final DateTime? picked = await showDatePicker(
                                          context: context,
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.now().add(
                                            const Duration(days: 365),
                                          ),
                                        );
                                        if (picked != null) {
                                          // Format the date and update the state
                                          final formattedDate = "${picked.day}/${picked.month}/${picked.year}";
                                          context.read<TenantBloc>().add(
                                            UpdateRentFrequency(formattedDate),
                                          );
                                        }
                                      },
                                      label: "Renewal Date",
                                       
                                      hint: state.rentFrequency == ''
                                          ? "Select rent frequency"
                                          : state.rentFrequency,
                                      type: AltFieldType.text,
                                      enabled: true,
                                      onChanged: (value) {
                                        context.read<TenantBloc>().add(
                                          UpdateRentFrequency(value),
                                        );
                                      },
                                    ),
                                    AltTextField(
                                        onTap: () async {
                                          final DateTime? picked = await showDatePicker(
                                            context: context,
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.now().add(
                                              const Duration(days: 365),
                                            ),
                                          );
                                          if (picked != null) {
                                            // Format the date and update the state
                                            final formattedDate = "${picked.day}/${picked.month}/${picked.year}";
                                            context.read<TenantBloc>().add(
                                              UpdateRentFrequency(formattedDate),
                                            );
                                          }
                                        },
                                      label: "Rent Expiry Date",
                                      hint: state.rentFrequency == ''
                                          ? "Select rent expiry date"
                                          : state.rentFrequency,
                                      type: AltFieldType.text,
                                      enabled: true,
                                      onChanged: (value) {
                                        if (context.mounted) {
                                          context.read<TenantBloc>().add(
                                            UpdateRentFrequency(value),
                                          );
                                        }
                                      },
                                    ),
                                    AltTextField(
                                      label: "Rent Fee",
                                      hint: state.rentFee == ''
                                          ? "Enter rent fee"
                                          : state.rentFee,
                                      type: AltFieldType.text,
                                      onChanged: (value) {
                                        context.read<TenantBloc>().add(
                                          UpdateRentFee(value),
                                        );
                                      },
                                    ),
                                    AppButton(title: "Renew", onPressed: () {
                                      Navigator.pop(context);
                                    }),
                                  ],
                                ),
                              );
                            },
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
      ],
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
