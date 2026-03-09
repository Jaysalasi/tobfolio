// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tob/core/utils/components/widgets.dart';
import 'package:tob/core/utils/constants/assets/svg.dart';
import 'package:tob/features/expenses/screen/expenses_screen.dart';
import 'package:tob/features/home/screens/home_screen.dart';
import 'package:tob/features/my_profile/screens/my_profile_screen.dart';
import 'package:tob/features/rentals/screens/rentals_screen.dart'; 
import 'package:tob/features/tenants/screens/tenant_screen.dart';
import '../bloc/dashboard_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../auth/bloc/auth_bloc.dart';

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
    context.read<DashboardBloc>().add(LoadDashboardData());
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
    final theme = Theme.of(context);
    // final itemWidth = width / tabs.length;

    return WillPopScope(
  onWillPop: _onWillPop,
  child: Scaffold(
    backgroundColor: theme.colorScheme.tertiary,
    body: IndexedStack(
      index: currentIndex,
      children: screens,
    ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 20, left: 15, right: 15),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          height: 70,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(40),
            boxShadow: const [BoxShadow(blurRadius: 20, color: Colors.black12)],
          ),
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
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(30),
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
    ));
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [Text('Dashboard')],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            context.read<AuthBloc>().add(LogoutRequested());
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
                          context.read<DashboardBloc>().add(
                            LoadDashboardData(),
                          );
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    context.read<DashboardBloc>().add(LoadDashboardData());
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _WelcomeCard(
                          user: context.watch<AuthBloc>().state.user,
                        ),
                        const SizedBox(height: 24),
                        _StatsGrid(),
                        const SizedBox(height: 24),
                        _RecentActivities(),
                        const SizedBox(height: 24),
                        _QuickActions(),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  final dynamic user;

  const _WelcomeCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back,',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user?.name ?? 'User',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Here\'s what\'s happening with your account today.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _StatCard(
          title: 'Total Items',
          value: '128',
          icon: Icons.inventory_2_outlined,
          color: AppTheme.primaryColor,
        ),
        _StatCard(
          title: 'Active',
          value: '45',
          icon: Icons.check_circle_outline,
          color: Colors.green,
        ),
        _StatCard(
          title: 'Pending',
          value: '12',
          icon: Icons.pending_outlined,
          color: Colors.orange,
        ),
        _StatCard(
          title: 'Completed',
          value: '71',
          icon: Icons.task_alt_outlined,
          color: AppTheme.secondaryColor,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const Spacer(),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentActivities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activities',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Card(
          child: Column(
            children: [
              _ActivityTile(
                title: 'New item added',
                subtitle: '2 hours ago',
                icon: Icons.add_circle_outline,
                color: Colors.green,
              ),
              const Divider(height: 1),
              _ActivityTile(
                title: 'Profile updated',
                subtitle: '5 hours ago',
                icon: Icons.edit_outlined,
                color: AppTheme.primaryColor,
              ),
              const Divider(height: 1),
              _ActivityTile(
                title: 'Task completed',
                subtitle: '1 day ago',
                icon: Icons.check_circle_outline,
                color: AppTheme.secondaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _ActivityTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // Handle activity tap
      },
    );
  }
}

class _QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: plusButtonMeth(label: 'Add New', theme: Theme.of(context)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // Handle view all
                },
                icon: const Icon(Icons.list),
                label: const Text('View All'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: const Center(child: Text('Search functionality coming soon!')),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthBloc>().state.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
              child: Icon(Icons.person, size: 60, color: AppTheme.primaryColor),
            ),
            const SizedBox(height: 16),
            Text(
              user?.fname ?? 'User Name',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              user?.email ?? 'user@example.com',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onBackground.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 32),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person_outline),
                    title: const Text('Edit Profile'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Navigate to edit profile
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.notifications_outlined),
                    title: const Text('Notifications'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Navigate to notifications
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.security_outlined),
                    title: const Text('Security'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Navigate to security
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.help_outline),
                    title: const Text('Help & Support'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Navigate to help
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
