import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tob/core/utils/constants/assets/svg.dart';
import 'package:tob/features/tenants/bloc/tenant_bloc.dart';
import 'package:tob/features/tenants/bloc/tenant_state.dart';

class AddTenantScreen extends StatefulWidget {
  const AddTenantScreen({super.key});

  @override
  State<AddTenantScreen> createState() => _AddTenantScreenState();
}

class _AddTenantScreenState extends State<AddTenantScreen> {
  final PageController _pageController = PageController();
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              if (_pageController.page == 0) {
                Navigator.pop(context);
              } else {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
            icon: SvgPicture.asset(SvgAssets.backOutline),
          ),
          backgroundColor: theme.colorScheme.tertiary,
          title: Text(
            "Add Tenant",
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: theme.colorScheme.tertiary,
        body: SafeArea(child: BlocBuilder<TenantBloc, TenantState>(
          builder: (context, state) {
            return PageView(
              controller: _pageController,
              children: [
                Container(
                  child: Column(
                    children: [
            
             
                  /// Avatar
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      const CircleAvatar(
                        radius: 45,
                        backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1507089947368-19c1da9775ae",
                        ),
                      ),
            
                       GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(SvgAssets.edit))
                    ],
                  ),
            
                    ],
                  ),
                ),
                Container(),
              ]);
          }
        )),
    );
  }
}