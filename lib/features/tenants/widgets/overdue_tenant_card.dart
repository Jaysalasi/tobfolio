import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tob/core/theme/app_theme.dart';
import 'package:tob/core/utils/components/constants.dart';
import 'package:tob/features/add_property/utils/alt_text_field.dart';
import 'package:tob/features/tenants/bloc/tenant_bloc.dart';
import 'package:tob/features/tenants/bloc/tenant_event.dart';
import 'package:tob/features/tenants/bloc/tenant_state.dart';
 
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
                        content: Container(
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
            AltTextField(
              label: "Rent Frequency",
              items: ["Monthly", "Quarterly", "Yearly"],
              hint: state.rentFrequency == ''
                  ? "Select rent frequency"
                  : state.rentFrequency,
              type: AltFieldType.dropdown,
              onChanged: (value) {
                print("Rent frequency: $value");
                context.read<TenantBloc>().add(UpdateRentFrequency(value));
              },
            ),
          ],
        ),
      ),
    ],
  );
}

Expanded expandedContainerMeth({
  required TenantState state,
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
