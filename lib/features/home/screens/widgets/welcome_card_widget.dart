import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tob/core/router/app_router.dart';
import 'package:tob/core/utils/components/constants.dart';
import 'package:tob/core/utils/components/widgets.dart';
import 'package:tob/core/utils/constants/assets/svg.dart';
import 'package:tob/core/utils/currency_formatter.dart';
import 'package:tob/features/home/model/dashboard_model.dart';

class WelcomeCard extends StatelessWidget {
  final dynamic user;
  final DashboardModel? dashboard;

  const WelcomeCard({super.key, required this.user, this.dashboard});
  @override
  Widget build(BuildContext context) {
    final space = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: appGradient(context),
        boxShadow: appShadow(context),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Total Income (USD)',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SvgPicture.asset(
                    SvgAssets.dropdownArrow,
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
              SizedBox(width: space.width * 0.1),
              plusButtonMeth(
                label: 'Add Property',
                theme: Theme.of(context),
                onTap: () {
                  Navigator.pushNamed(context, AppRouter.addProperty);
                },
              ),
            ],
          ),
          Text(
            CurrencyFormatter.formatCurrency(
              dashboard?.totalIncome,
              currencyCode: user?.currencyCode,
            ),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
            ),
          ),

          SizedBox(height: 4),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
