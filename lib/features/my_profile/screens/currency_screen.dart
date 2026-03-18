import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tob/core/theme/app_theme.dart';
import 'package:tob/core/utils/constants/assets/svg.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  List currencies = [
    'USD',
    'NGN',
    'EUR',
    'GBP',
    'JPY',
    'CAD',
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.tertiary,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(SvgAssets.backOutline),
        ),
        backgroundColor: theme.colorScheme.tertiary,
        title: const Text("Currency"),
      ),
      body: ListView.builder(
        itemCount: currencies.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(title: Text(currencies[index])),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(color: AppTheme.grayAltColor),
              ),
            ],
          );
        },
      ),
    );
  }
}
