import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tob/core/theme/app_theme.dart';
import 'package:tob/features/add_property/utils/alt_text_field.dart';
import 'package:tob/features/auth/bloc/auth_bloc.dart';
import 'package:tob/features/home/bloc/home_bloc.dart';
import 'package:tob/features/tenant_profile/bloc/_tenant_profile_bloc.dart';
import 'package:tob/features/tenant_profile/screens/widgets/info_tile_widget.dart';
import '../../../features/tenants/repositories/tenant_repository.dart';

import '../bloc/tenant_profile_event.dart';
import '../bloc/tenant_profile_state.dart';

class TenantProfileScreen extends StatelessWidget {
  final String tenantId;
  const TenantProfileScreen({super.key, required this.tenantId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          TenantProfileBloc(context.read<TenantRepository>())
            ..add(LoadTenantProfile(tenantId: tenantId)),
      child: _TenantProfileView(tenantId),
    );
  }
}

class _TenantProfileView extends StatefulWidget {
  final String tenantId;
  const _TenantProfileView(this.tenantId);

  @override
  State<_TenantProfileView> createState() => _TenantProfileViewState();
}

class _TenantProfileViewState extends State<_TenantProfileView> {
  String tenantName = '';
  String tenantEmail = '';
  String tenantPhone = '';
  String rentAmount = '';
  String unitNumber = '';
  String notes = '';
  String image = '';
  bool isActive = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(LoadHomeData());
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffF3F4F6),
      appBar: AppBar(
        title: const Text("Tenant Profile"),
        centerTitle: true,
        elevation: 0,
        actions: [
          BlocBuilder<TenantProfileBloc, TenantProfileState>(
            builder: (context, state) {
              return TextButton(
                onPressed: state is TenantProfileLoaded
                    ? () {
                        _showEditBottomSheet(context, widget.tenantId, state);
                      }
                    : null,
                child: Text(
                  "Edit",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: state is TenantProfileLoaded
                        ? theme.colorScheme.tertiaryContainer
                        : Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
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

            // Initialize form data from tenant
            tenantName = tenant.name;
            tenantEmail = tenant.email;
            tenantPhone = tenant.phone;
            unitNumber = tenant.room;
            image = tenant.avatar;

            // Extract rent amount from rentFee string (e.g., "$5000 / monthly" -> "5000")
            final rentFeeParts = tenant.rentFee.split(' ');
            rentAmount = rentFeeParts.isNotEmpty
                ? rentFeeParts[0].replaceAll('\$', '')
                : '';

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
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
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
                  InfoTile(
                    title:
                        "Rental fee ${context.watch<AuthBloc>().state.user?.currency}",
                    value: tenant.rentFee,
                  ),
                  InfoTile(
                    title: tenant.property,
                    value: tenant.room,
                    showDivider: false,
                  ),
                ]),

                const SizedBox(height: 20),

                Text(
                  "Tenancy Details",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
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
                  // InfoTile(
                  //   title: "Late fee",
                  //   value: "\$20,000",
                  //   showDivider: false,
                  // ),
                ]),

                const SizedBox(height: 20),

                Text(
                  "Tenants Report",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
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
                    valueWidget: Switch(
                      value: true,
                      onChanged: (bool value) {},
                    ),
                    showDivider: false,
                    value: '',
                  ),
                ]),
                const SizedBox(height: 30),
              ],
            );
          }

          if (state is TenantProfileSuccess) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 64),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }

          if (state is TenantProfileError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 64),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(fontSize: 18, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  void _showEditBottomSheet(
    BuildContext context,
    String tenantId,
    TenantProfileState state,
  ) {
    // Initialize form data with current tenant data
    final currentState = state;
    if (currentState is! TenantProfileLoaded) {
      // Don't show bottom sheet if tenant is not loaded
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please wait for tenant data to load'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final tenant = currentState.tenant;
    tenantName = tenant.name;
    tenantEmail = tenant.email;
    tenantPhone = tenant.phone;
    unitNumber = tenant.room;
    notes = ''; // Default empty since Tenant model doesn't have notes field

    // Extract rent amount from rentFee string
    final rentFeeParts = tenant.rentFee.split(' ');
    rentAmount = rentFeeParts.isNotEmpty
        ? rentFeeParts[0].replaceAll('\$', '')
        : '';

    statefulBottomSheetMeth(
      context: context,
      builder: (context, setState) {
        return BlocListener<TenantProfileBloc, TenantProfileState>(
          listener: (context, state) {
            if (state is TenantProfileSuccess) {
              Navigator.pop(context); // Close bottom sheet on success
              Navigator.pop(context); // Close profile screen
              // Optionally refresh the tenant list
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            height: MediaQuery.of(context).size.height * 0.9,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.lightCardColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Edit Tenant Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Form Fields
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        AltTextField(
                          label: "Name",
                          hint: "Enter name",
                          value: tenantName,
                          onChanged: (value) =>
                              setState(() => tenantName = value),
                        ),
                        AltTextField(
                          label: "Email",
                          hint: "Enter email",
                          value: tenantEmail,
                          onChanged: (value) =>
                              setState(() => tenantEmail = value),
                        ),
                        AltTextField(
                          label: "Phone",
                          hint: "Enter phone",
                          value: tenantPhone,
                          onChanged: (value) =>
                              setState(() => tenantPhone = value),
                        ),
                        AltTextField(
                          label: "Rental Fee (${ context.read<HomeBloc>().state.user?.currency})",
                          hint: "Enter rental fee",
                          value: rentAmount,
                          type: AltFieldType.number,
                          onChanged: (value) =>
                              setState(() => rentAmount = value),
                        ),
                        AltTextField(
                          label: "Property Unit",
                          hint: "Enter unit number",
                          value: unitNumber,
                          onChanged: (value) =>
                              setState(() => unitNumber = value),
                        ),
                        AltTextField(
                          label: "Notes",
                          hint: "Enter notes",
                          value: notes,
                          type: AltFieldType.multiline,
                          maxLines: 3,
                          onChanged: (value) => setState(() => notes = value),
                        ),
                        const SizedBox(height: 20),

                        // Save Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // if (currentState is ) {
                              final tenant = currentState.tenant;

                              // Prepare updated data with correct request body structure
                              final updatedData = {
                                "name": tenantName.isNotEmpty
                                    ? tenantName
                                    : tenant.name,
                                "email": tenantEmail.isNotEmpty
                                    ? tenantEmail
                                    : tenant.email,
                                "phone": tenantPhone.isNotEmpty
                                    ? tenantPhone
                                    : tenant.phone,
                                "unitNumber": unitNumber.isNotEmpty
                                    ? unitNumber
                                    : tenant.room,
                                "rentAmount": rentAmount.isNotEmpty
                                    ? double.tryParse(rentAmount) ?? 0.0
                                    : double.tryParse(
                                            tenant.rentFee
                                                .split(' ')[0]
                                                .replaceAll('\$', ''),
                                          ) ??
                                          0.0,
                                "notes": notes.isNotEmpty ? notes : '',
                                "image": tenant.avatar, // Keep existing image
                                "isActive": true, // Keep as active
                              };

                              context.read<TenantProfileBloc>().add(
                                UpdateTenant(
                                  tenantId: tenantId,
                                  updatedData: updatedData,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: currentState is TenantProfileLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Save Changes',
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void saveChanges(BuildContext context, String tenantId) {
    // Get current tenant data
    final currentState = context.read<TenantProfileBloc>().state;
    if (currentState is TenantProfileLoaded) {
      final tenant = currentState.tenant;

      // Prepare updated data with correct request body structure
      final updatedData = {
        "name": tenantName.isNotEmpty ? tenantName : tenant.name,
        "email": tenantEmail.isNotEmpty ? tenantEmail : tenant.email,
        "phone": tenantPhone.isNotEmpty ? tenantPhone : tenant.phone,
        "unitNumber": unitNumber.isNotEmpty ? unitNumber : tenant.room,
        "rentAmount": rentAmount.isNotEmpty
            ? double.tryParse(rentAmount) ?? 0.0
            : double.tryParse(
                    tenant.rentFee.split(' ')[0].replaceAll('\$', ''),
                  ) ??
                  0.0,
        "notes": notes.isNotEmpty ? notes : '',
        "image": tenant.avatar, // Keep existing image
        "isActive": true, // Keep as active
      };

      // Dispatch update event with the tenantId
      context.read<TenantProfileBloc>().add(
        UpdateTenant(tenantId: tenantId, updatedData: updatedData),
      );
    } else {}
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
