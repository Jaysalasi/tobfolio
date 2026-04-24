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
import 'package:tob/features/tenants/widgets/expired_tenant_card.dart';
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
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<TenantBloc>().add(FetchTenants());
                    },
                    child: BlocBuilder<TenantBloc, TenantState>(
                      builder: (context, tenantState) {
                        if (tenantState.isLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (tenantState.error != null) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Error: ${tenantState.error}',
                                  style: const TextStyle(color: Colors.red),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<TenantBloc>().add(FetchTenants());
                                  },
                                  child: const Text('Retry'),
                                ),
                              ],
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

                        return ListView.builder(
                          padding: const EdgeInsets.all(20),
                          itemCount: displayTenants.length,
                          itemBuilder: (context, index) {
                            final tenant = displayTenants[index];
                            if (selectedTab == 0) {
                              
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
                            } else {
                            return ExpiredTenantCard(
                              tenant: tenant,
                              state: state,
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
                             

                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
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
