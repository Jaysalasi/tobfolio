import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tob/core/theme/app_theme.dart';
import 'package:tob/core/utils/components/widgets.dart';
import 'package:tob/features/tenants/bloc/tenant_bloc.dart';
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
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
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      if (selectedTab == 0) {
                        return ActiveTenantCard(state: TenantState());
                      } else {
                        return OverdueTenantCard(state: TenantState());
                      }
                    },
                  ),
                ),
              ],
            );
          }
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

