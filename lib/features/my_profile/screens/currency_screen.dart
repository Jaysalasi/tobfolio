import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tobfolio/core/theme/app_theme.dart';
import 'package:tobfolio/core/utils/constants/assets/svg.dart';
import 'package:tobfolio/core/utils/toasts.dart';
import 'package:tobfolio/features/my_profile/bloc/currency_bloc.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  final List<String> currencies = ['USD', 'NGN', 'EUR', 'GBP', 'JPY', 'CAD'];
  String? _pendingCurrency;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<CurrencyBloc, CurrencyState>(
      listener: (context, state) {
        if (state.status == CurrencyStatus.success) {
          showSuccess('Currency updated to ${state.selectedCurrency}');
          Navigator.pop(context);
        } else if (state.status == CurrencyStatus.error) {
          setState(() => _pendingCurrency = null);
          showError(state.errorMessage ?? 'Failed to update currency');
        }
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.tertiary,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: SvgPicture.asset(SvgAssets.backOutline),
          ),
          backgroundColor: theme.colorScheme.tertiary,
          title: const Text("Currency"),
        ),
        body: ListView.builder(
          itemCount: currencies.length,
          itemBuilder: (context, index) {
            final currency = currencies[index];
            final isThisLoading = _pendingCurrency == currency;
            return Column(
              children: [
                ListTile(
                  onTap: _pendingCurrency != null
                      ? null
                      : () {
                          setState(() => _pendingCurrency = currency);
                          context
                              .read<CurrencyBloc>()
                              .add(UpdateCurrency(currency));
                        },
                  title: Text(currency),
                  trailing: isThisLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : null,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(color: AppTheme.grayAltColor),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
