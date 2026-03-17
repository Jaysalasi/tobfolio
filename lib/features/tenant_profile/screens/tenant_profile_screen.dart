import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tob/core/theme/app_theme.dart';
import 'package:tob/features/tenant_profile/bloc/_tenant_profile_bloc.dart';
import 'package:tob/features/tenant_profile/screens/widgets/info_tile_widget.dart';

import '../bloc/tenant_profile_event.dart';
import '../bloc/tenant_profile_state.dart';

class TenantProfileScreen extends StatelessWidget {
  const TenantProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TenantProfileBloc()..add(LoadTenantProfile()),
      child: const _TenantProfileView(),
    );
  }
}

class _TenantProfileView extends StatelessWidget {
  const _TenantProfileView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xffF3F4F6),
      appBar: AppBar(
        title: const Text("Tenant Profile"),
        centerTitle: true,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Edit",
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.tertiaryContainer,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<TenantProfileBloc, TenantProfileState>(
        builder: (context, state) {
          if (state is TenantProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TenantProfileLoaded) {
            final tenant = state.tenant;

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                /// Avatar
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(tenant.avatar),
                  ),
                ),

                const SizedBox(height: 12),

                Center(
                  child: Text(
                    tenant.name,
                    style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 6),

                Center(
                  child: Text(
                    "Tenant Information",
                    style: theme.textTheme.bodyMedium?.copyWith(),
                  ),
                ),

                const SizedBox(height: 20),

                _card([
                  InfoTile(
                    title: "Full Name",
                    value: tenant.name,
                    showDivider: false,
                  ),
                ]),

                const SizedBox(height: 12),

                _card([
                  InfoTile(title: "Email Address", value: tenant.email),
                  InfoTile(
                    title: "Phone Number",
                    value: tenant.phone,
                    showDivider: false,
                  ),
                ]),

                const SizedBox(height: 12),

                _card([
                  InfoTile(title: "Rental fee (USD)", value: tenant.rentFee),
                  InfoTile(
                    title: tenant.property,
                    value: tenant.room,
                    showDivider: false,
                  ),
                ]),

                const SizedBox(height: 20),

                Text(
                  "Tenancy Details",
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                _card([
                  InfoTile(
                    title: "Rent Frequency",
                    value: tenant.rentFrequency,
                  ),
                  InfoTile(
                    title: "Entry Date",
                    value: tenant.entryDate,
                    showDivider: false,
                  ),
                  InfoTile(
                    title: "Late fee",
                    value: "\$20,000",
                    showDivider: false,
                  ),
                ]),

                const SizedBox(height: 20),

                Text(
                  "Tenants Report",
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.attach_file),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tenant.documentName,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            tenant.documentSize,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                _card([
                  
                InfoTile(
                    title: "Rent Due Date Reminder",
                    isWidget: true,
                    valueWidget: Switch(value: true, onChanged: (bool value) {}),
                    showDivider: false, value: '',
                  ),
                ]),
                const SizedBox(height: 30),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _card(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.grayAltColor),
        color: AppTheme.lightSurfaceColor,
      ),
      child: Column(children: children),
    );
  }
}
