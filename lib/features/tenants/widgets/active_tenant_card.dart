import 'package:flutter/material.dart';
import 'package:tob/core/theme/app_theme.dart';
import 'package:tob/core/utils/components/constants.dart';
import 'package:tob/features/tenants/bloc/tenant_state.dart';

class ActiveTenantCard extends StatelessWidget {
  final TenantState state;
  final VoidCallback onTap;
  const ActiveTenantCard({super.key, required this.state, required this.onTap});

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
          child: Row(
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
        
                    const SizedBox(height: 8),
        
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: .65,
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
                    "Room D5",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "128 days left",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.secondaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
            )    );
        }
      
    );
  }
}
