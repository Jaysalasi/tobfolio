// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart'; 
import 'package:tobfolio/core/utils/constants/assets/svg.dart';
import 'package:tobfolio/features/expenses/screen/expenses_screen.dart';
import 'package:tobfolio/features/home/screens/home_screen.dart';
import 'package:tobfolio/features/my_profile/screens/my_profile_screen.dart';
import 'package:tobfolio/features/rentals/screens/rentals_screen.dart'; 
import 'package:tobfolio/features/tenants/screens/tenant_screen.dart';
import '../bloc/dashboard_bloc.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardBloc>().add(LoadDashboardData());
    });
  }

  final _navigatorKeys = List.generate(5, (_) => GlobalKey<NavigatorState>());

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int currentIndex = 0;

  final tabs = const [
    {
      "icon": SvgAssets.homeOutline,
      "active-icon": SvgAssets.home,
      "label": "Home",
    },
    {
      "icon": SvgAssets.rentalsOutline,
      "active-icon": SvgAssets.rentals,
      "label": "Rentals",
    },
    {
      "icon": SvgAssets.tenantsOutline,
      "active-icon": SvgAssets.tenants,
      "label": "Tenants",
    },
    {
      "icon": SvgAssets.expensesOutline,
      "active-icon": SvgAssets.expenses,
      "label": "Expenses",
    },
    {
      "icon": SvgAssets.userOutline,
      "active-icon": SvgAssets.user,
      "label": "Me",  
    },
  ];

  final screens = const [
    HomeScreen(),
    RentalsScreen(),
    TenantScreen(),
    ExpensesScreen(),
    MyProfileScreen(),
  ];
  void onTap(int index) {
    setState(() => currentIndex = index);
  }

  Future<bool> _onWillPop() async {
  final navigator = _navigatorKeys[currentIndex].currentState!;

  if (await navigator.maybePop()) {
    return false; // handled inside tab
  }

  return true; // exit app if root
}

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // final theme = Theme.of(context);
    // final itemWidth = width / tabs.length;

    return WillPopScope(
  onWillPop: _onWillPop,
  child: Scaffold(
    // backgroundColor: theme.colorScheme.tertiary,
    body: Stack(
      children: [
        IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: 
         Padding(
        padding: EdgeInsets.only(bottom: 20, left: 15, right: 15),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          height: 70,
          decoration: BoxDecoration(
            // color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(40),
            border: Border(
              top: BorderSide(color: Colors.grey, width: 0.1),
              bottom: BorderSide(color: Colors.grey, width: 0.6),
              right: BorderSide(color: Colors.grey, width: 0.6),
              left: BorderSide(color: Colors.grey, width: 0.6),
              ),
            boxShadow:  [BoxShadow(blurRadius: 20, color: Colors.white.withValues(alpha: 0.1), offset: Offset(0, 10))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX:3, sigmaY: 3),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth = constraints.maxWidth / tabs.length;
              
                  return Stack(
                    children: [
                      /// 🔥 Shifting Expanding Active Pill
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        left: currentIndex * itemWidth - 4,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                          width: itemWidth + 6,
                          height: 70,
                          padding: const EdgeInsets.all(6),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              
                      Row(
                        children: List.generate(tabs.length, (index) {
                          final isActive = currentIndex == index;
              
                          return Expanded(
                            child: GestureDetector(
                              onTap: () => onTap(index),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                padding: EdgeInsets.symmetric(
                                  vertical: isActive ? 8 : 12,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    /// 🔥 Icon Scale Animation
                                    AnimatedScale(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                      scale: isActive ? 1.0 : 0.8,
                                      child: SvgPicture.asset(
                                        height: 20,
                                        width: 20,
                                        isActive
                                            ? tabs[index]["active-icon"]!
                                            : tabs[index]["icon"]!,
                                      ),
                                    ),
              
                                    const SizedBox(height: 2),
              
                                    /// 🔥 Label Fade + Slide Animation
                                    AnimatedOpacity(
                                      duration: const Duration(milliseconds: 300),
                                      opacity: isActive ? 1 : 0.6,
                                      child: AnimatedSlide(
                                        duration: const Duration(milliseconds: 300),
                                        offset: isActive
                                            ? Offset.zero
                                            : const Offset(0, 0.2),
                                        child: Text(
                                          tabs[index]["label"] as String,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: isActive
                                                ? FontWeight.w600
                                                : FontWeight.w500,
                                            color: isActive
                                                ? Colors.black
                                                : Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
        )
      ],
    ),

      
     
    ),
    );
  }
}
  