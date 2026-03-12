import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tob/core/router/app_router.dart';
import 'package:tob/core/theme/app_theme.dart';
import 'package:tob/core/utils/components/constants.dart';
import 'package:tob/core/utils/components/widgets.dart';
import 'package:tob/core/utils/constants/assets/pngs.dart';
import 'package:tob/core/utils/constants/assets/svg.dart';
import 'package:tob/features/ai/screens/ai_screen.dart';
import 'package:tob/features/auth/bloc/auth_bloc.dart';
import 'package:tob/features/home/bloc/home_bloc.dart';
import 'package:tob/features/home/screens/widgets/welcome_card_widget.dart';
import 'package:tob/features/search/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final space = MediaQuery.of(context).size;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(AppImages.roblox, width: 50, height: 50),
                    SizedBox(width: 10),
                    Text('Hi Divine'),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: SvgPicture.asset(SvgAssets.search),
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(builder: (_) => SearchScreen()),
                        );
                      },
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      child: SvgPicture.asset(SvgAssets.bell),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Logout'),
                            content: const Text(
                              'Are you sure you want to logout?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  context.read<AuthBloc>().add(
                                    LogoutRequested(),
                                  );
                                },
                                child: const Text('Logout'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : state.errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error loading data',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.errorMessage!,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<HomeBloc>().add(LoadHomeData());
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    context.read<HomeBloc>().add(LoadHomeData());
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        WelcomeCard(user: context.watch<AuthBloc>().state.user),
                        SizedBox(height: 20),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 20,
                          childAspectRatio: 1.4,
                          children: [
                            homeCardMeth(
                              icon: SvgAssets.expensesOutline,
                              title: 'Expenses',
                              subtitle: '\$3000',
                              theme: Theme.of(context),
                              context: context,
                            ),
                            homeCardMeth(
                              icon: SvgAssets.barChart,
                              title: 'NOI (Profit & Loss)',
                              subtitle: '\$2000',
                              theme: Theme.of(context),
                              context: context,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 20,
                          childAspectRatio: 1.5,
                          children: [
                            homeCardMeth(
                              icon: SvgAssets.share,
                              context: context,
                              title: 'Referral',
                              theme: Theme.of(context),
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                            homeCardMeth(
                              icon: SvgAssets.handymen,
                              title: 'Handyman',
                              theme: Theme.of(context),
                              context: context,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                            homeCardMeth(
                              icon: SvgAssets.offerUp,
                              title: 'Lease Property',
                              theme: Theme.of(context),
                              context: context,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                            homeCardMeth(
                              context: context,
                              icon: SvgAssets.aiLine,
                              title: 'AI',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AIScreen(),
                                  ),
                                );
                              },
                              theme: theme,
                              
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                constraints: BoxConstraints(
                                  maxHeight: space.height * 0.16,
                                ),
                                decoration: BoxDecoration(
                                  gradient: appGradient(context),
                                  boxShadow: appShadow(context),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: PageView(
                                        controller: _pageController,
                                        onPageChanged: (index) {
                                          setState(() {
                                            _currentPage = index;
                                          });
                                        },
                                        children: [
                                          homeOffersTickMeth(space, theme),
                                          homeOffersTickMeth(space, theme),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      spacing: 5,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [1, 2].asMap().entries.map((
                                        entry,
                                      ) {
                                        return Container(
                                          width: 10,
                                          height: 10,

                                          decoration: BoxDecoration(
                                            color: _currentPage == entry.key
                                                ? AppTheme.accentColor
                                                : AppTheme.grayColor,
                                            borderRadius: BorderRadius.circular(
                                              50,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  Row homeOffersTickMeth(Size space, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: space.width * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Exclusive offer',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: plusButtonMeth(label: "Claim", theme: theme, isIcon: false),
        ),
      ],
    );
  }
}
