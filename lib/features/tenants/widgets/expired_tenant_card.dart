import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tobfolio/core/theme/app_theme.dart';
import 'package:tobfolio/core/utils/components/app_button.dart';
import 'package:tobfolio/core/utils/components/constants.dart';
import 'package:tobfolio/core/utils/toasts.dart';
import 'package:tobfolio/features/add_property/utils/alt_text_field.dart';
import 'package:tobfolio/features/home/bloc/home_bloc.dart';
import 'package:tobfolio/features/tenants/bloc/tenant_bloc.dart';
import 'package:tobfolio/features/tenants/bloc/tenant_event.dart';
import 'package:tobfolio/features/tenants/bloc/tenant_state.dart';
import 'package:tobfolio/features/tenants/widgets/overdue_tenant_card.dart';

class ExpiredTenantCard extends StatefulWidget {
  final Map<String, dynamic> tenant;
  final TenantState state;
  final VoidCallback onTap;
  const ExpiredTenantCard({
    super.key,
    required this.tenant,
    required this.state,
    required this.onTap,
  });

  @override
  State<ExpiredTenantCard> createState() => _ExpiredTenantCardState();
}

class _ExpiredTenantCardState extends State<ExpiredTenantCard> {
  String rentEntryDate = '';
  String rentExpiryDate = '';
  String rentFrequency = '';
  String rentAmount = '';
  BuildContext? _dialogContext;
  // double _calculateProgress() {
  String _calculateDaysLeft() {
    try {
      final now = DateTime.now();
      final rentEndStr = widget.tenant['rentEnd']?.toString();
      final rentStartStr = widget.tenant['rentStart']?.toString();

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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(LoadHomeData());
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<TenantBloc, TenantState>(
      listener: (context, state) {
        if (state.isActionSuccess) {
          if (_dialogContext != null && Navigator.of(_dialogContext!).canPop()) {
            Navigator.of(_dialogContext!).pop();
            _dialogContext = null;
          }
        }
        if (state.actionError != null) {
          showError(state.actionError!);
        }
      },
      child: GestureDetector(
        onTap: widget.onTap,
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
                            widget.tenant['name'] ?? '',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const SizedBox(height: 8),
                          Text(
                            _calculateDaysLeft(),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppTheme.secondaryColor,
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
                          widget.tenant['unitNumber'] ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    expandedContainerMeth(
                      state: TenantState(),
                      theme: theme,
                      text: 'Vacate',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (dialogCtx) => StatefulBuilder(
                            builder: (dialogCtx, setDialogState) {
                              _dialogContext = dialogCtx;
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                title: Text('Are you sure?'),
                                content: const Text(
                                  'This will permanently evict your tenant. This action cannot be undone.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(dialogCtx).pop(),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      final id = widget.tenant['_id']?.toString() ?? '';
                                      context.read<TenantBloc>().add(DeleteTenant(id));
                                    },
                                    child: const Text('Vacate'),
                                  ),
                                ],
                              );
                            },
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
                          builder: (dialogCtx) => StatefulBuilder(
                            builder: (dialogCtx, setDialogState) {
                              _dialogContext = dialogCtx;
                              return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              // title: Text('Are you sure?'),
                              content: SizedBox(
                                height: 450,
                                child: Column(
                                  children: [
                                    AltTextField(
                                      label: "Rent Frequency",
                                      items: ["Monthly", "Quarterly", "Yearly"],
                                      hint: rentFrequency == ''
                                          ? "Select rent frequency"
                                          : rentFrequency,
                                      type: AltFieldType.dropdown,
                                      onChanged: (value) {
                                        setDialogState(() {
                                          rentFrequency = value;
                                        });
                                      },
                                    ),
                                    AltTextField(
                                      label: "Rent Entry Date",
                                      hint: rentEntryDate,
                                      type: AltFieldType.text,
                                      enabled: true,
                                      value: rentEntryDate,
                                      onTap: () async {
                                        final DateTime? picked =
                                            await showDatePicker(
                                              context: context,
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime.now().add(
                                                const Duration(days: 365),
                                              ),
                                            );
                                        if (picked != null) {
                                          final formattedDate = DateFormat(
                                            'yyyy-MM-dd',
                                          ).format(picked);
                                          setDialogState(() {
                                            rentEntryDate = formattedDate;
                                          });
                                        }
                                      },
                                    ),
                                    AltTextField(
                                      label: "Rent Expiry Date",
                                      hint: rentExpiryDate,
                                      type: AltFieldType.text,
                                      enabled: true,
                                      value: rentExpiryDate,
                                      onTap: () async {
                                        final DateTime? picked =
                                            await showDatePicker(
                                              context: context,
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime.now().add(
                                                const Duration(days: 3650),
                                              ),
                                            );
                                        if (picked != null) {
                                          final formattedDate = DateFormat(
                                            'yyyy-MM-dd',
                                          ).format(picked);
                                          setDialogState(() {
                                            rentExpiryDate = formattedDate;
                                          });
                                        }
                                      },
                                    ),
                                    AltTextField(
                                      label: context.read<HomeBloc>().state.user?.currency != null
                                          ? "Rental Fee (${context.read<HomeBloc>().state.user!.currency})"
                                          : "Rental Fee",
                                      hint: "Enter rental fee",
                                      value: rentAmount,
                                      type: AltFieldType.number,
                                      onChanged: (value) => setDialogState(
                                        () => rentAmount = value,
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    AppButton(
                                      isLoading: context.read<TenantBloc>().state.isLoading,
                                      title: "Renew",
                                      onPressed: () {
                                        final id = widget.tenant['_id']?.toString() ?? '';
                                        context.read<TenantBloc>().add(
                                          RenewTenant(
                                            tenantId: id,
                                            paymentFrequency: rentFrequency,
                                            rentStart: rentEntryDate,
                                            rentEnd: rentExpiryDate,
                                            rentAmount: double.tryParse(rentAmount) ?? 0,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
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
        ),
    );
  }
}
